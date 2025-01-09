import 'package:flutter/material.dart';
import 'splash_screen.dart'; // Import the SplashScreen file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shoply',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashHandler(), // Set the SplashHandler as the initial page
      debugShowCheckedModeBanner: false,
    );
  }
}
