import 'package:flutter/material.dart';
import 'themes/app_theme.dart';
import 'firebase_service.dart';
import 'widgets/offline_wrapper.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final firebaseService = FirebaseService();
  await firebaseService.initialize();

  runApp(const AgroBuddyApp());
}


class AgroBuddyApp extends StatelessWidget {
  const AgroBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgroBuddy',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      builder: (context, child) {
        return OfflineWrapper(
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: const SplashScreen(),
    );
  }
}
