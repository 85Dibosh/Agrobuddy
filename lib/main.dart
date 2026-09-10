import 'package:flutter/material.dart';

import 'screensDibosh/AgrobuddySplashScreen.dart';

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
