import 'package:flutter/material.dart';
import '../widgets/custom_text_input_widget.dart';
import 'widgets/custom_text_input_widget.dart';

class FarmerLoginScreen extends StatefulWidget {
  const FarmerLoginScreen({super.key});

  @override
  State<FarmerLoginScreen> createState() => FarmerLoginScreenState();
}

class FarmerLoginScreenState extends State<FarmerLoginScreen> {
  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final sizeController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    locationController.dispose();
    sizeController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF132018),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Color(0xFF263326),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        Navigator.maybePop(context);
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    'Farm Profile Setup',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 36),
              Text(
                'Farmer Details.',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Tell us about your farm.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white60,
                ),
              ),
              SizedBox(height: 30),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomInputField(
                        controller: nameController,
                        icon: Icons.person,
                        hintText: 'Full name.',
                      ),
                      SizedBox(height: 16),
                      CustomInputField(
                        controller: locationController,
                        icon: Icons.location_on,
                        hintText: 'Village, District.',
                      ),
                      SizedBox(height: 16),
                      CustomInputField(
                        controller: sizeController,
                        icon: Icons.straighten,
                        hintText: 'Farm size (Acres)',
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 16),
                      CustomInputField(
                        controller: phoneController,
                        icon: Icons.phone,
                        hintText: '1712-345678',
                        keyboardType: TextInputType.phone,
                        isPhone: true,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF5B038),
                    foregroundColor: Color(0xFF132018),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Farm profile saved!'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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