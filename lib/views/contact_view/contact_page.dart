import 'package:flutter/material.dart';
import 'package:new_digitalis_event_app/config/routers/app_route.dart';
import 'package:new_digitalis_event_app/data/services/app/send_message_service.dart';
import 'package:new_digitalis_event_app/model/api_response_model.dart';
import 'package:new_digitalis_event_app/responsive/size_config.dart';
import 'package:new_digitalis_event_app/utils/constants/app_colors/app_colors.dart';
import 'package:new_digitalis_event_app/views/bottom_view/bottom_view.dart';
import 'package:new_digitalis_event_app/widgets/app_btn/primary_button.dart';
import 'package:new_digitalis_event_app/widgets/input_widgets/input_widget.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController messageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();

  bool loading = false;

  void _sendMessage() async {
    ApiResponse response = await sendMessage(
        fullNameController.text, emailController.text, messageController.text);

    if (response.message == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${response.message}"),
        backgroundColor: Colors.red,
      ));
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Message Envoyé"), backgroundColor: Colors.green));
      AppRoutes.pushAndRemoveUntil(context, const BottomBarPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return Scaffold(
        body: Form(
          key: formKey,
          child: ListView(
                padding: EdgeInsets.zero,
                children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfigs.screenHeight! * 0.03,
                ),
                const Text(
                  "Prise de contact",
                  style: TextStyle(
                      color: kWhiteColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: SizeConfigs.screenHeight! * 0.01,
                ),
                InputField(
                    label: "Nom",
                    controller: fullNameController,
                    bgColor: kWhiteColor,
                    suffixIcon: Icons.person),
                SizedBox(
                  height: SizeConfigs.screenHeight! * 0.01,
                ),
                InputField(
                    label: "Email",
                    controller: emailController,
                    bgColor: kWhiteColor,
                    suffixIcon: Icons.email),
                SizedBox(
                  height: SizeConfigs.screenHeight! * 0.01,
                ),
                InputField(
                  height: SizeConfigs.screenHeight! * 0.2,
                  label: "Message",
                  controller: messageController,
                  bgColor: kWhiteColor,
                  maxLines: 6,
                ),
                SizedBox(
                  height: SizeConfigs.screenHeight! * 0.02,
                ),
                PrimaryButton(buttonTitle: "Envoyer", onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    if (fullNameController.text.isEmpty || emailController.text.isEmpty || messageController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Tous les champs sont requis"),
                        backgroundColor: Colors.red,
                      ));
                    } else {
                      setState(() {
                        loading = true;
                        _sendMessage();
                      });
                    }
                  }
                })
              ],
            ),
          )
                ],
              ),
        ));
  }
}
