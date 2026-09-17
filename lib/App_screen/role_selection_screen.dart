import 'package:flutter/material.dart';
import 'package:agrobuddy/App_screen/farmer_dashboard_screen.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});
  @override
  State<RoleSelectionScreen> createState() => RoleSelectionScreenState();
}

class RoleSelectionScreenState extends State<RoleSelectionScreen>{
  int selectedRole = 0; // 0 for farmer, 1 expert, 2 buyer

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFF14201A),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                'Welcome to',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600, //w600 for semibold
                  color: Colors.white,
                ),
              ),
              //title
              SizedBox(height: 6),
              Text(
                'AgroBuddy',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD4A017),
                ),
              ),

              SizedBox(height: 12),
              Text(
                'Please select your role to customize your dashboard',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFB0BEB4),
                ),
              ),

              SizedBox(height: 36), //gap between Agrobuddy and farmer
              buildRoleCard(index: 0, title: "I'm a Farmer", subtitle: "Manage Crops & Vets", icon: Icons.eco),

              SizedBox(height: 16), //gap between farmer and expert
              buildRoleCard(index: 1, title: "I'm an Expert", subtitle: "Consult & Diagnose", icon: Icons.psychology),

              SizedBox(height: 16),
              buildRoleCard(index: 2, title: "I'm a Buyer", subtitle: "Sourcing & Logistics", icon: Icons.shopping_cart_outlined),

              Spacer(), // pushes everything after this to the very bottom
              
              SizedBox(
                width: double.infinity, // maximum width
                height: 52,
                
                child: ElevatedButton(
                  onPressed: (){
                    if(selectedRole == 0 || selectedRole == 1 || selectedRole == 2 ){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FarmerDashboardScreen(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD4A017),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),

                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF14201A),
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

  Widget buildRoleCard({required int index, required String title, required String subtitle, required IconData icon}){
    bool isSelected = selectedRole == index;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: (){
        setState(() {
          selectedRole = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
        decoration: BoxDecoration(
          color: Color(0xFF2E3B23),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Color(0xFFD4A017) : Colors.transparent,
            width: 1.5,
          ),
        ),
        
        child: Row(
          children: [
            //left role icon
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Color(0xFFD4A017) : Color(0xFF1E2818),
              ),
              child: Icon(
                icon,
                color: isSelected ? Color(0xFF14201A) : Color(0xFFB0BEB4),
              ),
            ),

            //text
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4), // for 2nd text
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFFB0BEB4),
                    ),
                  ),
                ],
              ),
            ),

            //rightmost checkmark icon
            Container(
             width: 24,
             height: 24,
             decoration: BoxDecoration(
               shape: BoxShape.circle,
               color: isSelected ? Color(0xFFD4A017) : Colors.transparent,
               border: Border.all(
                 color: isSelected ? Color(0xFFD4A017) : Color(0xFF556845),
                 width: 2,
               ),
             ),

              child: isSelected ? Icon(Icons.check, size: 16, color: Color(0xFF14201A)) : null,
            ),
          ],
        ),
      ),
    );
  }
}