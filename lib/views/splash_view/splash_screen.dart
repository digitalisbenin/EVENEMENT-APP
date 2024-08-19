import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:new_digitalis_event_app/data/services/auth/user_service.dart';
import 'package:new_digitalis_event_app/responsive/size_config.dart';
import 'package:new_digitalis_event_app/views/bottom_view/bottom_view.dart';
import 'package:new_digitalis_event_app/views/login_view/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;
  bool showLottie = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();

    // Delay for 2 seconds before showing the Lottie animation
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        showLottie = true;
      });
      // Navigate to the OnboardingScreen after an additional delay
      Future.delayed(const Duration(seconds: 8), () {
        verifLogin();
       /* Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );*/
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> verifLogin() async {
    getToken().then((value) => {
      if (value == '')
        {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const LoginPage()),
                  (route) =>
              false)
        }
      else
        {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const BottomBarPage()),
                  (route) =>
              false)
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: FadeTransition(
              opacity: animation,
              child: Image.asset(
                'assets/images/LOG.png',
                // Changer le chemin de l'image avec votre image
                width: 200, // ajustez la taille de l'image selon votre besoin
                height: 200,
              ),
            ),
          ),
          if (showLottie)
            Positioned(
              bottom: 20, // Ajustez la position verticale du texte
              left: 0, // Alignement à gauche
              right: 0, // Alignement à droite
              child: Lottie.asset(
                  "assets/lotties/Animation - 1722847172741.json",
                  height: SizeConfigs.screenHeight! * 0.15),
            ),
        ],
      ),
    );
  }
}
