import 'package:flutter/material.dart';
import 'package:new_digitalis_event_app/data/services/app/send_comment_service.dart';
import 'package:new_digitalis_event_app/model/api_response_model.dart';
import 'package:new_digitalis_event_app/model/events_model.dart';
import 'package:new_digitalis_event_app/responsive/size_config.dart';
import 'package:new_digitalis_event_app/utils/constants/app_colors/app_colors.dart';
import 'package:new_digitalis_event_app/widgets/app_btn/primary_button.dart';
import 'package:new_digitalis_event_app/widgets/app_btn/secondary_button.dart';
import 'package:new_digitalis_event_app/widgets/format_date/format_date_constants.dart';
import 'package:new_digitalis_event_app/widgets/input_widgets/input_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailsPage extends StatefulWidget {
  final Event event;

  const EventDetailsPage({super.key, required this.event});

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController commentController = TextEditingController();

  bool loading = false;

  void _sendComment() async {
    ApiResponse response = await sendComment(
        commentController.text, widget.event.id!.toString());

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
          content: Text("Commentaire Envoyé"), backgroundColor: Colors.green));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5), BlendMode.darken),
                    child: Image.network(
                      widget.event.image ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 28,
                      )),
                ),
                Positioned(
                  bottom: 45,
                  left: 8,
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_month_outlined),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        "${formatDate(widget.event.dateDebuit!.toIso8601String())}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      const Icon(
                        Icons.access_time_outlined,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        "${formatTime(widget.event.dateDebuit!.toIso8601String())}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 8,
                  child: Row(
                    children: [
                      const Icon(Icons.location_on_outlined),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        "${widget.event.lieu}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.event.name ?? '',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.event.description ?? '',
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Time : ${formatTime(widget.event.dateDebuit!.toIso8601String())}",
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Location : ${widget.event.lieu}",
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      _launchUrl(
                          "https://www.google.com/maps/search/?api=1&query=${widget.event.lieu}");
                    },
                    icon: const Icon(Icons.map),
                    label: const Text("Ouvrir avec Google Maps")),
                const SizedBox(
                  height: 8,
                ),
                PrimaryButton(buttonTitle: "Achat de ticket", onPressed: () {}),
                const SizedBox(
                  height: 8,
                ),
                SecondaryButton(
                    buttonTitle: "Contacter",
                    onPressed: () {
                      _launchPhoneCall(widget.event.telephone ?? '');
                    })
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kDeepPurpleColor,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  insetPadding: const EdgeInsets.all(10),
                  child: Container(
                    width: double.infinity,
                    height: SizeConfigs.screenHeight! * 0.33,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Center(
                            child: Text("Laisser un commentaire",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700)),
                          ),
                          SizedBox(
                            height: SizeConfigs.screenHeight! * 0.03,
                          ),
                          Center(
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  InputField(
                                      label: "Commentaire",
                                      controller: commentController,
                                      bgColor: kWhiteColor),
                                  SizedBox(
                                    height: SizeConfigs.screenHeight! * 0.03,
                                  ),
                                  PrimaryButton(
                                      buttonTitle: "Envoyer", onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      if (commentController.text.isEmpty) {
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                          content: Text("Le champs est requis"),
                                          backgroundColor: Colors.red,
                                        ));
                                      } else {
                                        setState(() {
                                          loading = true;
                                          _sendComment();
                                        });
                                      }
                                    }
                                  })
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
        child: const Icon(
          Icons.comment,
          color: Colors.white,
        ),
      ),
    );
  }
}

Future<void> _launchUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}

Future<void> _launchPhoneCall(String phoneNumber) async {
  final Uri phoneUri = Uri(scheme: "tel", path: phoneNumber);
  if (!await launchUrl(phoneUri)) {
    throw Exception('Could not launch $phoneUri');
  }
}
