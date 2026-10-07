import 'package:flutter/material.dart';
import '../themes/app_theme.dart';

class MarketplaceCropCard extends StatelessWidget {
  final String cropName;
  final double pricePerKg;
  final double availableKg;
  final String farmerName;
  final String? imagePath;
  final VoidCallback onTap;

  const MarketplaceCropCard({
    super.key,
    required this.cropName,
    required this.pricePerKg,
    required this.availableKg,
    required this.farmerName,
    this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.cardAltBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.borderMuted, width: 0.8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Crop Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: _buildImage(imagePath),
            ),
            // Crop Details
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cropName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "৳ ${pricePerKg.toStringAsFixed(0)} / kg",
                    style: const TextStyle(
                      color: AppTheme.primaryGold,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          farmerName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppTheme.textMuted,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      Text(
                        "${availableKg.toInt()} kg",
                        style: const TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String? path) {
    if (path != null && path.startsWith('assets/')) {
      return Image.asset(
        path,
        height: 105,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _fallbackPlaceholder(),
      );
    } else if (path != null && path.startsWith('http')) {
      return Image.network(
        path,
        height: 105,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _fallbackPlaceholder(),
      );
    }
    return _fallbackPlaceholder();
  }

  Widget _fallbackPlaceholder() {
    return Container(
      height: 105,
      width: double.infinity,
      color: AppTheme.pillBackground,
      child: const Icon(
        Icons.eco,
        color: AppTheme.primaryGold,
        size: 40,
      ),
    );
  }
}

class StorefrontCropCard extends StatelessWidget {
  final String title;
  final double pricePerKg;
  final double availableKg;
  final String? imagePath;
  final VoidCallback? onTap;

  const StorefrontCropCard({
    super.key,
    required this.title,
    required this.pricePerKg,
    required this.availableKg,
    this.imagePath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.cardAltBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderMuted, width: 0.8),
      ),
      child: Row(
        children: [
          // Crop thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: _buildThumbnail(imagePath),
          ),
          const SizedBox(width: 16),
          // Crop Title, Price & Stock
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Tk ${pricePerKg.toStringAsFixed(0)} / kg",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryGold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Available: ${availableKg.toInt()} kg",
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textMuted,
                  ),
                ),
              ],
            ),
          ),
          // Active badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.pillBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              "Active",
              style: TextStyle(
                color: AppTheme.primaryGold,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThumbnail(String? path) {
    if (path != null && path.startsWith('assets/')) {
      return Image.asset(
        path,
        width: 70,
        height: 70,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _placeholder(),
      );
    } else if (path != null && path.startsWith('http')) {
      return Image.network(
        path,
        width: 70,
        height: 70,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _placeholder(),
      );
    }
    return _placeholder();
  }

  Widget _placeholder() {
    return Container(
      width: 70,
      height: 70,
      color: AppTheme.pillBackground,
      child: const Icon(Icons.eco, color: AppTheme.primaryGold, size: 30),
    );
  }
}
