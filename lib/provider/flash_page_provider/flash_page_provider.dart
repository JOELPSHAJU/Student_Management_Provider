import 'package:flutter/material.dart';
import 'package:studentmanagementprovider/presentation/home_screen/home_screen.dart';


class SplashProvider extends ChangeNotifier {
  Future<void> goToLogin(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const HomeScreen(),
      ),
    );
  }
}
