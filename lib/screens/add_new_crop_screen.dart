import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../firebase_service.dart';

class AddNewCropScreen extends StatefulWidget {
  const AddNewCropScreen({super.key});

  @override
  State<AddNewCropScreen> createState() => _AddNewCropScreenState();
}

class _AddNewCropScreenState extends State<AddNewCropScreen> {
  String _selectedCrop = 'Tomatoes';
  final List<String> _cropOptions = [
    'Tomatoes',
    'Organic Rice',
    'Green Chilli',
    'Potatoes',
    'Mustard Seeds',
  ];

  String _farmingType = 'Organic';
  final TextEditingController _availabilityController = TextEditingController(text: '1200');
  final TextEditingController _costController = TextEditingController(text: '45');
  final TextEditingController _descriptionController = TextEditingController();
  bool _isPublishing = false;

  @override
  void dispose() {
    _availabilityController.dispose();
    _costController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String _getImageForCrop(String crop) {
    switch (crop.toLowerCase()) {
      case 'tomatoes':
        return 'assets/images/storefront/tomatoes.png';
      case 'organic rice':
        return 'assets/images/storefront/rice.png';
      case 'green chilli':
        return 'assets/images/storefront/chilli.png';
      default:
        return 'assets/images/storefront/tomatoes.png';
    }
  }

  // Publish new harvest listing to crops/ collection
  Future<void> _handlePublish() async {
    final available = double.tryParse(_availabilityController.text.replaceAll(',', '')) ?? 0.0;
    final cost = double.tryParse(_costController.text.replaceAll(',', '')) ?? 0.0;

    if (available <= 0 || cost <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter valid availability and price"),
          backgroundColor: AppTheme.errorRed,
        ),
      );
      return;
    }

    setState(() => _isPublishing = true);

    final service = FirebaseService();
    final uid = service.currentUserId ?? 'mock_farmer_1';
    final userDoc = await service.getUser(uid);
    final farmerName = userDoc?['fullName'] ?? 'Fahim Karim';

    try {
      // Write new document to crops/ in Firestore
      await service.addCrop({
        'farmerId': uid,
        'farmerName': farmerName,
        'cropName': _selectedCrop,
        'pricePerKg': cost,
        'availableKg': available,
        'farmingType': _farmingType,
        'imagePath': _getImageForCrop(_selectedCrop),
        'description': _descriptionController.text.trim().isNotEmpty
            ? _descriptionController.text.trim()
            : 'Fresh $_farmingType $_selectedCrop grown naturally in Bogura.',
      });

      if (!mounted) return;
      setState(() => _isPublishing = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Crop listing published successfully!"),
          backgroundColor: AppTheme.successGreen,
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      setState(() => _isPublishing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to publish: $e"),
          backgroundColor: AppTheme.errorRed,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceDark,
      appBar: AppBar(
        backgroundColor: AppTheme.surfaceDark,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: AppTheme.cardAltBackground,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: const BoxDecoration(
                color: AppTheme.primaryGold,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  'AB',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppTheme.textDark,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Add New Crop',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Crop Info',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),

            _buildLabel('Crop Type'),
            const SizedBox(height: 8),

            // Crop Dropdown
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppTheme.cardHighlight,
                borderRadius: BorderRadius.circular(14),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedCrop,
                  dropdownColor: AppTheme.cardHighlight,
                  icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70),
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                  isExpanded: true,
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedCrop = val);
                  },
                  items: _cropOptions.map((crop) {
                    return DropdownMenuItem<String>(
                      value: crop,
                      child: Text(crop),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 20),

            _buildLabel('Farming Type'),
            const SizedBox(height: 8),

            // Farming Type Segments
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppTheme.cardHighlight,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildSegmentButton(
                      label: 'Organic',
                      icon: Icons.eco,
                      isSelected: _farmingType == 'Organic',
                      onTap: () => setState(() => _farmingType = 'Organic'),
                    ),
                  ),
                  Expanded(
                    child: _buildSegmentButton(
                      label: 'Conventional',
                      icon: Icons.agriculture,
                      isSelected: _farmingType == 'Conventional',
                      onTap: () => setState(() => _farmingType = 'Conventional'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            _buildLabel('Available Quantity (in kg)'),
            const SizedBox(height: 8),
            TextField(
              controller: _availabilityController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "1200",
                suffixText: "kg",
                suffixStyle: TextStyle(color: AppTheme.primaryGold),
              ),
            ),
            const SizedBox(height: 20),

            _buildLabel('Price per kg (৳)'),
            const SizedBox(height: 8),
            TextField(
              controller: _costController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "45",
                prefixText: "৳ ",
                prefixStyle: TextStyle(color: AppTheme.primaryGold),
              ),
            ),
            const SizedBox(height: 20),

            _buildLabel('Description (Optional)'),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Add specific notes on harvest date, grade, or storage...",
              ),
            ),
            const SizedBox(height: 36),

            // Publish Button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: _isPublishing ? null : _handlePublish,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGold,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: _isPublishing
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppTheme.textDark,
                        ),
                      )
                    : const Text(
                        'Publish Listing',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textDark,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }

  Widget _buildSegmentButton({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryGold : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? AppTheme.textDark : Colors.white70,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: isSelected ? AppTheme.textDark : Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
