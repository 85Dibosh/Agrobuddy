import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
static final FirebaseService _instance = FirebaseService._internal();
  factory FirebaseService() => _instance;
  FirebaseService._internal();

  static const String linkedAccount = "thaparocks47@gmail.com";

  bool _isFirebaseInitialized = false;
  FirebaseAuth? _auth;
  FirebaseFirestore? _firestore;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // In-memory fallback stores for testing before cloud sync
  final Map<String, Map<String, dynamic>> _mockUsers = {};
  final List<Map<String, dynamic>> _mockCrops = [
    {
      'id': 'crop_1',
      'farmerId': 'farmer_fahim',
      'farmerName': 'Fahim Karim',
      'cropName': 'Roma Tomatoes',
      'pricePerKg': 45.0,
      'availableKg': 1200.0,
      'farmingType': 'Organic',
      'imagePath': 'assets/images/storefront/tomatoes.png',
      'description': 'Freshly harvested ripe organic red tomatoes from Bogura.',
      'location': 'Bogura, Rajshahi',
      'createdAt': DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
    },
    {
      'id': 'crop_2',
      'farmerId': 'farmer_fahim',
      'farmerName': 'Fahim Karim',
      'cropName': 'Organic Rice',
      'pricePerKg': 70.0,
      'availableKg': 800.0,
      'farmingType': 'Organic',
      'imagePath': 'assets/images/storefront/rice.png',
      'description': 'High quality Aman paddy rice processed naturally.',
      'location': 'Dinajpur',
      'createdAt': DateTime.now().subtract(const Duration(hours: 12)).toIso8601String(),
    },
    {
      'id': 'crop_3',
      'farmerId': 'farmer_rafiq',
      'farmerName': 'Rafiqul Islam',
      'cropName': 'Green Chilli',
      'pricePerKg': 95.0,
      'availableKg': 350.0,
      'farmingType': 'Conventional',
      'imagePath': 'assets/images/storefront/chilli.png',
      'description': 'Spicy fresh local green chillies, handpicked.',
      'location': 'Rangpur',
      'createdAt': DateTime.now().subtract(const Duration(hours: 4)).toIso8601String(),
    },
  ];

  final List<Map<String, dynamic>> _mockOrders = [
    {
      'id': 'order_1',
      'buyerId': 'buyer_tariq',
      'buyerName': 'Tariqul Islam',
      'farmerId': 'farmer_fahim',
      'farmerName': 'Fahim Karim',
      'cropId': 'crop_1',
      'cropName': 'Roma Tomatoes',
      'quantityKg': 50.0,
      'totalPrice': 2250.0,
      'status': 'placed',
      'deliveryAddress': 'Sector 3, Uttara, Dhaka',
      'createdAt': DateTime.now().subtract(const Duration(minutes: 45)).toIso8601String(),
    },
    {
      'id': 'order_2',
      'buyerId': 'buyer_kamrul',
      'buyerName': 'Kamrul Hasan',
      'farmerId': 'farmer_fahim',
      'farmerName': 'Fahim Karim',
      'cropId': 'crop_2',
      'cropName': 'Organic Rice',
      'quantityKg': 100.0,
      'totalPrice': 7000.0,
      'status': 'confirmed',
      'deliveryAddress': 'Banani, Dhaka',
      'createdAt': DateTime.now().subtract(const Duration(hours: 3)).toIso8601String(),
    },
  ];

  Map<String, dynamic>? _currentMockUser;

  Future<void> initialize() async {
    try {
      await Firebase.initializeApp();
      _auth = FirebaseAuth.instance;
      _firestore = FirebaseFirestore.instance;
      _isFirebaseInitialized = true;
      debugPrint("Firebase successfully initialized for account: $linkedAccount");

      // Seed sample crops & orders to Firestore in the background
      unawaited(seedInitialDataToFirestore());
    } catch (e) {
      debugPrint("Firebase initialized with local fallback ($e).");
      _isFirebaseInitialized = false;
    }
  }

  Future<void> seedInitialDataToFirestore() async {
    if (!_isFirebaseInitialized || _firestore == null) return;
    try {
      debugPrint("Syncing initial farmer crops and buyer orders to Cloud Firestore...");

      // 1. Upload sample crops into crops/
      for (final crop in _mockCrops) {
        await _firestore!
            .collection('crops')
            .doc(crop['id'])
            .set(crop, SetOptions(merge: true))
            .timeout(const Duration(seconds: 4));
      }

      // 2. Upload sample orders into orders/
      for (final order in _mockOrders) {
        await _firestore!
            .collection('orders')
            .doc(order['id'])
            .set(order, SetOptions(merge: true))
            .timeout(const Duration(seconds: 4));
      }

      // 3. Upload a sample profile into users/
      await _firestore!
          .collection('users')
          .doc('sample_farmer_thapa')
          .set({
        'uid': 'sample_farmer_thapa',
        'email': linkedAccount,
        'fullName': 'Alok Thapa (Demo Farmer)',
        'role': 'farmer',
        'location': 'Bogura, Rajshahi',
        'farmArea': 4.5,
        'phoneNumber': '+8801712345678',
        'trustScore': 98,
        'updatedAt': DateTime.now().toIso8601String(),
      }, SetOptions(merge: true))
          .timeout(const Duration(seconds: 4));

      debugPrint("Cloud Firestore seeded successfully! Check crops, orders, and users collections.");
    } catch (e) {
      debugPrint("Firestore seed notice (will retry when online/created): $e");
    }
  }


  // GOOGLE SIGN-IN

  String? get currentUserId {
    if (_isFirebaseInitialized && _auth?.currentUser != null) {
      return _auth!.currentUser!.uid;
    }
    return _currentMockUser?['uid'];
  }

  String? get currentUserEmail {
    if (_isFirebaseInitialized && _auth?.currentUser != null) {
      return _auth!.currentUser!.email;
    }
    return _currentMockUser?['email'] ?? linkedAccount;
  }

  String? get currentUserName {
    if (_isFirebaseInitialized && _auth?.currentUser != null) {
      return _auth!.currentUser!.displayName;
    }
    return _currentMockUser?['fullName'] ?? 'AgroBuddy User';
  }

  Map<String, dynamic>? get currentUserData => _currentMockUser;

  // Sign in with real Google Account
  Future<Map<String, dynamic>?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User dismissed the Google sign-in prompt
        return null;
      }

      String uid = 'google_${googleUser.id}';
      String? email = googleUser.email;
      String? name = googleUser.displayName;
      String? photo = googleUser.photoUrl;

      if (_isFirebaseInitialized && _auth != null) {
        try {
          final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          final UserCredential userCredential = await _auth!
              .signInWithCredential(credential)
              .timeout(const Duration(seconds: 5));
          final User? user = userCredential.user;

          if (user != null) {
            uid = user.uid;
            email = user.email ?? email;
            name = user.displayName ?? name;
            photo = user.photoURL ?? photo;
          }
        } catch (authError) {
          debugPrint("Firebase Auth credential exchange notice: $authError");
        }
      }

      _currentMockUser = {
        'uid': uid,
        'email': email ?? linkedAccount,
        'fullName': name ?? 'Google User',
        'photoUrl': photo,
      };

      // Seed initial data to Firestore
      unawaited(seedInitialDataToFirestore());

      return _currentMockUser;
    } catch (e) {
      debugPrint("Google Sign-In notice: $e. Falling back smoothly.");
      final errStr = e.toString().toLowerCase();
      if (errStr.contains('canceled') || errStr.contains('cancelled')) {
        return null;
      }
      return signInWithDemoGoogle();
    }
  }

  Future<Map<String, dynamic>> signInWithDemoGoogle({
    String email = linkedAccount,
    String name = "Alok Thapa",
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final uid = "uid_${email.replaceAll(RegExp(r'\W'), '_')}";
    _currentMockUser = {
      'uid': uid,
      'email': email,
      'fullName': name,
      'photoUrl': null,
    };
    unawaited(seedInitialDataToFirestore());
    return _currentMockUser!;
  }

  /// Sign out current user from Google and Firebase
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (_) {}

    if (_isFirebaseInitialized && _auth != null) {
      await _auth!.signOut();
    }
    _currentMockUser = null;
  }

}
