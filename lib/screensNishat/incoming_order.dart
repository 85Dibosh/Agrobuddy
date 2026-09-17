// Imports Flutter's material design library which gives us standard widgets like texts, cards, and app bars
import 'package:flutter/material.dart';

// Defines a stateless widget for the Incoming Orders screen since it doesn't need to change states
class IncomingOrdersScreen extends StatelessWidget {
  // Constructor for the Incoming Orders screen widget with an optional key
  IncomingOrdersScreen({super.key});

  // The build method runs whenever Flutter draws or displays this screen on the phone
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
        // Removes the default drop shadow beneath the top bar
        elevation: 0,
        // Leading property places a clickable back arrow button on the left side
        leading: Padding(
          // Adds space around the back button container
          padding: EdgeInsets.all(8),
          // Container creates a circular dark backing for the back arrow
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF1E2B22),
              shape: BoxShape.circle,
            ),
            // IconButton makes the arrow interactive so the user can go back
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 18),
              onPressed: () {
                // Pops this screen off the navigation stack to return to the previous page
                Navigator.pop(context);
              },
            ),
          ),
        ),
        // Actions property places elements on the right side of the app bar
        actions: [
          // Container creates a gold circular badge with the letters 'AB'
          Container(
            margin: EdgeInsets.only(right: 16, top: 8, bottom: 8),
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Color(0xFFD4A017),
              shape: BoxShape.circle,
            ),
            // Centers the 'AB' text inside the gold circle
            child: Center(
              child: Text(
                "AB",
                style: TextStyle(
                  color: Color(0xFF14201A),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),

      // SafeArea ensures our content stays inside visible screen boundaries away from device notches
      body: SafeArea(
        // SingleChildScrollView allows the list of orders to scroll vertically if it overflows
        child: SingleChildScrollView(
          // Adds padding around all edges of the scrolling content area
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          // Column stacks the title header and order cards vertically from top to bottom
          child: Column(
            // Aligns all child widgets to the left side of the screen
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text widget for the main screen heading
              Text(
                "Incoming Orders",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Adds a tiny vertical gap between the title and subtitle
              SizedBox(height: 6),
              // Text widget explaining what the page shows
              Text(
                "Buyer orders for your listed crops",
                style: TextStyle(
                  color: Color(0xFF8E9B90),
                  fontSize: 14,
                ),
              ),
              // Adds space before the list of order cards begins
              SizedBox(height: 24),

              // First order card: New order from Fahim Ahmed
              buildOrderCard(
                buyerName: "Fahim Ahmed",
                orderDetails: "Aman Paddy • 150 kg",
                orderValue: "৳12,750",
                statusText: "New",
                isNew: true,
              ),
              // Vertical gap between cards
              SizedBox(height: 16),

              // Second order card: New order from Tariqul Islam
              buildOrderCard(
                buyerName: "Tariqul Islam",
                orderDetails: "Organic Wheat • 80 kg",
                orderValue: "৳5,200",
                statusText: "New",
                isNew: true,
              ),
              // Vertical gap between cards
              SizedBox(height: 16),

              // Third order card: Fulfilled order from Kamrul Hasan
              buildOrderCard(
                buyerName: "Kamrul Hasan",
                orderDetails: "Fresh Tomatoes • 50 kg",
                orderValue: "৳3,500",
                statusText: "Fulfilled",
                isNew: false,
              ),
              // Vertical gap between cards
              SizedBox(height: 16),

              // Fourth order card: Fulfilled order from Babul Mia
              buildOrderCard(
                buyerName: "Babul Mia",
                orderDetails: "Aman Paddy • 200 kg",
                orderValue: "৳16,000",
                statusText: "Fulfilled",
                isNew: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable helper function to build each individual order card cleanly
  Widget buildOrderCard({
    required String buyerName,
    required String orderDetails,
    required String orderValue,
    required String statusText,
    required bool isNew,
  }) {
    return Container(
      // Padding inside the card around all contents
      padding: EdgeInsets.all(18),
      // Container decoration with dark olive green background and rounded corners
      decoration: BoxDecoration(
        color: Color(0xFF1E2B22),
        borderRadius: BorderRadius.circular(16),
      ),
      // Column stacks the top info row, divider line, and bottom price row vertically
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row places the buyer info on the left and the status badge on the right
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Column for buyer name and crop details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text showing the buyer's name
                  Text(
                    buyerName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Adds a tiny vertical gap
                  SizedBox(height: 4),
                  // Text showing crop type and weight quantity
                  Text(
                    orderDetails,
                    style: TextStyle(
                      color: Color(0xFF8E9B90),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              // Container creates the status badge pill ('New' or 'Fulfilled')
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  // Gold color background if New, muted gray-green if Fulfilled
                  color: isNew ? Colors.transparent : Color(0xFF2E3B23),
                  borderRadius: BorderRadius.circular(14),
                  // Adds a thin gold border only if it's a new order badge
                  border: isNew
                      ? Border.all(color: Color(0xFFD4A017), width: 1)
                      : null,
                ),
                // Text showing the status label
                child: Text(
                  statusText,
                  style: TextStyle(
                    // Gold text if New, light gray text if Fulfilled
                    color: isNew ? Color(0xFFD4A017) : Color(0xFF8E9B90),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          // Adds vertical space before the divider line
          SizedBox(height: 16),
          // Divider creates a thin horizontal line across the card
          Divider(
            color: Color(0xFF2E3B23),
            thickness: 1,
            height: 1,
          ),
          // Adds vertical space after the divider line
          SizedBox(height: 14),
          // Row places the 'ORDER VALUE' label on the left and the price amount on the right
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Label text on the left
              Text(
                "ORDER VALUE",
                style: TextStyle(
                  color: Color(0xFF8E9B90),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              // Price amount text in bold gold on the right
              Text(
                orderValue,
                style: TextStyle(
                  color: Color(0xFFD4A017),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}