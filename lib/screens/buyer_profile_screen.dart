import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../firebase_service.dart';
import '../widgets/app_bottom_nav_bar.dart';
import 'marketplace_screen.dart';
import 'order_tracking_screen.dart';
import 'settings_screen.dart';
import 'feedback_screen.dart';
import 'login_screen.dart';

class BuyerProfileScreen extends StatefulWidget {
  const BuyerProfileScreen({super.key});

  @override
  State<BuyerProfileScreen> createState() => _BuyerProfileScreenState();
}

class _BuyerProfileScreenState extends State<BuyerProfileScreen> {
  String _buyerName = "Tariqul Islam";
  String _phoneNumber = "+8801712345678";
  int _orderCount = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBuyerProfile();
  }

  Future<void> _loadBuyerProfile() async {
    final service = FirebaseService();
    final uid = service.currentUserId;
    final email = service.currentUserEmail;

    // Query user profile from Firestore
    final userDoc = (uid != null ? await service.getUser(uid) : null) ??
        (email != null ? await service.getUserByEmail(email) : null);
    if (userDoc != null && mounted) {
      _buyerName = userDoc['fullName'] ?? _buyerName;
      _phoneNumber = userDoc['phoneNumber'] ?? _phoneNumber;
    }

    final buyerId = uid ?? userDoc?['uid'] ?? 'mock_buyer_1';
    // Read all orders placed by this buyer from Firestore
    final orders = await service.getBuyerOrders(buyerId);
    if (mounted) {
      setState(() {
        _orderCount = orders.length;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceDark,
      appBar: AppBar(
        backgroundColor: AppTheme.surfaceDark,
        elevation: 0,
        title: const Text("Buyer Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white70),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: AppTheme.primaryGold))
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    // Buyer Avatar
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppTheme.cardHighlight, width: 3),
                        ),
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundColor: AppTheme.pillBackground,
                          child: Icon(Icons.person, color: AppTheme.primaryGold, size: 55),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Text(
                      _buyerName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.phone, color: AppTheme.primaryGold, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          _phoneNumber,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.textMuted,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Order summary card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.cardAltBackground,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.borderMuted),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                "$_orderCount",
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primaryGold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "Total Orders",
                                style: TextStyle(color: AppTheme.textMuted, fontSize: 12),
                              ),
                            ],
                          ),
                          Container(width: 1, height: 36, color: AppTheme.borderMuted),
                          const Column(
                            children: [
                              Text(
                                "Verified",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.successGreen,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Buyer Status",
                                style: TextStyle(color: AppTheme.textMuted, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Option items
                    _buildOptionTile(
                      icon: Icons.local_shipping_outlined,
                      title: "My Orders & Tracking",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const OrderTrackingScreen()),
                        );
                      },
                    ),
                    _buildOptionTile(
                      icon: Icons.support_agent,
                      title: "Feedback & Support",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const FeedbackScreen()),
                        );
                      },
                    ),
                    _buildOptionTile(
                      icon: Icons.settings_outlined,
                      title: "App Settings",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SettingsScreen()),
                        );
                      },
                    ),
                    _buildOptionTile(
                      icon: Icons.logout,
                      title: "Sign Out",
                      textColor: AppTheme.errorRed,
                      iconColor: AppTheme.errorRed,
                      onTap: () async {
                        await FirebaseService().signOut();
                        if (!context.mounted) return;
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MarketplaceScreen()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const OrderTrackingScreen()),
            );
          }
        },
      ),
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    Color? textColor,
    Color? iconColor,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: AppTheme.cardAltBackground,
        borderRadius: BorderRadius.circular(14),
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          leading: Icon(icon, color: iconColor ?? AppTheme.primaryGold),
          title: Text(
            title,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: AppTheme.textMuted),
          onTap: onTap,
        ),
      ),
    );
  }
}
