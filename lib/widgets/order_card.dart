import 'package:flutter/material.dart';
import '../themes/app_theme.dart';

class OrderCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String orderValue;
  final String status;
  final VoidCallback? onTap;
  final ValueChanged<String>? onStatusAdvance;

  const OrderCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.orderValue,
    required this.status,
    this.onTap,
    this.onStatusAdvance,
  });

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'placed':
        return AppTheme.primaryGold;
      case 'confirmed':
        return Colors.blueAccent;
      case 'in_transit':
        return Colors.orangeAccent;
      case 'delivered':
        return AppTheme.successGreen;
      default:
        return AppTheme.textMuted;
    }
  }

  String _formatStatus(String status) {
    switch (status.toLowerCase()) {
      case 'placed':
        return 'New';
      case 'confirmed':
        return 'Confirmed';
      case 'in_transit':
        return 'In Transit';
      case 'delivered':
        return 'Delivered';
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(status);

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppTheme.cardAltBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.borderMuted, width: 0.8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: statusColor, width: 1),
                  ),
                  child: Text(
                    _formatStatus(status),
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  orderValue,
                  style: const TextStyle(
                    color: AppTheme.primaryGold,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (onStatusAdvance != null && status != 'delivered')
                  TextButton.icon(
                    onPressed: () {
                      if (status == 'placed') {
                        onStatusAdvance!('confirmed');
                      } else if (status == 'confirmed') {
                        onStatusAdvance!('in_transit');
                      } else if (status == 'in_transit') {
                        onStatusAdvance!('delivered');
                      }
                    },
                    icon: const Icon(Icons.arrow_circle_right_outlined, size: 16, color: AppTheme.primaryGold),
                    label: Text(
                      status == 'placed'
                          ? "Confirm"
                          : status == 'confirmed'
                          ? "Ship"
                          : "Deliver",
                      style: const TextStyle(color: AppTheme.primaryGold, fontSize: 13),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
