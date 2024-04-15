import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentmanagementprovider/core/constants.dart';
import 'package:studentmanagementprovider/provider/flash_page_provider/flash_page_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<SplashProvider>(context, listen: false).goToLogin(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/splash_screen.png'),
            h2,
            const Text(
              'Student Management',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                  color: primarycolor),
            ),
            const Text(
              '- Provider -',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                  color: primarycolor),
            )
          ],
        ));
  }
}
