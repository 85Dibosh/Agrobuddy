import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../firebase_service.dart';
import 'order_tracking_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final Map<String, dynamic> crop;
  final double quantityKg;
  final double totalPrice;

  const CheckoutScreen({
    super.key,
    required this.crop,
    required this.quantityKg,
    required this.totalPrice,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _addressController = TextEditingController(text: 'House 14, Sector 3, Uttara, Dhaka');
  bool _isSubmitting = false;

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  // Write a new order document into orders/ in Firestore
  Future<void> _handlePlaceOrder() async {
    final address = _addressController.text.trim();
    if (address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter your delivery destination"),
          backgroundColor: AppTheme.errorRed,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final service = FirebaseService();
    final buyerId = service.currentUserId ?? 'mock_buyer_1';
    final userDoc = await service.getUser(buyerId);
    final buyerName = userDoc?['fullName'] ?? 'Tariqul Islam';

    try {
      // Save new order document to Firestore
      await service.createOrder({
        'buyerId': buyerId,
        'buyerName': buyerName,
        'farmerId': widget.crop['farmerId'] ?? 'mock_farmer_1',
        'cropId': widget.crop['id'] ?? 'crop_1',
        'cropName': widget.crop['cropName'] ?? widget.crop['title'] ?? 'Crop',
        'quantityKg': widget.quantityKg,
        'totalPrice': widget.totalPrice,
        'status': 'placed',
        'deliveryAddress': address,
      });

      if (!mounted) return;
      setState(() => _isSubmitting = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Order placed successfully!"),
          backgroundColor: AppTheme.successGreen,
        ),
      );

      // Navigate to order tracking view
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OrderTrackingScreen()),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to place order: $e"),
          backgroundColor: AppTheme.errorRed,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cropName = widget.crop['cropName'] ?? widget.crop['title'] ?? 'Crop';
    final pricePerKg = (widget.crop['pricePerKg'] as num?)?.toDouble() ?? 45.0;

    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.darkBackground,
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
        title: const Text("Checkout & Review"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Order Summary",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 14),

              // Item Details Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.cardAltBackground,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.borderMuted),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          cropName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "৳ ${widget.totalPrice.toStringAsFixed(0)}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryGold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Quantity: ${widget.quantityKg.toInt()} kg",
                          style: const TextStyle(color: AppTheme.textMuted, fontSize: 13),
                        ),
                        Text(
                          "@ ৳${pricePerKg.toStringAsFixed(0)} / kg",
                          style: const TextStyle(color: AppTheme.textMuted, fontSize: 13),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Divider(color: AppTheme.borderMuted),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Direct Sourcing Fee",
                          style: TextStyle(color: AppTheme.textSecondary, fontSize: 13),
                        ),
                        Text(
                          "FREE (0%)",
                          style: TextStyle(color: AppTheme.successGreen, fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                "Delivery Address",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _addressController,
                maxLines: 2,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Enter full delivery address...",
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(bottom: 24),
                    child: Icon(Icons.location_on_outlined, color: AppTheme.primaryGold),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                "Payment Method",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.cardAltBackground,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.primaryGold.withValues(alpha: 0.5)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.payments_outlined, color: AppTheme.primaryGold),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Cash on Delivery",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Pay farmer upon quality inspection and receipt",
                            style: TextStyle(color: AppTheme.textMuted, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.check_circle, color: AppTheme.primaryGold, size: 20),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Confirm and Place Order Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _handlePlaceOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGold,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppTheme.textDark,
                          ),
                        )
                      : Text(
                          "Confirm Order (৳${widget.totalPrice.toStringAsFixed(0)})",
                          style: const TextStyle(
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
