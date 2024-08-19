import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:new_digitalis_event_app/config/routers/app_route.dart';
import 'package:new_digitalis_event_app/data/services/app/get_events_service.dart';
import 'package:new_digitalis_event_app/data/services/app/get_pub_service.dart';
import 'package:new_digitalis_event_app/model/api_response_model.dart';
import 'package:new_digitalis_event_app/model/events_model.dart';
import 'package:new_digitalis_event_app/model/publicite_model.dart';
import 'package:new_digitalis_event_app/responsive/size_config.dart';
import 'package:new_digitalis_event_app/utils/constants/app_colors/app_colors.dart';
import 'package:new_digitalis_event_app/views/details/event_details_page.dart';
import 'package:new_digitalis_event_app/views/home_view/publicites/single_pub_card.dart';
import 'package:new_digitalis_event_app/views/home_view/widgets/en_cours/single_event_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  List<Event> eventList = [];
  List<Event> endEventList = [];
  List<PubliciteModel> pubList = [];
  bool loading = true;

  @override
  void initState() {
    retrievePub();
    retrieveEventInProgress();
    retrieveEndEvent();
    super.initState();
  }

  Future<void> retrievePub() async {
    setState(() {
      loading = true;
    });
    ApiResponse response = await getPub();
    if (response.message == null) {
      Map<String, dynamic> jsonResponse = response.data as Map<String, dynamic>;
      List<dynamic> pubData = jsonResponse['data'] as List<dynamic>;
      pubList = pubData
          .map<PubliciteModel>((json) => PubliciteModel.fromJson(json))
          .toList();
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> retrieveEventInProgress() async {
    setState(() {
      loading = true;
    });

    ApiResponse response = await getEvents();
    if (response.message == null) {
      Map<String, dynamic> jsonResponse = response.data as Map<String, dynamic>;

      List<dynamic> allEventsData = jsonResponse['data'] as List<dynamic>;

      List<dynamic> myInProgressEventData =
          allEventsData.where((event) => event['status'] == 'valider').toList();

      eventList = myInProgressEventData
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

  Future<void> retrieveEndEvent() async {
    setState(() {
      loading = true;
    });

    ApiResponse response = await getEvents();
    if (response.message == null) {
      Map<String, dynamic> jsonResponse = response.data as Map<String, dynamic>;

      List<dynamic> allEventsData = jsonResponse['data'] as List<dynamic>;

      List<dynamic> myInProgressEventData = allEventsData
          .where((event) => event['status'] == 'terminer')
          .toList();

      endEventList = myInProgressEventData
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
    SizeConfigs().init(context);
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
                  "Nos Publicités",
                  style: TextStyle(
                      color: kWhiteColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: SizeConfigs.screenHeight! * 0.01,
                ),
                CarouselSlider(
                  items: pubList
                      .map((pub) => SinglePubCard(pubModel: pub))
                      .toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    height: SizeConfigs.screenHeight! * 0.2,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: SizeConfigs.screenHeight! * 0.03,
                ),
                const Text(
                  "Evenements en cours",
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
                          children: eventList
                              .map((events) => GestureDetector(
                                  onTap: () {
                                    AppRoutes.pushToNextPage(context,
                                        EventDetailsPage(event: events));
                                  },
                                  child: SingleEventCard(eventModel: events)))
                              .toList(),
                        ),
                      ),
                // Widget pour les evemements en cours

                SizedBox(
                  height: SizeConfigs.screenHeight! * 0.03,
                ),
                const Text(
                  "Evenements terminés",
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
                          children: endEventList
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
                // Widgets pour les evenments terminés
              ],
            ),
          )
        ],
      ),
    );
  }
}
