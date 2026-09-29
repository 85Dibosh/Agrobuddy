import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../firebase_service.dart';
import 'marketplace_screen.dart';

class BuyerDetailsScreen extends StatefulWidget {
  final String uid;
  final String phoneNumber;

  const BuyerDetailsScreen({
    super.key,
    required this.uid,
    required this.phoneNumber,
  });

  @override
  State<BuyerDetailsScreen> createState() => _BuyerDetailsScreenState();
}

class _BuyerDetailsScreenState extends State<BuyerDetailsScreen> {
  final _nameController = TextEditingController(text: 'Tariqul Islam');
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _handleSaveProfile() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter your full name"),
          backgroundColor: AppTheme.errorRed,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final firebaseService = FirebaseService();

    await firebaseService.saveUser(
      uid: widget.uid,
      data: {
        'uid': widget.uid,
        'role': 'buyer',
        'fullName': name,
        'phoneNumber': widget.phoneNumber,
      },
    );

    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const MarketplaceScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.darkBackground,
        title: const Text("Buyer Profile Setup"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome, Buyer!",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Complete your profile to browse fresh crops directly from local farmers.",
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textMuted,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 32),

              const Text(
                "Full Name",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "e.g. Tariqul Islam",
                  prefixIcon: Icon(Icons.person_outline, color: AppTheme.primaryGold),
                ),
              ),
              const SizedBox(height: 24),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppTheme.cardAltBackground,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.borderMuted),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle_outline, color: AppTheme.successGreen, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Verified Phone Number",
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.textMuted,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.phoneNumber,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleSaveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGold,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppTheme.textDark,
                    ),
                  )
                      : const Text(
                    "Start Browsing Market",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
