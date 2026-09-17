import 'package:flutter/material.dart';

class FarmerDashboardScreen extends StatefulWidget {
  FarmerDashboardScreen({Key? key}) : super(key: key);
  @override
  FarmerDashboardScreenState createState() => FarmerDashboardScreenState();
}

class FarmerDashboardScreenState extends State<FarmerDashboardScreen> {
  int selectedTab = 0;
  String farmerName = "Fahim Karim";
  String farmerLocation = "Bogura, Bangladesh";
  int trustScore = 94;
  double farmArea = 4.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121B13),

      appBar: AppBar(
        backgroundColor: Color(0xFF121B13),
        title: Row(
          children: [
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
            SizedBox(width: 10),
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

      // SafeArea ensures content doesn't get hidden behind phone notches or bottom bars
      body: SafeArea(
        // Checks if the Home tab (index 0) is active; if true, shows the dashboard scroll view
        child: selectedTab == 0
        // SingleChildScrollView allows the screen content to scroll vertically if it overflows
            ? SingleChildScrollView(
          // Adds padding around all edges of the scrolling content area
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          // Column stacks all dashboard elements vertically from top to bottom
          child: Column(
            // Aligns all child widgets to the left edge of the screen
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Card widget creates a rounded greeting container box
              Card(
                // Sets the dark olive background color for the card
                color: Color(0xFF1E2C1F),
                // Defines the rounded corners and subtle border outline
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: Color(0xFFE5B800).withOpacity(0.2),
                  ),
                ),
                // Padding inside the welcome card
                child: Padding(
                  padding: EdgeInsets.all(16),
                  // Row places the greeting text on the left and the weather badge on the right
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Expanded ensures text takes up remaining flexible space without overflowing
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Welcome text using our farmerName variable
                            Text(
                              "Welcome back, " + farmerName,
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Adds a small gap between name and location
                            SizedBox(height: 4),
                            // Subtitle text showing location
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
                      // Container creates the weather badge on the right side
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFF24301B),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        // Row holding the sun icon and weather temperature text
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

              // Vertical gap between the welcome card and statistics row
              SizedBox(height: 12),

              // Row places three metric cards side-by-side
              Row(
                children: [
                  // Expanded makes the first card take up equal flexible width
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
                        // Column stacks the trust score icon, percentage text, and label vertically
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

                  // Horizontal gap between cards
                  SizedBox(width: 8),

                  // Expanded makes the second card take up equal flexible width
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
                        // Column stacks the farm area icon, size text, and label vertically
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

                  // Horizontal gap between cards
                  SizedBox(width: 8),

                  // Expanded makes the third card take up equal flexible width
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
                        // Column stacks the listings icon and label vertically
                        child: Column(
                          children: [
                            Icon(
                              Icons.inventory_2_outlined,
                              color: Colors.greenAccent,
                              size: 22,
                            ),
                            SizedBox(height: 6),
                            SizedBox(height: 2),
                            Text(
                              "Listings",
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

              // Vertical gap before the Quick Operations section header
              SizedBox(height: 20),

              // Section title text for Quick Operations
              Text(
                "Quick Operations",
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Vertical gap between header and operation cards
              SizedBox(height: 10),

              // First Operation Card: Add New Crop Listing
              Card(
                color: Color(0xFF1E2C1F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                // ListTile provides a convenient layout for leading icons, title, subtitle, and trailing arrow
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
                  // Action triggered when tapping this list tile
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Added new crop listing!")),
                    );
                  },
                ),
              ),

              // Second Operation Card: My Storefront & Inventory
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
                  onTap: () {},
                ),
              ),

              // Third Operation Card: Incoming Orders
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
                  onTap: () {},
                ),
              ),

              // Fourth Operation Card: Consult Crop Doctors
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
        // If any other tab is clicked, display a simple placeholder text in the center
            : Center(
          child: Text(
            "Tab Index: " + selectedTab.toString() + " Screen",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),

      // BottomNavigationBar creates the bottom tab bar with 4 destinations
      bottomNavigationBar: BottomNavigationBar(
        // Sets the active highlighted tab index
        currentIndex: selectedTab,
        // Updates the selected tab index and refreshes the screen when tapped
        onTap: (index) {
          setState(() {
            selectedTab = index;
          });
        },
        // Sets the background color of the navigation bar
        backgroundColor: Color(0xFF121B13),
        // Highlights the active tab icon and label in gold
        selectedItemColor: Color(0xFFE5B800),
        // Sets inactive tab icons and labels to muted gray-green
        unselectedItemColor: Color(0xFFA0AAB0),
        // Keeps all tabs fixed in place without shifting animation
        type: BottomNavigationBarType.fixed,
        // The list of 4 destination items in the navigation bar
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
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