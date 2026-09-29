import 'package:agrobuddy/App_screen/role_selection_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class AgrobuddySplashScreen extends StatefulWidget {
  const AgrobuddySplashScreen({super.key});

  @override
  State<AgrobuddySplashScreen> createState() => _AgrobuddySplashScreenState();
}

class _AgrobuddySplashScreenState extends State<AgrobuddySplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const RoleSelectionScreen(),
        ),

      );
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFF121C16),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: Color(0xFFE5A633),
                shape: BoxShape.circle,

                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFE5A633).withValues(alpha: 0.35),
                    blurRadius: 25,
                    spreadRadius: 6,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'AB',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF14221A),
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),


             SizedBox(height: 28),
             Text(
              'AgroBuddy',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE5A633),
              ),
            ),

             SizedBox(height: 16),

             Text(
              'Building smarter tools for modern\nfarming',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                height: 1.4,

              ),
            ),
            
            SizedBox(height: 36),
            SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: Color(0xFFE5A633),
              ),
            )

            
          ],
        ),
      ),
    );

  }

}

//intial placeholder for splash

// class HomeScreen extends StatelessWidget{
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text(
//           'AgroBuddy HOME',
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }
// }
