import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../firebase_service.dart';
import '../widgets/order_card.dart';

class IncomingOrdersScreen extends StatefulWidget {
  const IncomingOrdersScreen({super.key});

  @override
  State<IncomingOrdersScreen> createState() => _IncomingOrdersScreenState();
}

class _IncomingOrdersScreenState extends State<IncomingOrdersScreen> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _orders = [];

  @override
  void initState() {
    super.initState();
    _fetchIncomingOrders();
  }

  // Read all incoming orders placed for this farmer's crops from Firestore
  Future<void> _fetchIncomingOrders() async {
    setState(() => _isLoading = true);
    final service = FirebaseService();
    final farmerId = service.currentUserId ?? 'mock_farmer_1';

    try {
      // Query orders where farmerId == logged-in farmer
      final orders = await service.getIncomingOrders(farmerId);
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

  Future<void> _advanceOrderStatus(String orderId, String newStatus) async {
    final service = FirebaseService();
    await service.updateOrderStatus(orderId, newStatus);
    _fetchIncomingOrders();
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
          Container(
            margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: AppTheme.primaryGold,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                "AB",
                style: TextStyle(
                  color: AppTheme.textDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: AppTheme.primaryGold),
              )
            : RefreshIndicator(
                color: AppTheme.primaryGold,
                onRefresh: _fetchIncomingOrders,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Incoming Orders",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Buyer orders for your listed crops",
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 24),

                      if (_orders.isEmpty)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            child: Column(
                              children: [
                                Icon(Icons.inbox_outlined, size: 60, color: AppTheme.textMuted.withValues(alpha: 0.5)),
                                const SizedBox(height: 16),
                                const Text(
                                  "No incoming orders yet",
                                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 6),
                                const Text(
                                  "When buyers order your crops, they will show up here.",
                                  style: TextStyle(color: AppTheme.textMuted, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        for (var order in _orders) ...[
                          OrderCard(
                            title: order['buyerName'] ?? 'Buyer',
                            subtitle: "${order['cropName'] ?? 'Crop'} • ${(order['quantityKg'] as num?)?.toInt() ?? 0} kg",
                            orderValue: "৳${(order['totalPrice'] as num?)?.toStringAsFixed(0) ?? '0'}",
                            status: order['status'] ?? 'placed',
                            onStatusAdvance: (newStatus) {
                              _advanceOrderStatus(order['id'] ?? '', newStatus);
                            },
                          ),
                          const SizedBox(height: 16),
                        ],
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
