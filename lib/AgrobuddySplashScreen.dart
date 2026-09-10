import 'package:flutter/material.dart';

class AgrobuddySplashScreen extends StatelessWidget{
  const AgrobuddySplashScreen({super.key});

  

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFF121C16),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: const Color(0xFFE5A633),
                shape: BoxShape.circle,

                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFE5A633).withValues(alpha: 0.35),
                    blurRadius: 25,
                    spreadRadius: 6,
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'AB',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF14221A),
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),


            const SizedBox(height: 28),
            const Text(
              'AgroBuddy',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE5A633),
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Building smarter tools for modern\nfarming',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                height: 1.4,

              ),
            ),
          ],
        ),
      ),
    );

  }

}
