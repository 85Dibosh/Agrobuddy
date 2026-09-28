import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MarketplaceScreen(),
  ));
}

class MarketplaceScreen extends StatefulWidget {
  MarketplaceScreen({Key? key}) : super(key: key);

  @override
  MarketplaceScreenState createState() => MarketplaceScreenState();
}

class MarketplaceScreenState extends State<MarketplaceScreen> {

  int selectedTab = 1; // Default to 'Market' tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F1811),
      body: SafeArea(
        child: Column(
          children: [

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: Color(0xFFE5A93C),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "AB",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      }