import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../firebase_service.dart';
import '../widgets/app_bottom_nav_bar.dart';
import 'marketplace_screen.dart';
import 'buyer_profile_screen.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _orders = [];

  @override
  void initState() {
    super.initState();
    _fetchBuyerOrders();
  }

  // Read all orders placed by this buyer from Firestore
  Future<void> _fetchBuyerOrders() async {
    setState(() => _isLoading = true);
    final service = FirebaseService();
    final buyerId = service.currentUserId ?? 'mock_buyer_1';

    try {
      // Query orders where buyerId == logged-in buyer
      final orders = await service.getBuyerOrders(buyerId);
      if (mounted) {
        setState(() {
          _orders = orders;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  int _getStatusStep(String status) {
    switch (status.toLowerCase()) {
      case 'placed':
        return 1;
      case 'confirmed':
        return 2;
      case 'in_transit':
        return 3;
      case 'delivered':
        return 4;
      default:
        return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.darkBackground,
        title: const Text("Track Orders"),
        leading: Container(
          margin: const EdgeInsets.all(8),
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
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: AppTheme.primaryGold),
              )
            : RefreshIndicator(
                color: AppTheme.primaryGold,
                onRefresh: _fetchBuyerOrders,
                child: _orders.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.local_shipping_outlined, size: 60, color: AppTheme.textMuted.withValues(alpha: 0.5)),
                            const SizedBox(height: 16),
                            const Text(
                              "No active orders found",
                              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Orders you place in the marketplace will appear here.",
                              style: TextStyle(color: AppTheme.textMuted, fontSize: 13),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        itemCount: _orders.length,
                        itemBuilder: (context, index) {
                          final order = _orders[index];
                          final status = order['status'] ?? 'placed';
                          final currentStep = _getStatusStep(status);

                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppTheme.cardAltBackground,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppTheme.borderMuted),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      order['cropName'] ?? 'Crop',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "৳ ${(order['totalPrice'] as num?)?.toStringAsFixed(0) ?? '0'}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.primaryGold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Quantity: ${(order['quantityKg'] as num?)?.toInt() ?? 0} kg • ${order['deliveryAddress'] ?? 'Dhaka'}",
                                  style: const TextStyle(color: AppTheme.textMuted, fontSize: 12),
                                ),
                                const SizedBox(height: 20),

                                // Timeline Steps
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildTimelineNode(label: "Placed", stepNum: 1, currentStep: currentStep),
                                    _buildTimelineDivider(stepNum: 1, currentStep: currentStep),
                                    _buildTimelineNode(label: "Confirmed", stepNum: 2, currentStep: currentStep),
                                    _buildTimelineDivider(stepNum: 2, currentStep: currentStep),
                                    _buildTimelineNode(label: "In Transit", stepNum: 3, currentStep: currentStep),
                                    _buildTimelineDivider(stepNum: 3, currentStep: currentStep),
                                    _buildTimelineNode(label: "Delivered", stepNum: 4, currentStep: currentStep),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MarketplaceScreen()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const BuyerProfileScreen()),
            );
          }
        },
      ),
    );
  }

  Widget _buildTimelineNode({
    required String label,
    required int stepNum,
    required int currentStep,
  }) {
    final isDone = currentStep >= stepNum;
    final isCurrent = currentStep == stepNum;

    return Column(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: isDone ? AppTheme.primaryGold : AppTheme.cardHighlight,
            shape: BoxShape.circle,
            border: Border.all(
              color: isCurrent ? Colors.white : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Icon(
            isDone ? Icons.check : Icons.circle,
            size: isDone ? 16 : 8,
            color: isDone ? AppTheme.textDark : AppTheme.textMuted,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
            color: isDone ? Colors.white : AppTheme.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineDivider({required int stepNum, required int currentStep}) {
    final isDone = currentStep > stepNum;
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 16),
        color: isDone ? AppTheme.primaryGold : AppTheme.cardHighlight,
      ),
    );
  }
}
