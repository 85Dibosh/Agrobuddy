import 'package:flutter/material.dart';
import 'package:agrobuddy/screensNishat/farmer_dashboard.dart';

void main() => runApp(const AgroBuddyApp());

class AgroBuddyApp extends StatelessWidget {
  const AgroBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: FarmerDashboardScreen(),
    );
  }
}
