import 'package:flutter/material.dart';
import '../themes/app_theme.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notifications = [
      {
        'title': 'New Order Received',
        'body': 'Fahim Ahmed placed an order for 150 kg Aman Paddy.',
        'time': '10 mins ago',
        'isNew': 'true',
      },
      {
        'title': 'Market Price Alert',
        'body': 'Tomato wholesale price increased by ৳5/kg in Bogura region.',
        'time': '2 hours ago',
        'isNew': 'true',
      },
      {
        'title': 'Order Dispatched',
        'body': 'Your order for 50 kg Organic Rice is now in transit.',
        'time': '1 day ago',
        'isNew': 'false',
      },
      {
        'title': 'Welcome to AgroBuddy!',
        'body': 'Your account has been successfully verified. Explore direct farm sourcing today.',
        'time': '3 days ago',
        'isNew': 'false',
      },
    ];

    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.darkBackground,
        title: const Text("Notifications"),
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
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: notifications.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = notifications[index];
            final isNew = item['isNew'] == 'true';

            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isNew ? AppTheme.cardAltBackground : AppTheme.darkBackground,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isNew ? AppTheme.primaryGold.withValues(alpha: 0.4) : AppTheme.borderMuted,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isNew ? AppTheme.primaryGold.withValues(alpha: 0.2) : AppTheme.cardHighlight,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.notifications_active_outlined,
                      color: isNew ? AppTheme.primaryGold : AppTheme.textMuted,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item['title']!,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              item['time']!,
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppTheme.textMuted,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item['body']!,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppTheme.textSecondary,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
