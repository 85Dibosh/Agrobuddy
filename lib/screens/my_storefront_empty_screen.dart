import 'package:flutter/material.dart';

class StorefrontEmptyScreen extends StatelessWidget {
  const StorefrontEmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFF132018),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.maybePop(context);
                    },
                  ),
                   SizedBox(width: 8),
                   Text(
                    'My Storefront',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                   Spacer(),
                  Container(
                    width: 38,
                    height: 38,
                    decoration:  BoxDecoration(
                      color: Color(0xFFE5A633),
                      shape: BoxShape.circle,
                    ),
                    child:  Center(
                      child: Text(
                        'AB',
                        style: TextStyle(
                          color: Color(0xFF132018),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Centered empty state info
              Expanded(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Circular container with storefront icon
                      Container(
                        width: 96,
                        height: 96,
                        decoration:  BoxDecoration(
                          color: Color(0xFF263326),
                          shape: BoxShape.circle,
                        ),
                        child:  Center(
                          child: Icon(
                            Icons.storefront_outlined,
                            size: 44,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                       SizedBox(height: 28),

                       Text(
                        'Your storefront is empty',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                       SizedBox(height: 14),

                      // Description text
                       Text(
                        'Publish your first crop listing to start receiving orders from verified buyers across the region.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white60,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //  Add Crop button
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding:  EdgeInsets.only(bottom: 12.0),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  Color(0xFFE5A633),
                      foregroundColor:  Color(0xFF132018),
                      elevation: 0,
                      padding:  EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {

                    },
                    icon:  Icon(
                      Icons.add,
                      size: 20,
                      color: Color(0xFF132018),
                    ),
                    label:  Text(
                      'Add Crop',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF132018),
                      ),
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