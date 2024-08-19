import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_digitalis_event_app/config/routers/app_route.dart';
import 'package:new_digitalis_event_app/data/services/auth/user_service.dart';
import 'package:new_digitalis_event_app/model/api_response_model.dart';
import 'package:new_digitalis_event_app/responsive/size_config.dart';
import 'package:new_digitalis_event_app/utils/constants/app_colors/app_colors.dart';
import 'package:new_digitalis_event_app/views/login_view/login_screen.dart';
import 'package:new_digitalis_event_app/widgets/app_btn/primary_button.dart';
import 'package:new_digitalis_event_app/widgets/app_btn/secondary_button.dart';
import 'package:new_digitalis_event_app/widgets/input_widgets/input_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();

  bool agreeToTerms = false;

  bool loading = false;

  void _registerUser() async {
    ApiResponse response = await register(
        fullNameController.text, emailController.text, passwordController.text);

    if (response.message == 'Validation errors') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${response.message}"),
        backgroundColor: Colors.red,
      ));
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Inscription réussi"), backgroundColor: Colors.green));
      AppRoutes.pushToNextPage(context, const LoginPage());
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
                        height: SizeConfigs.screenHeight! * 0.04,
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Image(
                            height: SizeConfigs.screenHeight! * 0.15,
                            image: const AssetImage("assets/images/LOG.png")),
                      ),
                      SizedBox(
                        height: SizeConfigs.screenHeight! * 0.03,
                      ),
                      Center(
                          child: Text(
                        "Inscription",
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
                                label: "Nom et Prénom(s)",
                                controller: fullNameController,
                                bgColor: kWhiteColor,
                                suffixIcon: Icons.person_outline,
                              ),
                              SizedBox(
                                height: SizeConfigs.screenHeight! * 0.01,
                              ),
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
                              SizedBox(
                                height: SizeConfigs.screenHeight! * 0.01,
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: agreeToTerms,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        agreeToTerms = value!;
                                      });
                                    },
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Je suis d'accord avec les termes de conditions",
                                      style: GoogleFonts.workSans(
                                          color: kGrey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: SizeConfigs.screenHeight! * 0.02,
                              ),
                              PrimaryButton(
                                  buttonTitle: "S'inscrire",
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      if (fullNameController.text.isEmpty ||
                                          emailController.text.isEmpty ||
                                          passwordController.text.isEmpty) {
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                          content: Text("Tout les champs de saisie sont obligatoire"),
                                          backgroundColor: Colors.red,
                                        ));
                                      } else {
                                        setState(() {
                                          loading = true;
                                          _registerUser();
                                        });
                                      }
                                    }
                                  }),
                              SizedBox(
                                height: SizeConfigs.screenHeight! * 0.03,
                              ),
                              SecondaryButton(
                                buttonTitle: "Se connecter",
                                onPressed: () {
                                  Navigator.pop(context);
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
