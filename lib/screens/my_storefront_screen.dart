import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../firebase_service.dart';
import '../widgets/crop_card.dart';
import '../widgets/storefront_empty_state.dart';
import '../widgets/app_bottom_nav_bar.dart';
import 'add_new_crop_screen.dart';
import 'farmer_dashboard_screen.dart';
import 'farmer_profile_screen.dart';
import 'notifications_screen.dart';

class MyStorefrontScreen extends StatefulWidget {
  const MyStorefrontScreen({super.key});

  @override
  State<MyStorefrontScreen> createState() => _MyStorefrontScreenState();
}

class _MyStorefrontScreenState extends State<MyStorefrontScreen> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _farmerCrops = [];

  @override
  void initState() {
    super.initState();
    _fetchStorefrontCrops();
  }

  // Get every crop this farmer has listed from Firestore
  Future<void> _fetchStorefrontCrops() async {
    setState(() => _isLoading = true);
    final service = FirebaseService();
    final farmerId = service.currentUserId ?? 'mock_farmer_1';

    try {
      // Query crops collection where farmerId matches the logged-in farmer
      final crops = await service.getCropsByFarmer(farmerId);
      if (mounted) {
        setState(() {
          _farmerCrops = crops;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceDark,
      appBar: AppBar(
        backgroundColor: AppTheme.surfaceDark,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: AppTheme.cardAltBackground,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        titleSpacing: 4,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: const BoxDecoration(
                color: AppTheme.primaryGold,
                shape: BoxShape.circle,
              ),
              child: const Text(
                'AB',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'AgroBuddy',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'serif',
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: const BoxDecoration(
              color: AppTheme.cardAltBackground,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.notifications_none, color: Colors.white70, size: 20),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NotificationsScreen()),
                );
              },
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppTheme.primaryGold),
            )
          : _farmerCrops.isEmpty
              // Empty State branched automatically when results are 0
              ? StorefrontEmptyState(
                  onAddCropPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AddNewCropScreen()),
                    );
                    _fetchStorefrontCrops();
                  },
                )
              // Populated list of crops
              : RefreshIndicator(
                  color: AppTheme.primaryGold,
                  onRefresh: _fetchStorefrontCrops,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'My Storefront',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'serif',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${_farmerCrops.length} active listings receiving buyer orders',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.textMuted,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // List of active crop cards
                        for (var crop in _farmerCrops) ...[
                          StorefrontCropCard(
                            title: crop['cropName'] ?? crop['title'] ?? 'Crop',
                            pricePerKg: (crop['pricePerKg'] as num?)?.toDouble() ?? 45.0,
                            availableKg: (crop['availableKg'] as num?)?.toDouble() ?? 100.0,
                            imagePath: crop['imagePath'] ?? 'assets/images/storefront/tomatoes.png',
                          ),
                          const SizedBox(height: 16),
                        ],

                        const SizedBox(height: 12),

                        // Add Crop Floating/Fixed Action Button
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const AddNewCropScreen()),
                              );
                              _fetchStorefrontCrops();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryGold,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add, color: AppTheme.textDark, size: 22),
                                SizedBox(width: 8),
                                Text(
                                  "Add New Crop",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.textDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const FarmerDashboardScreen()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const FarmerProfileScreen()),
            );
          }
        },
      ),
    );
  }
}
