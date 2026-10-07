import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../firebase_service.dart';
import 'complete_profile_screen.dart';
import 'farmer_dashboard_screen.dart';
import 'marketplace_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _routeUser(Map<String, dynamic> userMap) async {
    final firebaseService = FirebaseService();
    final uid = userMap['uid'] as String;
    final email = (userMap['email'] as String?)?.toLowerCase().trim() ?? '';

    // Check by UID first, then by email
    final existingUser = await firebaseService.getUser(uid) ??
        (email.isNotEmpty ? await firebaseService.getUserByEmail(email) : null);

    if (!mounted) return;
    setState(() => _isLoading = false);

    final role = existingUser?['role'] ?? userMap['role'];

    if (role != null) {
      if (role == 'farmer') {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const FarmerDashboardScreen()),
          (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MarketplaceScreen()),
          (route) => false,
        );
      }
    } else {
      // New user -> prompt to input role and profile details
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => CompleteProfileScreen(googleUser: userMap),
        ),
      );
    }
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isLoading = true);

    try {
      final firebaseService = FirebaseService();
      final googleUser = await firebaseService.signInWithGoogle();

      if (!mounted) return;

      if (googleUser == null) {
        // User cancelled sign-in or dismissed the popup
        setState(() => _isLoading = false);
        return;
      }

      await _routeUser(googleUser);
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      _showAccountSelectionSheet(
        title: "Choose an Account",
        message: "Google Play Services sign-in was interrupted. Select or enter any email to continue:",
      );
    }
  }

  Future<void> _handleEmailSignIn(String email) async {
    final cleanEmail = email.trim();
    if (cleanEmail.isEmpty || !cleanEmail.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid email address"),
          backgroundColor: AppTheme.errorRed,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final firebaseService = FirebaseService();
      final userMap = await firebaseService.signInWithEmail(email: cleanEmail);
      if (!mounted) return;
      await _routeUser(userMap);
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Sign-in issue: $e"),
            backgroundColor: AppTheme.errorRed,
          ),
        );
      }
    }
  }

  void _showAccountSelectionSheet({required String title, required String message}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cardBackground,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        final customController = TextEditingController();
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                message,
                style: const TextStyle(color: AppTheme.textMuted, fontSize: 13),
              ),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  backgroundColor: AppTheme.pillBackground,
                  child: Icon(Icons.eco, color: AppTheme.primaryGold),
                ),
                title: const Text("Farmer Account", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: const Text(FirebaseService.linkedAccount, style: TextStyle(color: AppTheme.textMuted, fontSize: 12)),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: AppTheme.textMuted),
                onTap: () {
                  Navigator.pop(ctx);
                  _handleEmailSignIn(FirebaseService.linkedAccount);
                },
              ),
              const Divider(color: AppTheme.borderMuted),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  backgroundColor: AppTheme.pillBackground,
                  child: Icon(Icons.shopping_cart, color: AppTheme.secondaryGold),
                ),
                title: const Text("Buyer Account", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: const Text("buyer@agrobuddy.com", style: TextStyle(color: AppTheme.textMuted, fontSize: 12)),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: AppTheme.textMuted),
                onTap: () {
                  Navigator.pop(ctx);
                  _handleEmailSignIn("buyer@agrobuddy.com");
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: customController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Or enter another email...",
                  hintStyle: const TextStyle(color: AppTheme.textMuted),
                  filled: true,
                  fillColor: AppTheme.cardAltBackground,
                  prefixIcon: const Icon(Icons.mail_outline, color: AppTheme.primaryGold),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    final email = customController.text.trim();
                    if (email.isNotEmpty) {
                      Navigator.pop(ctx);
                      _handleEmailSignIn(email);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGold,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                  child: const Text("Continue with this Email", style: TextStyle(color: AppTheme.textDark, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // Circular AB Brand Logo
              Container(
                width: 86,
                height: 86,
                decoration: BoxDecoration(
                  color: AppTheme.goldLight,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.goldLight.withValues(alpha: 0.35),
                      blurRadius: 30,
                      spreadRadius: 8,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'AB',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'AgroBuddy',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.goldLight,
                  fontFamily: 'serif',
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Direct Farm-to-Buyer Marketplace',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Sign in to manage harvests or source fresh local produce.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: AppTheme.textMuted,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 36),

              // Primary "Sign in with Google" button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleGoogleSignIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 2,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black87),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue.shade50,
                              ),
                              child: const Text(
                                'G',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.blueAccent,
                                  fontFamily: 'sans-serif',
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            const Text(
                              'Continue with Google',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                ),
              ),

              const SizedBox(height: 24),

              // OR divider
              Row(
                children: [
                  const Expanded(child: Divider(color: AppTheme.borderMuted)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "OR CONTINUE WITH EMAIL",
                      style: TextStyle(
                        color: AppTheme.textMuted.withValues(alpha: 0.8),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider(color: AppTheme.borderMuted)),
                ],
              ),

              const SizedBox(height: 20),

              // Email input field
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.white, fontSize: 15),
                decoration: InputDecoration(
                  hintText: "Enter your email address",
                  hintStyle: const TextStyle(color: AppTheme.textMuted),
                  filled: true,
                  fillColor: AppTheme.cardBackground,
                  prefixIcon: const Icon(Icons.email_outlined, color: AppTheme.primaryGold),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppTheme.borderMuted),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppTheme.borderMuted),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppTheme.primaryGold),
                  ),
                ),
                onSubmitted: (val) => _handleEmailSignIn(val),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : () => _handleEmailSignIn(_emailController.text),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGold,
                    foregroundColor: AppTheme.textDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    "Sign In with Email",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Quick account switcher chips for easy testing
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Quick Demo Accounts:",
                  style: TextStyle(
                    color: AppTheme.textMuted,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _isLoading ? null : () => _handleEmailSignIn(FirebaseService.linkedAccount),
                      icon: const Icon(Icons.eco, size: 16, color: AppTheme.primaryGold),
                      label: const Text(
                        "Farmer",
                        style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppTheme.borderMuted),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _isLoading ? null : () => _handleEmailSignIn("buyer@agrobuddy.com"),
                      icon: const Icon(Icons.shopping_bag_outlined, size: 16, color: AppTheme.secondaryGold),
                      label: const Text(
                        "Buyer",
                        style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppTheme.borderMuted),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
