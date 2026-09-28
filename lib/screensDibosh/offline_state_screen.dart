import 'package:flutter/material.dart';

class OfflineScreen extends StatelessWidget {
  const OfflineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFF132018),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon:  Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
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
              
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 108,
                      height: 108,
                      decoration:  BoxDecoration(
                        color: Color(0xFF263326),
                        shape: BoxShape.circle,
                      ),
                      child:  Center(
                        child: Icon(
                          Icons.wifi_off_rounded,
                          size: 46,
                          color: Color(0xFFE5A633),
                        ),
                      ),
                    ),
                     SizedBox(height: 32),

                     Text(
                      "You're offline",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                     SizedBox(height: 12),

                     Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Check your mobile network or Wi-Fi connection and try again.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white70,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Color(0xFFE5A633),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(
                        content: Text('Checking connection...'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child:  Text(
                    'Retry',
                    style: TextStyle(
                      color: Color(0xFF132018),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
               SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}