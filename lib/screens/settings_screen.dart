import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../firebase_service.dart';
import 'login_screen.dart';
import 'farmer_dashboard_screen.dart';
import 'marketplace_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _smsAlerts = true;
  String _selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {
    final service = FirebaseService();
    final email = service.currentUserEmail ?? 'No email linked';
    final currentRole = service.currentUserRole ?? 'farmer';
    final isFarmer = currentRole == 'farmer';

    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.darkBackground,
        title: const Text("Settings"),
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
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Account info card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.cardAltBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.borderMuted),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: AppTheme.pillBackground,
                    child: Icon(
                      isFarmer ? Icons.eco : Icons.shopping_bag,
                      color: AppTheme.primaryGold,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              isFarmer ? "Farmer Account" : "Buyer Account",
                              style: const TextStyle(fontSize: 12, color: AppTheme.textMuted),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: isFarmer
                                    ? AppTheme.primaryGold.withValues(alpha: 0.2)
                                    : AppTheme.secondaryGold.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                isFarmer ? "FARMER" : "BUYER",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: isFarmer ? AppTheme.primaryGold : AppTheme.secondaryGold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          email,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Switch Role button
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final newRole = isFarmer ? 'buyer' : 'farmer';
                  await service.switchUserRole(newRole);
                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Switched role to ${newRole.toUpperCase()}"),
                      backgroundColor: AppTheme.successGreen,
                      duration: const Duration(seconds: 2),
                    ),
                  );

                  if (newRole == 'farmer') {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const FarmerDashboardScreen()),
                      (route) => false,
                    );
                  } else {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const MarketplaceScreen()),
                      (route) => false,
                    );
                  }
                },
                icon: Icon(
                  isFarmer ? Icons.swap_horiz : Icons.swap_horiz,
                  color: AppTheme.textDark,
                ),
                label: Text(
                  isFarmer ? "Switch to Buyer Mode" : "Switch to Farmer Mode",
                  style: const TextStyle(
                    color: AppTheme.textDark,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGold,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              "Preferences",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryGold,
              ),
            ),
            const SizedBox(height: 12),

            // Notification Switch
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text("Push Notifications", style: TextStyle(color: Colors.white)),
              subtitle: const Text("Receive order status and harvest alerts", style: TextStyle(color: AppTheme.textMuted, fontSize: 12)),
              value: _pushNotifications,
              activeThumbColor: AppTheme.primaryGold,
              onChanged: (val) => setState(() => _pushNotifications = val),
            ),

            // SMS Alerts Switch
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text("SMS Notifications", style: TextStyle(color: Colors.white)),
              subtitle: const Text("Get SMS messages for critical order milestones", style: TextStyle(color: AppTheme.textMuted, fontSize: 12)),
              value: _smsAlerts,
              activeThumbColor: AppTheme.primaryGold,
              onChanged: (val) => setState(() => _smsAlerts = val),
            ),

            const SizedBox(height: 20),
            const Divider(color: AppTheme.borderMuted),
            const SizedBox(height: 20),

            const Text(
              "Language & Region",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryGold,
              ),
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppTheme.cardAltBackground,
                borderRadius: BorderRadius.circular(14),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedLanguage,
                  dropdownColor: AppTheme.cardAltBackground,
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(value: "English", child: Text("English (Default)")),
                    DropdownMenuItem(value: "Bangla", child: Text("বাংলা (Bangla)")),
                  ],
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedLanguage = val);
                  },
                ),
              ),
            ),

            const SizedBox(height: 28),
            const Divider(color: AppTheme.borderMuted),
            const SizedBox(height: 28),

            // Sign Out
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: () async {
                  await FirebaseService().signOut();
                  if (!context.mounted) return;
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.logout, color: AppTheme.errorRed),
                label: const Text(
                  "Sign Out",
                  style: TextStyle(
                    color: AppTheme.errorRed,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppTheme.errorRed),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
