import 'package:flutter/material.dart';

import 'App_screen/agrobuddy_splash_screen.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgroBuddyTest',
      debugShowCheckedModeBanner: false,
      home: AgrobuddySplashScreen(),
    );
  }
}