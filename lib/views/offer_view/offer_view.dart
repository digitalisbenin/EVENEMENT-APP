import 'package:flutter/material.dart';
import 'package:new_digitalis_event_app/config/routers/app_route.dart';
import 'package:new_digitalis_event_app/data/services/app/get_events_service.dart';
import 'package:new_digitalis_event_app/model/api_response_model.dart';
import 'package:new_digitalis_event_app/model/events_model.dart';
import 'package:new_digitalis_event_app/responsive/size_config.dart';
import 'package:new_digitalis_event_app/utils/constants/app_colors/app_colors.dart';
import 'package:new_digitalis_event_app/views/details/event_details_page.dart';
import 'package:new_digitalis_event_app/views/home_view/widgets/en_cours/single_event_card.dart';

class OfferViewPage extends StatefulWidget {
  const OfferViewPage({super.key});

  @override
  State<OfferViewPage> createState() => _OfferViewPageState();
}

class _OfferViewPageState extends State<OfferViewPage> {
  List<Event> eventProList = [];
  List<Event> studentEventList = [];
  List<Event> digitalEventList = [];
  bool loading = true;

  @override
  void initState() {
    retrieveProEvent();
    retrieveStudentEvent();
    retrieveDigitalEvent();
    super.initState();
  }

  Future<void> retrieveProEvent() async {
    setState(() {
      loading = true;
    });

    ApiResponse response = await getEvents();
    if (response.message == null) {
      Map<String, dynamic> jsonResponse = response.data as Map<String, dynamic>;

      List<dynamic> allEventsData = jsonResponse['data'] as List<dynamic>;

      List<dynamic> myEventData =
      allEventsData.where((event) => event['type_demande']['name'] == 'Evenement Pro').toList();

      eventProList = myEventData
          .map<Event>((json) => Event.fromJson(json))
          .toList();

      setState(() {
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.message}'),
      ));
    }
  }

  Future<void> retrieveStudentEvent() async {
    setState(() {
      loading = true;
    });

    ApiResponse response = await getEvents();
    if (response.message == null) {
      Map<String, dynamic> jsonResponse = response.data as Map<String, dynamic>;

      List<dynamic> allEventsData = jsonResponse['data'] as List<dynamic>;

      List<dynamic> myEventData =
      allEventsData.where((event) => event['type_demande']['name'] == 'Evement Etidiant').toList();

      studentEventList = myEventData
          .map<Event>((json) => Event.fromJson(json))
          .toList();

      setState(() {
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.message}'),
      ));
    }
  }

  Future<void> retrieveDigitalEvent() async {
    setState(() {
      loading = true;
    });

    ApiResponse response = await getEvents();
    if (response.message == null) {
      Map<String, dynamic> jsonResponse = response.data as Map<String, dynamic>;

      List<dynamic> allEventsData = jsonResponse['data'] as List<dynamic>;

      List<dynamic> myEventData =
      allEventsData.where((event) => event['type_demande']['name'] == 'Evenement Digital').toList();

      digitalEventList = myEventData
          .map<Event>((json) => Event.fromJson(json))
          .toList();

      setState(() {
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.message}'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
                  "Evenements Pro",
                  style: TextStyle(
                      color: kWhiteColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: SizeConfigs.screenHeight! * 0.01,
                ),
                loading
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: eventProList
                        .map((events) =>
                        GestureDetector(
                            onTap: () {
                              AppRoutes.pushToNextPage(context,
                                  EventDetailsPage(event: events));
                            },
                            child: SingleEventCard(eventModel: events)))
                        .toList(),
                  ),
                ),

                // Widget pour les evemements pro
                SizedBox(
                  height: SizeConfigs.screenHeight! * 0.03,
                ),
                const Text(
                  "Evenements Etudiants",
                  style: TextStyle(
                      color: kWhiteColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: SizeConfigs.screenHeight! * 0.01,
                ),
                loading
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: studentEventList
                        .map((events) =>
                        GestureDetector(
                            onTap: () {
                              AppRoutes.pushToNextPage(context,
                                  EventDetailsPage(event: events));
                            },
                            child: SingleEventCard(eventModel: events)))
                        .toList(),
                  ),
                ),
                // Widgets pour les evenments etudiants

                SizedBox(
                  height: SizeConfigs.screenHeight! * 0.03,
                ),
                const Text(
                  "Evenements Digitaux",
                  style: TextStyle(
                      color: kWhiteColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: SizeConfigs.screenHeight! * 0.01,
                ),
                loading
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: digitalEventList
                        .map((events) =>
                        GestureDetector(
                            onTap: () {
                              AppRoutes.pushToNextPage(context,
                                  EventDetailsPage(event: events));
                            },
                            child: SingleEventCard(eventModel: events)))
                        .toList(),
                  ),
                ),
                // Widgets pour les evenments digitaux
              ],
            ),
          )
        ],
      ),
    );
  }
}
