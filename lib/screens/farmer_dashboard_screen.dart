import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../firebase_service.dart';
import '../widgets/stat_card.dart';
import '../widgets/app_bottom_nav_bar.dart';
import 'farmer_profile_screen.dart';
import 'my_storefront_screen.dart';
import 'add_new_crop_screen.dart';
import 'incoming_orders_screen.dart';
import 'notifications_screen.dart';

class FarmerDashboardScreen extends StatefulWidget {
  const FarmerDashboardScreen({super.key});

  @override
  State<FarmerDashboardScreen> createState() => _FarmerDashboardScreenState();
}

class _FarmerDashboardScreenState extends State<FarmerDashboardScreen> {
  int _selectedTab = 0; // 0: Home, 1: Market (Storefront), 2: Profile
  String _farmerName = "Fahim Karim";
  String _farmerLocation = "Bogura, Rajshahi";
  int _trustScore = 94;
  double _farmArea = 4.5;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFarmerData();
  }

  Future<void> _loadFarmerData() async {
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
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.darkBackground,
        leading: Row(
          children: [
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: AppTheme.secondaryGold,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  'AB',
                  style: TextStyle(
                    color: AppTheme.darkBackground,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        title: const Text(
          "AgroBuddy",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: 'serif',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: AppTheme.textMuted),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationsScreen()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: AppTheme.primaryGold),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    // Welcome & Weather Card
                    Card(
                      color: AppTheme.cardBackground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(color: AppTheme.secondaryGold),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Welcome back, $_farmerName",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _farmerLocation,
                                    style: const TextStyle(
                                      color: AppTheme.textMuted,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppTheme.pillBackground,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.wb_sunny_outlined,
                                    color: AppTheme.secondaryGold,
                                    size: 18,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    "28°C Bogura",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Metric Stat Cards Row
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            title: "Trust Score",
                            value: "$_trustScore%",
                            subtitle: "Trust Score",
                            icon: Icons.verified_user_outlined,
                            iconColor: AppTheme.secondaryGold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: StatCard(
                            title: "Farm Area",
                            value: "$_farmArea Ac",
                            subtitle: "Farm Area",
                            icon: Icons.landscape_outlined,
                            iconColor: Colors.blueAccent,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: StatCard(
                            title: "Experience",
                            value: "12+ Years",
                            subtitle: "Experience",
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Quick Operations",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Operation 1: Add New Crop Listing
                    _buildOperationTile(
                      icon: Icons.add_circle_outline,
                      title: "Add New Crop Listing",
                      subtitle: "Publish harvest to buyers",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const AddNewCropScreen()),
                        );
                      },
                    ),

                    // Operation 2: My Storefront & Inventory
                    _buildOperationTile(
                      icon: Icons.storefront,
                      title: "My Storefront & Inventory",
                      subtitle: "View and manage active listings",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const MyStorefrontScreen()),
                        );
                      },
                    ),

                    // Operation 3: Incoming Orders
                    _buildOperationTile(
                      icon: Icons.receipt_long,
                      title: "Incoming Orders",
                      subtitle: "Buyer orders for your listed crops",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const IncomingOrdersScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _selectedTab,
        onTap: (index) {
          if (index == 0) {
            // Already on Home
            setState(() => _selectedTab = 0);
          } else if (index == 1) {
            // Navigate to Market / Storefront
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MyStorefrontScreen()),
            );
          } else if (index == 2) {
            // Navigate to Profile
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FarmerProfileScreen()),
            );
          }
        },
      ),
    );
  }

  Widget _buildOperationTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      color: AppTheme.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppTheme.pillBackground,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppTheme.secondaryGold),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: AppTheme.textMuted,
            fontSize: 12,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 14,
          color: AppTheme.textMuted,
        ),
        onTap: onTap,
      ),
    );
  }
}
