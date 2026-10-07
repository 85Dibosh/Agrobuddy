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
    return _currentMockUser?['email'];
  }

  String? get currentUserName {
    if (_isFirebaseInitialized && _auth?.currentUser != null) {
      return _auth!.currentUser!.displayName;
    }
    return _currentMockUser?['fullName'] ?? 'AgroBuddy User';
  }

  String? get currentUserRole {
    return _currentMockUser?['role'];
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
      String email = googleUser.email.trim().toLowerCase();
      String name = googleUser.displayName ?? 'Google User';
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
            email = (user.email ?? email).trim().toLowerCase();
            name = user.displayName ?? name;
            photo = user.photoURL ?? photo;
          }
        } catch (authError) {
          debugPrint("Firebase Auth credential exchange notice: $authError");
        }
      }

      // Check if user already exists to retrieve their saved role
      final existingDoc = await getUser(uid) ?? await getUserByEmail(email);

      _currentMockUser = {
        'uid': uid,
        'email': email,
        'fullName': existingDoc?['fullName'] ?? name,
        'photoUrl': photo,
        if (existingDoc != null && existingDoc['role'] != null)
          'role': existingDoc['role'],
      };

      return _currentMockUser;
    } catch (e) {
      debugPrint("Google Sign-In notice: $e");
      final errStr = e.toString().toLowerCase();
      if (errStr.contains('canceled') || errStr.contains('cancelled')) {
        return null;
      }
      rethrow;
    }
  }

  // Sign in with any email (or demo accounts)
  Future<Map<String, dynamic>> signInWithEmail({
    required String email,
    String? name,
  }) async {
    final cleanEmail = email.trim().toLowerCase();
    final uid = "uid_${cleanEmail.replaceAll(RegExp(r'\W'), '_')}";

    // Check if this user exists in Firestore or locally
    final existingDoc = await getUser(uid) ?? await getUserByEmail(cleanEmail);

    final resolvedName = name ??
        existingDoc?['fullName'] ??
        (cleanEmail.contains('@') ? cleanEmail.split('@').first : 'AgroBuddy User');

    _currentMockUser = {
      'uid': uid,
      'email': cleanEmail,
      'fullName': resolvedName,
      'photoUrl': null,
      if (existingDoc != null && existingDoc['role'] != null)
        'role': existingDoc['role'],
    };

    return _currentMockUser!;
  }

  Future<Map<String, dynamic>> signInWithDemoGoogle({
    String email = linkedAccount,
    String name = "Alok Thapa",
  }) async {
    return signInWithEmail(email: email, name: name);
  }

  /// Sign out current user completely from Google and Firebase
  Future<void> signOut() async {
    try {
      await _googleSignIn.disconnect();
    } catch (_) {}
    try {
      await _googleSignIn.signOut();
    } catch (_) {}

    if (_isFirebaseInitialized && _auth != null) {
      try {
        await _auth!.signOut();
      } catch (_) {}
    }
    _currentMockUser = null;
  }

  // FIRESTORE: USERS

  // Check if a user document exists in users/ collection by UID
  Future<Map<String, dynamic>?> getUser(String uid) async {
    try {
      if (_isFirebaseInitialized && _firestore != null) {
        DocumentSnapshot doc = await _firestore!
            .collection('users')
            .doc(uid)
            .get()
            .timeout(const Duration(seconds: 4));
        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;
          data['uid'] ??= uid;
          return data;
        }
      }
    } catch (e) {
      debugPrint("Notice fetching user by UID: $e");
    }
    return _mockUsers[uid];
  }

  // Find user by email
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final target = email.trim().toLowerCase();
    try {
      if (_isFirebaseInitialized && _firestore != null) {
        final query = await _firestore!
            .collection('users')
            .where('email', isEqualTo: target)
            .limit(1)
            .get()
            .timeout(const Duration(seconds: 4));
        if (query.docs.isNotEmpty) {
          final data = query.docs.first.data();
          data['uid'] ??= query.docs.first.id;
          return data;
        }
      }
    } catch (e) {
      debugPrint("Notice fetching user by email: $e");
    }

    for (final entry in _mockUsers.values) {
      if (entry['email']?.toString().trim().toLowerCase() == target) {
        return entry;
      }
    }
    return null;
  }

  // Create or update a user profile document in users/
  Future<void> saveUser({
    required String uid,
    required Map<String, dynamic> data,
  }) async {
    try {
      data['updatedAt'] = DateTime.now().toIso8601String();
      if (data['email'] != null) {
        data['email'] = data['email'].toString().trim().toLowerCase();
      }
      if (_isFirebaseInitialized && _firestore != null) {
        await _firestore!
            .collection('users')
            .doc(uid)
            .set(data, SetOptions(merge: true))
            .timeout(const Duration(seconds: 4));
      }
      _mockUsers[uid] = Map<String, dynamic>.from(data);
      _currentMockUser = Map<String, dynamic>.from(data);
    } catch (e) {
      debugPrint("Notice saving user (saved locally): $e");
      _mockUsers[uid] = Map<String, dynamic>.from(data);
      _currentMockUser = Map<String, dynamic>.from(data);
    }
  }

  // Switch role between farmer and buyer
  Future<void> switchUserRole(String newRole) async {
    final uid = currentUserId;
    if (uid == null) return;
    final current = await getUser(uid) ?? _currentMockUser ?? {};
    current['role'] = newRole;
    current['uid'] = uid;
    await saveUser(uid: uid, data: current);
  }

  // FIRESTORE: CROPS

  // Get every crop available in the marketplace, newest first
  Future<List<Map<String, dynamic>>> getCrops() async {
    try {
      if (_isFirebaseInitialized && _firestore != null) {
        QuerySnapshot snapshot = await _firestore!
            .collection('crops')
            .orderBy('createdAt', descending: true)
            .get()
            .timeout(const Duration(seconds: 4));
        if (snapshot.docs.isNotEmpty) {
          return snapshot.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            data['id'] = doc.id;
            return data;
          }).toList();
        }
      }
      return List<Map<String, dynamic>>.from(_mockCrops);
    } catch (e) {
      debugPrint("Notice reading marketplace crops (using cached list): $e");
      return List<Map<String, dynamic>>.from(_mockCrops);
    }
  }

  // Get every crop this specific farmer has listed in their storefront
  Future<List<Map<String, dynamic>>> getCropsByFarmer(String farmerId) async {
    try {
      if (_isFirebaseInitialized && _firestore != null) {
        QuerySnapshot snapshot = await _firestore!
            .collection('crops')
            .where('farmerId', isEqualTo: farmerId)
            .get()
            .timeout(const Duration(seconds: 4));
        if (snapshot.docs.isNotEmpty) {
          return snapshot.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            data['id'] = doc.id;
            return data;
          }).toList();
        }
      }
      return _mockCrops.where((c) => c['farmerId'] == farmerId || farmerId.isEmpty).toList();
    } catch (e) {
      debugPrint("Notice fetching farmer storefront crops: $e");
      return _mockCrops.where((c) => c['farmerId'] == farmerId || farmerId.isEmpty).toList();
    }
  }

  // Read a single crop listing by its unique cropId
  Future<Map<String, dynamic>?> getCropById(String cropId) async {
    try {
      if (_isFirebaseInitialized && _firestore != null) {
        DocumentSnapshot doc = await _firestore!
            .collection('crops')
            .doc(cropId)
            .get()
            .timeout(const Duration(seconds: 4));
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.id;
          return data;
        }
      }
      return _mockCrops.firstWhere((c) => c['id'] == cropId, orElse: () => _mockCrops.first);
    } catch (e) {
      debugPrint("Notice getting crop by id: $e");
      return _mockCrops.firstWhere((c) => c['id'] == cropId, orElse: () => _mockCrops.first);
    }
  }

  // Publish a brand new crop listing to the crops/ collection
  Future<void> addCrop(Map<String, dynamic> cropData) async {
    try {
      cropData['createdAt'] = DateTime.now().toIso8601String();
      if (_isFirebaseInitialized && _firestore != null) {
        DocumentReference ref = await _firestore!
            .collection('crops')
            .add(cropData)
            .timeout(const Duration(seconds: 4));
        cropData['id'] = ref.id;
      } else {
        cropData['id'] = 'crop_${DateTime.now().millisecondsSinceEpoch}';
      }
      _mockCrops.insert(0, cropData);
    } catch (e) {
      debugPrint("Notice adding new crop listing: $e");
      cropData['id'] = 'crop_${DateTime.now().millisecondsSinceEpoch}';
      _mockCrops.insert(0, cropData);
    }
  }

  // FIRESTORE: ORDERS & BUYER CARTS

  // Write a new order document into orders/ when a buyer checks out
  Future<String> createOrder(Map<String, dynamic> orderData) async {
    try {
      orderData['createdAt'] = DateTime.now().toIso8601String();
      orderData['status'] = 'placed'; // Initial order state
      if (_isFirebaseInitialized && _firestore != null) {
        DocumentReference ref = await _firestore!
            .collection('orders')
            .add(orderData)
            .timeout(const Duration(seconds: 4));
        orderData['id'] = ref.id;
        _mockOrders.insert(0, orderData);
        return ref.id;
      } else {
        String newId = 'order_${DateTime.now().millisecondsSinceEpoch}';
        orderData['id'] = newId;
        _mockOrders.insert(0, orderData);
        return newId;
      }
    } catch (e) {
      debugPrint("Notice creating order: $e");
      String newId = 'order_${DateTime.now().millisecondsSinceEpoch}';
      orderData['id'] = newId;
      _mockOrders.insert(0, orderData);
      return newId;
    }
  }

  // Read all incoming orders placed for this farmer's crops
  Future<List<Map<String, dynamic>>> getIncomingOrders(String farmerId) async {
    try {
      if (_isFirebaseInitialized && _firestore != null) {
        QuerySnapshot snapshot = await _firestore!
            .collection('orders')
            .where('farmerId', isEqualTo: farmerId)
            .get()
            .timeout(const Duration(seconds: 4));
        if (snapshot.docs.isNotEmpty) {
          return snapshot.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            data['id'] = doc.id;
            return data;
          }).toList();
        }
      }
      return _mockOrders.where((o) => o['farmerId'] == farmerId || farmerId.isEmpty).toList();
    } catch (e) {
      debugPrint("Notice fetching incoming orders for farmer: $e");
      return _mockOrders.where((o) => o['farmerId'] == farmerId || farmerId.isEmpty).toList();
    }
  }

  // Read all orders placed by this buyer for order tracking
  Future<List<Map<String, dynamic>>> getBuyerOrders(String buyerId) async {
    try {
      if (_isFirebaseInitialized && _firestore != null) {
        QuerySnapshot snapshot = await _firestore!
            .collection('orders')
            .where('buyerId', isEqualTo: buyerId)
            .get()
            .timeout(const Duration(seconds: 4));
        if (snapshot.docs.isNotEmpty) {
          return snapshot.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            data['id'] = doc.id;
            return data;
          }).toList();
        }
      }
      return _mockOrders.where((o) => o['buyerId'] == buyerId || buyerId.isEmpty).toList();
    } catch (e) {
      debugPrint("Notice fetching buyer orders: $e");
      return _mockOrders.where((o) => o['buyerId'] == buyerId || buyerId.isEmpty).toList();
    }
  }

  // Update order status (placed -> confirmed -> in_transit -> delivered)
  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    try {
      if (_isFirebaseInitialized && _firestore != null) {
        await _firestore!
            .collection('orders')
            .doc(orderId)
            .update({'status': newStatus})
            .timeout(const Duration(seconds: 4));
      }
      int index = _mockOrders.indexWhere((o) => o['id'] == orderId);
      if (index != -1) {
        _mockOrders[index]['status'] = newStatus;
      }
    } catch (e) {
      debugPrint("Notice updating order status: $e");
    }
  }
}
