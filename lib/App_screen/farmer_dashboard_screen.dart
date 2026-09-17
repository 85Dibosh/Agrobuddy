import 'package:flutter/material.dart';
import 'farmer_profile_screen.dart';
import 'package:agrobuddy/App_screen/add_new_crop_screen.dart';
import 'package:agrobuddy/App_screen/my_storefront_screen.dart';
import 'incoming_orders_screen.dart';

class FarmerDashboardScreen extends StatefulWidget {
  FarmerDashboardScreen({Key? key}) : super(key: key);
  @override
  FarmerDashboardScreenState createState() => FarmerDashboardScreenState();
}

class FarmerDashboardScreenState extends State<FarmerDashboardScreen> {
  int selectedTab = 0;
  String farmerName = "Fahim Karim";
  String farmerLocation = "Bogura, Rajshahi";
  int trustScore = 94;
  double farmArea = 4.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121B13),

      appBar: AppBar(
        backgroundColor: Color(0xFF121B13),
        leading: Row(
          children: [
            SizedBox(width: 10),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFE5B800),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                    'AB',
                    style: TextStyle(
                      color: Color(0xFF121B13),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )
                ),
              ),
            ),
          ],
        ),
        title: Row(
          children: [
            //SizedBox(width: 10),
            Text(
              "AgroBuddy",
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'serif',
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: Color(0xFFA0AAB0)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    backgroundColor: Color(0xFF121B13),
                    appBar: AppBar(
                      title: Text("Notifications"),
                      backgroundColor: Color(0xFF121B13),
                    ),
                    body: Center(
                      child: Text(
                        "Page not available",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: selectedTab == 0
            ? SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Card(
                color: Color(0xFF1E2C1F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: Color(0xFFE5B800),
                  ),
                ),

                child: Padding(
                  padding: EdgeInsets.all(16),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome back, " + farmerName,
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              farmerLocation,
                              style: TextStyle(
                                color: Color(0xFFA0AAB0),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFF24301B),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.wb_sunny_outlined,
                              color: Color(0xFFE5B800),
                              size: 18,
                            ),
                            SizedBox(width: 6),
                            Text(
                              "28°C Bogura",
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 12),

              Row(
                children: [

                  Expanded(
                    child: Card(
                      color: Color(0xFF1E2C1F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 8,
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.verified_user_outlined,
                              color: Color(0xFFE5B800),
                              size: 22,
                            ),
                            SizedBox(height: 6),
                            Text(
                              trustScore.toString() + "%",
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "Trust Score",
                              style: TextStyle(
                                color: Color(0xFFA0AAB0),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 8),

                  Expanded(
                    child: Card(
                      color: Color(0xFF1E2C1F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 8,
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.landscape_outlined,
                              color: Color(0xFF2196F3),
                              size: 22,
                            ),
                            SizedBox(height: 6),
                            Text(
                              farmArea.toString() + " Ac",
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "Farm Area",
                              style: TextStyle(
                                color: Color(0xFFA0AAB0),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 8),

                  Expanded(
                    child: Card(
                      color: Color(0xFF1E2C1F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 8,
                        ),
                        child: Column(
                          children: [
                            Text(
                              "12+ Years",
                              style: TextStyle(
                                color: Color(0xFFE5B800), // Brand gold
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 30),
                            Text(
                              "Experience",
                              style: TextStyle(
                                color: Color(0xFFA0AAB0),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              Text(
                "Quick Operations",
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),
              Card(
                color: Color(0xFF1E2C1F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFF24301B),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.add_circle_outline,
                      color: Color(0xFFE5B800),
                    ),
                  ),
                  title: Text(
                    "Add New Crop Listing",
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "Publish harvest to buyers",
                    style: TextStyle(
                      color: Color(0xFFA0AAB0),
                      fontSize: 12,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Color(0xFFA0AAB0),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddNewCropScreen(),
                      ),
                    );
                  },
                ),
              ),

              Card(
                color: Color(0xFF1E2C1F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFF24301B),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.storefront,
                      color: Color(0xFFE5B800),
                    ),
                  ),
                  title: Text(
                    "My Storefront & Inventory",
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Color(0xFFA0AAB0),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyStorefrontScreen(),
                      ),
                    );
                  },
                ),
              ),

              Card(
                color: Color(0xFF1E2C1F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFF24301B),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.receipt_long,
                      color: Color(0xFFE5B800),
                    ),
                  ),
                  title: Text(
                    "Incoming Orders",
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Color(0xFFA0AAB0),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IncomingOrdersScreen(),
                      ),
                    );
                  },
                ),
              ),

              Card(
                color: Color(0xFF1E2C1F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFF24301B),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.medical_services_outlined,
                      color: Color(0xFFE5B800),
                    ),
                  ),
                  title: Text(
                    "Consult Crop Doctors",
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "Get fast diagnosis from experts",
                    style: TextStyle(
                      color: Color(0xFFA0AAB0),
                      fontSize: 12,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Color(0xFFA0AAB0),
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
        )
            : Center(
          child: Text(
            "Tab Index: " + selectedTab.toString() + " Screen",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTab,
        onTap: (index) {
          if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FarmerProfileScreen(),
              ),
            );
          } else {
            setState(() {
              selectedTab = index;
            });
          }
        },
        backgroundColor: Color(0xFF121B13),
        selectedItemColor: Color(0xFFE5B800),
        unselectedItemColor: Color(0xFFA0AAB0),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
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
}