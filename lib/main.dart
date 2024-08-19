import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_digitalis_event_app/views/splash_view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'D-Event',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(textTheme: GoogleFonts.interTextTheme()),
      home: const SplashScreen(),
    );
  }
}
