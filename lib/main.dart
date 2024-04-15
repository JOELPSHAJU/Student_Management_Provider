import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:studentmanagementprovider/presentation/splash_screen/splash_screen.dart';
import 'package:studentmanagementprovider/provider/add_student_provider/add_student_provider.dart';
import 'package:studentmanagementprovider/provider/edit_student_provider/edit_student_provider.dart';
import 'package:studentmanagementprovider/provider/flash_page_provider/flash_page_provider.dart';
import 'package:studentmanagementprovider/provider/student_detail_provider/student_detail_provider.dart';
import 'package:studentmanagementprovider/provider/student_list_provider/student_list_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StudentDetailProvider()),
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => AddStudentProvider()),
        ChangeNotifierProvider(create: (_) => EditStudentProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Student Management (Provider)',
        home: const SplashScreen(),
        theme: ThemeData(
            fontFamily: GoogleFonts.poppins().fontFamily,
            textTheme: const TextTheme(
                bodyLarge: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                bodyMedium: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                bodySmall: TextStyle(color: Color.fromARGB(255, 0, 0, 0)))),
      ),
    );
  }
}
