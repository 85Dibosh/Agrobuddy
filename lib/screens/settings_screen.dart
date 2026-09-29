import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../firebase_service.dart';
import 'role_selection_screen.dart';

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

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.cardAltBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.borderMuted),
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: AppTheme.pillBackground,
                    child: Icon(Icons.verified_user, color: AppTheme.primaryGold),
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Firebase Account",
                          style: TextStyle(fontSize: 12, color: AppTheme.textMuted),
                        ),
                        SizedBox(height: 2),
                        Text(
                          FirebaseService.linkedAccount,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
                    MaterialPageRoute(builder: (_) => const RoleSelectionScreen()),
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
