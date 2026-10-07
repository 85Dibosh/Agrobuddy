import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../firebase_service.dart';
import '../widgets/crop_card.dart';
import '../widgets/app_bottom_nav_bar.dart';
import 'product_detail_screen.dart';
import 'order_tracking_screen.dart';
import 'buyer_profile_screen.dart';
import 'notifications_screen.dart';

class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({super.key});

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  int _selectedTab = 0; // 0: Home/Market, 1: Orders, 2: Profile
  bool _isLoading = true;
  List<Map<String, dynamic>> _crops = [];
  String _searchQuery = "";
  String _selectedFilter = "All";

  @override
  void initState() {
    super.initState();
    _fetchMarketplaceCrops();
  }

  // Get every crop available in the marketplace, newest first from Firestore
  Future<void> _fetchMarketplaceCrops() async {
    setState(() => _isLoading = true);
    final service = FirebaseService();
    try {
      // Query all crops collection
      final crops = await service.getCrops();
      if (mounted) {
        setState(() {
          _crops = crops;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  List<Map<String, dynamic>> get _filteredCrops {
    return _crops.where((crop) {
      final name = (crop['cropName'] ?? '').toString().toLowerCase();
      final farmer = (crop['farmerName'] ?? '').toString().toLowerCase();
      final type = (crop['farmingType'] ?? '').toString();
      final matchesSearch = name.contains(_searchQuery.toLowerCase()) ||
          farmer.contains(_searchQuery.toLowerCase());
      final matchesFilter = _selectedFilter == "All" || type == _selectedFilter;
      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppTheme.goldLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          "AB",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        "Marketplace",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications_none, color: Colors.white70),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const NotificationsScreen()),
                          );
                        },
                      ),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const BuyerProfileScreen()),
                          );
                        },
                        child: const CircleAvatar(
                          radius: 18,
                          backgroundColor: AppTheme.cardHighlight,
                          child: Icon(Icons.person, color: AppTheme.primaryGold, size: 20),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // SEARCH BAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppTheme.cardAltBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.white54),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        onChanged: (val) => setState(() => _searchQuery = val),
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                        decoration: const InputDecoration(
                          hintText: "Search crops, farmers...",
                          hintStyle: TextStyle(color: Colors.white54, fontSize: 14),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          filled: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // FILTER CHIPS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  _buildFilterChip("All"),
                  const SizedBox(width: 8),
                  _buildFilterChip("Organic"),
                  const SizedBox(width: 8),
                  _buildFilterChip("Conventional"),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // CROP GRID
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: AppTheme.primaryGold),
                    )
                  : _filteredCrops.isEmpty
                      ? const Center(
                          child: Text(
                            "No crops found matching your search.",
                            style: TextStyle(color: AppTheme.textMuted),
                          ),
                        )
                      : RefreshIndicator(
                          color: AppTheme.primaryGold,
                          onRefresh: _fetchMarketplaceCrops,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 0.76,
                              ),
                              itemCount: _filteredCrops.length,
                              itemBuilder: (context, index) {
                                final crop = _filteredCrops[index];
                                return MarketplaceCropCard(
                                  cropName: crop['cropName'] ?? 'Crop',
                                  pricePerKg: (crop['pricePerKg'] as num?)?.toDouble() ?? 45.0,
                                  availableKg: (crop['availableKg'] as num?)?.toDouble() ?? 100.0,
                                  farmerName: crop['farmerName'] ?? 'Local Farmer',
                                  imagePath: crop['imagePath'],
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ProductDetailScreen(crop: crop),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _selectedTab,
        onTap: (index) {
          if (index == 0) {
            setState(() => _selectedTab = 0);
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const OrderTrackingScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BuyerProfileScreen()),
            );
          }
        },
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.goldLight : AppTheme.cardAltBackground,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white70,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
