import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PhoneEntryScreen(),
  ));
}

class PhoneEntryScreen extends StatelessWidget {
  PhoneEntryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F1811),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {

                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFF1B281E),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: Color(0xFFE5A93C), // Gold badge
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "AB",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 32),


              Text(
                "Enter your phone\nnumber.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),

              SizedBox(height: 32),


              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Color(0xFF1B281E),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Color(0xFFE5A93C), // Gold border highlight
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFF142017),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "+880",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),

                    SizedBox(width: 12),


                    Container(
                      width: 1,
                      height: 28,
                      color: Colors.white24,
                    ),

                    SizedBox(width: 12),


                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                        decoration: InputDecoration(
                          hintText: "01712-345678",
                          hintStyle: TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Spacer(),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE5A93C), // Gold button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          backgroundColor: Color(0xFF0F1811),
                          appBar: AppBar(
                            title: Text("Verification"),
                            backgroundColor: Color(0xFF0F1811),
                          ),
                          body: Center(
                            child: Text(
                              "Verification Code Sent!",
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Send Code",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}