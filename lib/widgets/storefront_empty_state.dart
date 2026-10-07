import 'package:flutter/material.dart';
import '../themes/app_theme.dart';

class StorefrontEmptyState extends StatelessWidget {
  final VoidCallback onAddCropPressed;

  const StorefrontEmptyState({
    super.key,
    required this.onAddCropPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: AppTheme.pillBackground,
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.primaryGold.withValues(alpha: 0.3), width: 2),
              ),
              child: const Icon(
                Icons.storefront_outlined,
                color: AppTheme.primaryGold,
                size: 46,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Your Storefront is Empty",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "You haven't listed any crops yet. Add your harvested crops so verified buyers in the marketplace can purchase from you.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textMuted,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              height: 48,
              child: ElevatedButton.icon(
                onPressed: onAddCropPressed,
                icon: const Icon(Icons.add, size: 20, color: AppTheme.textDark),
                label: const Text(
                  "Add Your First Crop",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textDark,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGold,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
