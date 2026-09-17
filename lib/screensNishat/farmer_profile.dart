// Imports Flutter's material library which gives us pre-built widgets like buttons, cards, and text
import 'package:flutter/material.dart';

// Creates a stateful widget for the farmer profile screen so it can remember things like the selected tab
class FarmerProfileScreen extends StatefulWidget {
  // Constructor with optional key parameter
  FarmerProfileScreen({super.key});

  // Connects the widget to its state class
  @override
  State<FarmerProfileScreen> createState() => FarmerProfileScreenState();
}

// The state class that holds our variables and builds the visual interface
class FarmerProfileScreenState extends State<FarmerProfileScreen> {
  // Tracks which bottom navigation tab is currently selected (Profile is index 3)
  int selectedTab = 3;

  // The farmer's full name displayed on the profile
  String farmerName = "Rafiqul Islam";

  // The farmer's location text
  String farmerLocation = "Bogura, Rajshahi Division";

  // The build method runs whenever Flutter needs to draw or update the screen
  @override
  Widget build(BuildContext context) {
    // Scaffold provides the standard full-screen layout structure and background color
    return Scaffold(
      // Sets the background color of the entire screen to deep dark green
      backgroundColor: Color(0xFF14201A),

      // AppBar creates the top navigation bar header
      appBar: AppBar(
        // Matches the app bar background color to the screen's dark theme
        backgroundColor: Color(0xFF14201A),
        // Removes the shadow underneath the top bar
        elevation: 0,
        // Leading widget places a back button on the far left side
        leading: Padding(
          // Adds space around the back button container
          padding: EdgeInsets.all(8),
          // Container creates a circular dark backing for the back arrow
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF1E2B22),
              shape: BoxShape.circle,
            ),
            // IconButton makes the arrow clickable to go back
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 18),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        // Actions property places interactive icons on the right side of the app bar
        actions: [
          // Container creates a circular background for the notification bell icon
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Color(0xFF1E2B22),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.notifications_outlined, color: Colors.white70, size: 18),
              onPressed: (){},
            ),
          ),
          // Adds horizontal spacing between the notification bell and the profile initial badge
          SizedBox(width: 8),
          // Container creates a gold circular badge with the letter 'A'
          Container(
            margin: EdgeInsets.only(right: 16, top: 8, bottom: 8),
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Color(0xFFD4A017),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                "A",
                style: TextStyle(
                  color: Color(0xFF14201A),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),

      // SafeArea ensures our content stays inside the visible screen bounds away from notches
      body: SafeArea(
        // SingleChildScrollView allows the screen content to scroll up and down if it overflows
        child: SingleChildScrollView(
          // Adds padding around all edges of the content area
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          // Column stacks all profile elements vertically from top to bottom
          child: Column(
            // Centers all children horizontally in the column
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Adds vertical space before the profile picture
              SizedBox(height: 10),
              // Center widget aligns the profile image container right in the middle
              Center(
                // Stack lets us place the tiny verified badge on top of the profile image
                child: Stack(
                  children: [
                    // Container creates a dark circular ring/border around the profile photo
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Color(0xFF2E3B23), width: 3),
                      ),
                      // ClipOval cuts the profile image into a clean circle shape
                      child: ClipOval(
                        // Uses a placeholder image asset for the farmer's photo
                        child: Image.asset(
                          'assets/images/storefront/tomatoes.png',
                          width: 110,
                          height: 110,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Positioned places the small yellow checkmark badge at the bottom right of the photo
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
              // Adds space between the profile picture and the farmer's name
              SizedBox(height: 16),

              // Row places the farmer's name and verified badge side by side
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text widget displaying the farmer's name in bold white letters
                  Text(
                    farmerName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Adds space between the name and the verified pill
                  SizedBox(width: 8),
                  // Container creates the small dark green "Verified" badge pill
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
              // Adds space between the name row and the location text
              SizedBox(height: 6),

              // Row places the location pin icon and location text together
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
              // Adds space before the 3 statistic cards row
              SizedBox(height: 28),

              // Row places three information metric cards side by side
              Row(
                children: [
                  // Expanded makes the first card take up equal flexible width
                  Expanded(
                    child: buildStatCard(
                      title: "Farm Area",
                      value: "6.5",
                      subtitle: "Acres",
                    ),
                  ),
                  SizedBox(width: 10),
                  // Expanded makes the second card take up equal flexible width
                  Expanded(
                    child: buildStatCard(
                      title: "Trust Score",
                      value: "98%",
                      subtitle: "Verified",
                    ),
                  ),
                  SizedBox(width: 10),
                  // Expanded makes the third card take up equal flexible width
                  Expanded(
                    child: buildStatCard(
                      title: "Experience",
                      value: "1",
                      subtitle: "Years",
                    ),
                  ),
                ],
              ),
              // Adds space before the view full details text link
              SizedBox(height: 32),

              // GestureDetector lets us make plain text clickable like a button
              GestureDetector(
                onTap: (){},
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

      // BottomNavigationBar creates the bottom tab bar with 4 tabs
      bottomNavigationBar: BottomNavigationBar(
        // Sets the active highlighted tab index to Profile (3)
        currentIndex: selectedTab,
        // Updates the tab index when clicked
        onTap: (index) {
          setState(() {
            selectedTab = index;
          });
        },
        // Background color of the bottom navigation bar
        backgroundColor: Color(0xFF14201A),
        // Color of the selected tab icon and label (Gold)
        selectedItemColor: Color(0xFFD4A017),
        // Color of unselected tab icons and labels (Muted green-gray)
        unselectedItemColor: Color(0xFF8E9B90),
        // Keeps all tabs fixed in place without shifting animation
        type: BottomNavigationBarType.fixed,
        // The list of 4 navigation bar items
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
            icon: Icon(Icons.document_scanner_outlined),
            label: "Scan",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  // Reusable helper function to build the rounded dark green statistic cards
  Widget buildStatCard({
    required String title,
    required String value,
    required String subtitle,
  }) {
    return Container(
      // Padding inside the card around the contents
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      // Card appearance with dark olive background and rounded corners
      decoration: BoxDecoration(
        color: Color(0xFF1E2B22),
        borderRadius: BorderRadius.circular(16),
      ),
      // Column stacks the title, big value number, and subtitle vertically
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