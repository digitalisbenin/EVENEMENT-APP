import 'package:flutter/material.dart';

const kScaffoldColor = Color(0xffF4F5F9);
Color kGrey = const Color(0xff858889);
const Color kBlackColor = Colors.black;
Color kLightBlackColor = Colors.black.withOpacity(0.5);
const Color kWhiteColor = Colors.white;
Color kLightWhiteColor = Colors.white.withOpacity(0.5);
const Color kDeepPurpleColor = Color(0xff3b2865);
const Color kPrimaryColor = Color(0xFF17192C);
Gradient kGradientColor = const LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    kDeepPurpleColor,
    kPrimaryColor,
  ],
);

MaterialColor materialPrimaryColor = const MaterialColor(
  0xFF17192C, // Replace with your desired color value
  <int, Color>{
    50: Color(0xFF17192C),
    100: Color(0xFF17192C),
    200: Color(0xFF17192C),
    300: Color(0xFF17192C),
    400: Color(0xFF17192C),
    500: Color(0xFF17192C),
    600: Color(0xFF17192C),
    700: Color(0xFF17192C),
    800: Color(0xFF17192C),
    900: Color(0xFF17192C),
  },
);

final colorScheme = ColorScheme.fromSwatch(
  primarySwatch: const MaterialColor(0xFF17192C, {
    50: Color(0xFF17192C),
    100: Color(0xFF17192C),
    200: Color(0xFF17192C),
    300: Color(0xFF17192C),
    400: Color(0xFF17192C),
    500: Color(0xFF17192C),
    600: Color(0xFF17192C),
    700: Color(0xFF17192C),
    800: Color(0xFF17192C),
    900: Color(0xFF17192C),
  }),
);
