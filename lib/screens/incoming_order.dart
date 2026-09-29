import 'package:flutter/material.dart';

class IncomingOrdersScreen extends StatelessWidget {
  IncomingOrdersScreen({super.key});

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
            margin: EdgeInsets.only(right: 16, top: 8, bottom: 8),
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Color(0xFFD4A017),
              shape: BoxShape.circle,
            ),
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Incoming Orders",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6),
              Text(
                "Buyer orders for your listed crops",
                style: TextStyle(
                  color: Color(0xFF8E9B90),
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 24),
              buildOrderCard(
                buyerName: "Fahim Ahmed",
                orderDetails: "Aman Paddy • 150 kg",
                orderValue: "৳12,750",
                statusText: "New",
                isNew: true,
              ),
              SizedBox(height: 16),
              buildOrderCard(
                buyerName: "Tariqul Islam",
                orderDetails: "Organic Wheat • 80 kg",
                orderValue: "৳5,200",
                statusText: "New",
                isNew: true,
              ),
              SizedBox(height: 16),
              buildOrderCard(
                buyerName: "Kamrul Hasan",
                orderDetails: "Fresh Tomatoes • 50 kg",
                orderValue: "৳3,500",
                statusText: "Fulfilled",
                isNew: false,
              ),
              SizedBox(height: 16),
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

  Widget buildOrderCard({
    required String buyerName,
    required String orderDetails,
    required String orderValue,
    required String statusText,
    required bool isNew,
  }) {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Color(0xFF1E2B22),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    buyerName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    orderDetails,
                    style: TextStyle(
                      color: Color(0xFF8E9B90),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isNew ? Colors.transparent : Color(0xFF2E3B23),
                  borderRadius: BorderRadius.circular(14),
                  border: isNew
                      ? Border.all(color: Color(0xFFD4A017), width: 1)
                      : null,
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    color: isNew ? Color(0xFFD4A017) : Color(0xFF8E9B90),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Divider(
            color: Color(0xFF2E3B23),
            thickness: 1,
            height: 1,
          ),
          SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ORDER VALUE",
                style: TextStyle(
                  color: Color(0xFF8E9B90),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
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