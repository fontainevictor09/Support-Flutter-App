import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const ADHDSupportApp());
}

class ADHDSupportApp extends StatelessWidget {
  const ADHDSupportApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ADHD Support',
      theme: ThemeData(
        primaryColor: const Color(0xFF5E35B1),
        scaffoldBackgroundColor: const Color(0xFF5E35B1),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5E35B1),
          secondary: Colors.white,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
