import 'dart:async';
import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../firebase_service.dart';
import 'login_screen.dart';
import 'farmer_dashboard_screen.dart';
import 'marketplace_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _handleNavigation();
  }

  Future<void> _handleNavigation() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    final service = FirebaseService();
    final uid = service.currentUserId;
    final email = service.currentUserEmail;

    if (uid != null || (email != null && email.isNotEmpty)) {
      final userDoc = (uid != null ? await service.getUser(uid) : null) ??
          (email != null ? await service.getUserByEmail(email) : null);
      if (!mounted) return;
      if (userDoc != null && userDoc['role'] != null) {
        if (userDoc['role'] == 'farmer') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const FarmerDashboardScreen()),
          );
          return;
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MarketplaceScreen()),
          );
          return;
        }
      }
    }

    // Default: new user goes to Login Screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: AppTheme.goldLight,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.goldLight.withValues(alpha: 0.35),
                    blurRadius: 25,
                    spreadRadius: 6,
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'AB',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textDark,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'AgroBuddy',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: AppTheme.goldLight,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Building smarter tools for modern\nfarming',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 36),
            const SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: AppTheme.goldLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
