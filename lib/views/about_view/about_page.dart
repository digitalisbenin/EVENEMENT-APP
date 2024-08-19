import 'package:flutter/material.dart';
import 'package:new_digitalis_event_app/utils/constants/app_colors/app_colors.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("About Page", style: TextStyle(color: kWhiteColor),),
      ),
    );
  }
}
