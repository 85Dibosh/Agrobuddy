import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../firebase_service.dart';
import '../widgets/stat_card.dart';
import '../widgets/app_bottom_nav_bar.dart';
import 'farmer_dashboard_screen.dart';
import 'my_storefront_screen.dart';
import 'settings_screen.dart';
import 'feedback_screen.dart';
import 'login_screen.dart';

class FarmerProfileScreen extends StatefulWidget {
  const FarmerProfileScreen({super.key});

  @override
  State<FarmerProfileScreen> createState() => _FarmerProfileScreenState();
}

class _FarmerProfileScreenState extends State<FarmerProfileScreen> {
  String _farmerName = "Fahim Karim";
  String _farmerLocation = "Bogura, Rajshahi";
  double _farmArea = 4.5;
  int _trustScore = 94;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final service = FirebaseService();
    final uid = service.currentUserId;
    final email = service.currentUserEmail;
    final userDoc = (uid != null ? await service.getUser(uid) : null) ??
        (email != null ? await service.getUserByEmail(email) : null);
    if (userDoc != null && mounted) {
      setState(() {
        _farmerName = userDoc['fullName'] ?? _farmerName;
        _farmerLocation = userDoc['location'] ?? _farmerLocation;
        _farmArea = (userDoc['farmArea'] as num?)?.toDouble() ?? _farmArea;
        _trustScore = (userDoc['trustScore'] as num?)?.toInt() ?? _trustScore;
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
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            decoration: const BoxDecoration(
              color: AppTheme.cardAltBackground,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 18),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              // Avatar with verified badge
              Center(
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppTheme.cardHighlight, width: 3),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/storefront/tomatoes.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: 100,
                            height: 100,
                            color: AppTheme.pillBackground,
                            child: const Icon(Icons.person, color: AppTheme.primaryGold, size: 50),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppTheme.primaryGold,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: AppTheme.textDark,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Name and Verified Tag
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _farmerName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.cardAltBackground,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.primaryGold.withValues(alpha: 0.4)),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.verified, color: AppTheme.primaryGold, size: 14),
                        SizedBox(width: 4),
                        Text(
                          "Verified",
                          style: TextStyle(
                            color: AppTheme.primaryGold,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 6),

              // Location
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on, color: AppTheme.primaryGold, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    _farmerLocation,
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // Metric Stat Cards
              Row(
                children: [
                  Expanded(
                    child: StatCard(
                      title: "Farm Area",
                      value: "$_farmArea",
                      subtitle: "Acres",
                      icon: Icons.landscape_outlined,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: StatCard(
                      title: "Trust Score",
                      value: "$_trustScore%",
                      subtitle: "Verified",
                      icon: Icons.verified_user_outlined,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: StatCard(
                      title: "Experience",
                      value: "12+",
                      subtitle: "Years",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Profile Actions
              _buildProfileOption(
                icon: Icons.support_agent,
                title: "Feedback & Support",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const FeedbackScreen()),
                  );
                },
              ),
              _buildProfileOption(
                icon: Icons.settings_outlined,
                title: "App Settings",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SettingsScreen()),
                  );
                },
              ),
              _buildProfileOption(
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
              MaterialPageRoute(builder: (_) => const FarmerDashboardScreen()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MyStorefrontScreen()),
            );
          }
        },
      ),
    );
  }

  Widget _buildProfileOption({
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
