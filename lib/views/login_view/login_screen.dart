import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_digitalis_event_app/config/routers/app_route.dart';
import 'package:new_digitalis_event_app/data/services/auth/user_service.dart';
import 'package:new_digitalis_event_app/model/api_response_model.dart';
import 'package:new_digitalis_event_app/model/profile.dart';
import 'package:new_digitalis_event_app/responsive/size_config.dart';
import 'package:new_digitalis_event_app/utils/constants/app_colors/app_colors.dart';
import 'package:new_digitalis_event_app/views/bottom_view/bottom_view.dart';
import 'package:new_digitalis_event_app/views/home_view/home_page.dart';
import 'package:new_digitalis_event_app/views/register_view/register_screen.dart';
import 'package:new_digitalis_event_app/widgets/app_btn/primary_button.dart';
import 'package:new_digitalis_event_app/widgets/app_btn/secondary_button.dart';
import 'package:new_digitalis_event_app/widgets/input_widgets/input_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool loading = false;

  void _loginUser() async {
    ApiResponse response =
        await login(emailController.text, passwordController.text);
    print('login message ::: ${response.message}');
    if (response.message == 'Connecté avec succès') {
      _saveAndRedirectToHome(response.data as Profile);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${response.message}"),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ));
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${response.message}"),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ));
    }
  }

  void _saveAndRedirectToHome(Profile profile) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString("token", profile.token ?? '');
      await pref.setInt("userid", profile.id ?? 0);
      String? token = pref.getString("token");
      int? userId = pref.getInt("userid");
      if (token != null && userId != null) {
        print("Token and User ID saved successfully.");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const BottomBarPage()),
          (Route<dynamic> route) => false,
        );
      } else {
        print("Failed to save token and user ID.");
      }
    } catch (e) {
      print("Error saving preferences: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height / 2,
              child: Container(
                decoration: const BoxDecoration(color: kDeepPurpleColor),
              ),
            ),
            Positioned.fill(
              left: 0,
              right: 0,
              top: MediaQuery.of(context).size.height / 8,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(36),
                        topRight: Radius.circular(36))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: SizeConfigs.screenHeight! * 0.06,
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Image(
                            height: SizeConfigs.screenHeight! * 0.15,
                            image: const AssetImage("assets/images/LOG.png")),
                      ),
                      SizedBox(
                        height: SizeConfigs.screenHeight! * 0.05,
                      ),
                      Center(
                          child: Text(
                        "Connexion",
                        style: GoogleFonts.urbanist(
                            color: kWhiteColor,
                            fontSize: 23.37,
                            fontWeight: FontWeight.w900),
                      )),
                      SizedBox(
                        height: SizeConfigs.screenHeight! * 0.05,
                      ),
                      SingleChildScrollView(
                        padding: EdgeInsets.zero,
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              InputField(
                                label: "Email",
                                controller: emailController,
                                bgColor: kWhiteColor,
                                suffixIcon: Icons.email_outlined,
                              ),
                              SizedBox(
                                height: SizeConfigs.screenHeight! * 0.01,
                              ),
                              PassWordInput(
                                  controller: passwordController,
                                  text: "Mot de passe"),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    /*AppRoutes.pushToNextPage(
                                      context,
                                      const OtpVerification(),
                                    );*/
                                  },
                                  child: Text(
                                    "Mot de passe oublié?",
                                    style: GoogleFonts.workSans(
                                        color: kGrey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: SizeConfigs.screenHeight! * 0.02,
                              ),
                              PrimaryButton(
                                  buttonTitle: "Se Connecter",
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      setState(() {
                                        loading = true;
                                        _loginUser();
                                      });
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                            "Tout les champs de saisie sont obligatoire"),
                                        backgroundColor: Colors.red,
                                      ));
                                    }
                                  }),
                              SizedBox(
                                height: SizeConfigs.screenHeight! * 0.03,
                              ),
                              SecondaryButton(
                                buttonTitle: "Inscrivez-vous",
                                onPressed: () {
                                  AppRoutes.pushToNextPage(
                                      context, const RegisterPage());
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
