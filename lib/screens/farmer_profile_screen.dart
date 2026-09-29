import 'package:flutter/material.dart';
import 'farmer_dashboard_screen.dart';

class FarmerProfileScreen extends StatefulWidget {
  FarmerProfileScreen({super.key});

  @override
  State<FarmerProfileScreen> createState() => FarmerProfileScreenState();
}

class FarmerProfileScreenState extends State<FarmerProfileScreen> {
  int selectedTab = 3;
  String farmerName = "Fahim Karim";
  String farmerLocation = "Bogura, Rajshahi";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF14201A),
      appBar: AppBar(
        backgroundColor: Color(0xFF14201A),
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF1E2B22),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 18),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Color(0xFF1E2B22),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.notifications_outlined, color: Colors.white70, size: 18),
              onPressed: () {},
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Center(
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Color(0xFF2E3B23), width: 3),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/storefront/tomatoes.png',
                          width: 110,
                          height: 110,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 4,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Color(0xFFD4A017),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check,
                          color: Color(0xFF14201A),
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    farmerName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Color(0xFF1E2B22),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Color(0xFFD4A017).withOpacity(0.4)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.verified, color: Color(0xFFD4A017), size: 14),
                        SizedBox(width: 4),
                        Text(
                          "Verified",
                          style: TextStyle(
                            color: Color(0xFFD4A017),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, color: Color(0xFFD4A017), size: 16),
                  SizedBox(width: 4),
                  Text(
                    farmerLocation,
                    style: TextStyle(
                      color: Color(0xFF8E9B90),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 28),
              Row(
                children: [
                  Expanded(
                    child: buildStatCard(
                      title: "Farm Area",
                      value: "4.5",
                      subtitle: "Acres",
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: buildStatCard(
                      title: "Trust Score",
                      value: "94%",
                      subtitle: "Verified",
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: buildStatCard(
                      title: "Experience",
                      value: "12+",
                      subtitle: "Years",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "View Full Details",
                      style: TextStyle(
                        color: Color(0xFFD4A017),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.arrow_forward, color: Color(0xFFD4A017), size: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTab,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => FarmerDashboardScreen(),
              ),
            );
          } else {
            setState(() {
              selectedTab = index;
            });
          }
        },
        backgroundColor: Color(0xFF14201A),
        selectedItemColor: Color(0xFFD4A017),
        unselectedItemColor: Color(0xFF8E9B90),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront_outlined),
            label: "Market",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  Widget buildStatCard({
    required String title,
    required String value,
    required String subtitle,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        color: Color(0xFF1E2B22),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Color(0xFF8E9B90),
              fontSize: 13,
            ),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: Color(0xFFD4A017),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: Color(0xFF8E9B90),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}