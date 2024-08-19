import 'package:flutter/material.dart';
import 'package:new_digitalis_event_app/config/routers/app_route.dart';
import 'package:new_digitalis_event_app/data/services/auth/user_service.dart';
import 'package:new_digitalis_event_app/responsive/size_config.dart';
import 'package:new_digitalis_event_app/views/contact_view/contact_page.dart';
import 'package:new_digitalis_event_app/views/home_view/home_page.dart';
import 'package:new_digitalis_event_app/views/login_view/login_screen.dart';
import 'package:new_digitalis_event_app/views/offer_view/offer_view.dart';

import '../../../utils/constants/app_colors/app_colors.dart';

class BottomBarPage extends StatefulWidget {
  const BottomBarPage({super.key});

  @override
  State<BottomBarPage> createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  int currentIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const OfferViewPage(),
    // const AboutPage(),
    const ContactPage(),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image(
          image: const AssetImage("assets/images/LOG.png"),
          height: SizeConfigs.screenHeight! * 0.08,
        ),
        actions: [
          IconButton(
              onPressed: () {
                logout().then((value) => {
                  AppRoutes.pushAndRemoveUntil(
                    context,
                    const LoginPage(),
                  )
                });
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Vous avez été déconnecté !"), backgroundColor: Colors.white));
              },
              icon: const Icon(
                Icons.logout,
                size: 25,
                color: kWhiteColor,
              ))
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: kDeepPurpleColor,
          elevation: 0,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: kWhiteColor,
              ),
              activeIcon: Icon(
                Icons.home,
                color: kWhiteColor,
              ),
              label: 'Acceuil',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.local_offer_outlined,
                color: kWhiteColor,
              ),
              activeIcon: Icon(
                Icons.local_offer,
                color: kWhiteColor,
              ),
              label: 'Nos Offres',
            ),
            /*BottomNavigationBarItem(
              icon: Icon(Icons.account_box_outlined, color: kWhiteColor,),
              activeIcon: Icon(Icons.account_box, color: kWhiteColor,),
              label: 'A Propos',
            ),*/
            BottomNavigationBarItem(
              icon: Icon(
                Icons.contact_mail_outlined,
                color: kWhiteColor,
              ),
              activeIcon: Icon(
                Icons.contact_mail,
                color: kWhiteColor,
              ),
              label: 'Contact',
            ),
          ],
          currentIndex: currentIndex,
          selectedItemColor: kWhiteColor,
          unselectedItemColor: Colors.grey,
          onTap: (int intValue) {
            setState(() {
              currentIndex = intValue;
            });
          },
          selectedIconTheme: const IconThemeData(
            color: kWhiteColor,
          ),
        ),
      ),
      body: IndexedStack(
        children: [
          _widgetOptions.elementAt(currentIndex),
        ],
      ),
    );
  }
}
