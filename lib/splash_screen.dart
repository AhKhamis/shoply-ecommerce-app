import 'package:flutter/material.dart';
import 'welcome_pages/welcome_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3DAFE7), Color(0xFF1A4C64)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Material(
            elevation: 10, // Add elevation for a shadow effect
            borderRadius: BorderRadius.circular(25), // Rounded corners
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(25), // Same radius for the clipping
              child: Image.asset(
                'assets/logo.png',
                width: 100, // Adjust the size of the logo as needed
                height: 100,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SplashHandler extends StatefulWidget {
  const SplashHandler({super.key});

  @override
  _SplashHandlerState createState() => _SplashHandlerState();
}

class _SplashHandlerState extends State<SplashHandler> {
  @override
  void initState() {
    super.initState();
    // Simulate downloading or initialization
    Future.delayed(const Duration(seconds: 3), () {
      // After 3 seconds, navigate to HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen(); // Show SplashScreen while waiting
  }
}
