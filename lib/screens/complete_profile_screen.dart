import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../firebase_service.dart';
import '../widgets/role_card.dart';
import 'farmer_dashboard_screen.dart';
import 'marketplace_screen.dart';

class CompleteProfileScreen extends StatefulWidget {
  final Map<String, dynamic> googleUser;

  const CompleteProfileScreen({
    super.key,
    required this.googleUser,
  });

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  // 0: Farmer, 1: Buyer
  int _selectedRoleIndex = 0;

  late final TextEditingController _nameController;
  final TextEditingController _locationController = TextEditingController(text: 'Bogura, Rajshahi');
  final TextEditingController _farmAreaController = TextEditingController(text: '4.5');
  final TextEditingController _phoneController = TextEditingController(text: '+8801712345678');
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    // Prefill full name from Google account
    _nameController = TextEditingController(text: widget.googleUser['fullName'] ?? 'AgroBuddy User');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _farmAreaController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // Save new user profile into users/{uid} in Firestore
  Future<void> _handleSaveProfile() async {
    final name = _nameController.text.trim();
    final location = _locationController.text.trim();
    final area = double.tryParse(_farmAreaController.text.trim()) ?? 1.0;
    final phone = _phoneController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter your name"),
          backgroundColor: AppTheme.errorRed,
        ),
      );
      return;
    }

    setState(() => _isSaving = true);

    final role = _selectedRoleIndex == 0 ? 'farmer' : 'buyer';
    final uid = widget.googleUser['uid'];
    final email = (widget.googleUser['email'] as String?)?.trim().toLowerCase() ?? '';
    final photoUrl = widget.googleUser['photoUrl'];

    final service = FirebaseService();
    // Save user profile data to Firestore
    await service.saveUser(
      uid: uid,
      data: {
        'uid': uid,
        'email': email,
        'fullName': name,
        'role': role,
        'photoUrl': photoUrl,
        'location': location,
        'farmArea': role == 'farmer' ? area : null,
        'phoneNumber': phone,
        'trustScore': 95,
      },
    );

    if (!mounted) return;
    setState(() => _isSaving = false);

    // Navigate to role-specific dashboard
    if (role == 'farmer') {
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
  }

  @override
  Widget build(BuildContext context) {
    final displayEmail = widget.googleUser['email']?.toString() ?? '';
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.darkBackground,
        title: const Text("Complete Your Profile"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (displayEmail.isNotEmpty) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppTheme.cardAltBackground,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.borderMuted),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.account_circle_outlined, color: AppTheme.primaryGold, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Account: $displayEmail",
                          style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
              const Text(
                "Choose Your Role",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Select how you want to use AgroBuddy",
                style: TextStyle(fontSize: 13, color: AppTheme.textMuted),
              ),
              const SizedBox(height: 14),

              // Farmer Role Card
              RoleCard(
                title: "I'm a Farmer",
                subtitle: "List crops, manage inventory & receive orders",
                icon: Icons.eco,
                isSelected: _selectedRoleIndex == 0,
                onTap: () => setState(() => _selectedRoleIndex = 0),
              ),
              const SizedBox(height: 12),

              // Buyer Role Card
              RoleCard(
                title: "I'm a Buyer",
                subtitle: "Source crops directly from farmers at wholesale rates",
                icon: Icons.shopping_cart_outlined,
                isSelected: _selectedRoleIndex == 1,
                onTap: () => setState(() => _selectedRoleIndex = 1),
              ),

              const SizedBox(height: 28),

              const Text(
                "Your Details",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),

              _buildFieldLabel("Full Name"),
              const SizedBox(height: 6),
              TextField(
                controller: _nameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Your Full Name",
                  prefixIcon: Icon(Icons.person_outline, color: AppTheme.primaryGold),
                ),
              ),
              const SizedBox(height: 16),

              _buildFieldLabel(_selectedRoleIndex == 0 ? "Farm Location" : "Delivery City / Address"),
              const SizedBox(height: 6),
              TextField(
                controller: _locationController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: _selectedRoleIndex == 0 ? "e.g. Bogura, Rajshahi" : "e.g. Uttara, Dhaka",
                  prefixIcon: const Icon(Icons.location_on_outlined, color: AppTheme.primaryGold),
                ),
              ),
              const SizedBox(height: 16),

              if (_selectedRoleIndex == 0) ...[
                _buildFieldLabel("Farm Area (in Acres)"),
                const SizedBox(height: 6),
                TextField(
                  controller: _farmAreaController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "e.g. 4.5",
                    prefixIcon: Icon(Icons.landscape_outlined, color: AppTheme.primaryGold),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              _buildFieldLabel("Contact Phone (Optional)"),
              const SizedBox(height: 6),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "+8801712345678",
                  prefixIcon: Icon(Icons.phone_outlined, color: AppTheme.primaryGold),
                ),
              ),

              const SizedBox(height: 36),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _handleSaveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGold,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  child: _isSaving
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.textDark),
                        )
                      : Text(
                          _selectedRoleIndex == 0 ? "Enter Farmer Dashboard" : "Enter Marketplace",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textDark,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }
}
