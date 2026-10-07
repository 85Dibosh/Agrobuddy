import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../firebase_service.dart';
import 'checkout_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic>? crop;
  final String? cropId;

  const ProductDetailScreen({
    super.key,
    this.crop,
    this.cropId,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  Map<String, dynamic>? _cropData;
  bool _isLoading = true;
  double _quantity = 10.0; // default quantity in kg

  @override
  void initState() {
    super.initState();
    _loadCrop();
  }

  // Read a single crop listing by its id from Firestore
  Future<void> _loadCrop() async {
    if (widget.crop != null) {
      setState(() {
        _cropData = widget.crop;
        _isLoading = false;
      });
      return;
    }

    final id = widget.cropId;
    if (id != null) {
      final service = FirebaseService();
      // Query single document in crops/{cropId}
      final data = await service.getCropById(id);
      if (mounted) {
        setState(() {
          _cropData = data;
          _isLoading = false;
        });
      }
    } else {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppTheme.darkBackground,
        body: Center(child: CircularProgressIndicator(color: AppTheme.primaryGold)),
      );
    }

    if (_cropData == null) {
      return Scaffold(
        backgroundColor: AppTheme.darkBackground,
        appBar: AppBar(title: const Text("Product Detail")),
        body: const Center(
          child: Text("Product not found.", style: TextStyle(color: Colors.white)),
        ),
      );
    }

    final cropName = _cropData!['cropName'] ?? 'Crop';
    final pricePerKg = (_cropData!['pricePerKg'] as num?)?.toDouble() ?? 45.0;
    final availableKg = (_cropData!['availableKg'] as num?)?.toDouble() ?? 100.0;
    final farmerName = _cropData!['farmerName'] ?? 'Local Farmer';
    final farmingType = _cropData!['farmingType'] ?? 'Organic';
    final description = _cropData!['description'] ?? 'Fresh farm produce directly harvested from local fields.';
    final imagePath = _cropData!['imagePath'];
    final totalPrice = pricePerKg * _quantity;

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
        title: Text(cropName),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Crop Image
              Container(
                height: 240,
                width: double.infinity,
                color: AppTheme.cardAltBackground,
                child: _buildHeroImage(imagePath),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badge and Farmer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryGold.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppTheme.primaryGold),
                          ),
                          child: Text(
                            farmingType,
                            style: const TextStyle(
                              color: AppTheme.primaryGold,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Text(
                          "Farmer: $farmerName",
                          style: const TextStyle(
                            color: AppTheme.textMuted,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // Crop Title
                    Text(
                      cropName,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Price per kg & Available stock
                    Row(
                      children: [
                        Text(
                          "৳ ${pricePerKg.toStringAsFixed(0)}",
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryGold,
                          ),
                        ),
                        const Text(
                          " / kg",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppTheme.textMuted,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppTheme.cardHighlight,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "In Stock: ${availableKg.toInt()} kg",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                    const Divider(color: AppTheme.borderMuted),
                    const SizedBox(height: 16),

                    // Description
                    const Text(
                      "About this harvest",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.textMuted,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Quantity Selection Stepper
                    const Text(
                      "Select Quantity (kg)",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.cardAltBackground,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.borderMuted),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: _quantity > 5
                                ? () => setState(() => _quantity -= 5)
                                : null,
                            icon: const Icon(Icons.remove_circle_outline, color: AppTheme.primaryGold, size: 28),
                          ),
                          Text(
                            "${_quantity.toInt()} kg",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: _quantity < availableKg
                                ? () => setState(() => _quantity += 5)
                                : null,
                            icon: const Icon(Icons.add_circle_outline, color: AppTheme.primaryGold, size: 28),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 36),

                    // Proceed to Buy Button with Total
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CheckoutScreen(
                                crop: _cropData!,
                                quantityKg: _quantity,
                                totalPrice: totalPrice,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryGold,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total: ৳${totalPrice.toStringAsFixed(0)}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textDark,
                              ),
                            ),
                            const Row(
                              children: [
                                Text(
                                  "Proceed to Buy",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.textDark,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(Icons.arrow_forward, color: AppTheme.textDark, size: 18),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroImage(String? path) {
    if (path != null && path.startsWith('assets/')) {
      return Image.asset(
        path,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _fallbackHero(),
      );
    } else if (path != null && path.startsWith('http')) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _fallbackHero(),
      );
    }
    return _fallbackHero();
  }

  Widget _fallbackHero() {
    return const Center(
      child: Icon(Icons.eco, color: AppTheme.primaryGold, size: 70),
    );
  }
}
