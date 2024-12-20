import 'package:flutter/material.dart';
import 'package:icragee_mobile/models/event.dart';
import 'package:icragee_mobile/models/user_details.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/widgets/home_tab/home_carousel.dart';

class HomeCarouselView extends StatefulWidget {
  const HomeCarouselView({super.key});

  @override
  State<HomeCarouselView> createState() => _HomeCarouselViewState();
}

class _HomeCarouselViewState extends State<HomeCarouselView> {
  Future<List<String>> _getUserEventIds() async {
    final user = await UserDetails.getFromSharedPreferences();
    if (user == null) {
      return Future.error("User Not Logged In");
    }
    return DataService.getUserEventIds(user.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUserEventIds(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('An error occurred'));
        }
        List<String> eventIds = snapshot.data!;
        if (eventIds.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  "Saved Events",
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('No saved events'),
                  ],
                ),
              ],
            ),
          );
        }

        return StreamBuilder(
          stream: DataService.getUserEvents(eventIds),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: MyColors.primaryColor,
              ));
            }
            if (snapshot.hasError || !snapshot.hasData) {
              return const Center(child: Text('An error occurred'));
            }
            List<Event> userEvents = snapshot.data!;
            userEvents.sort((a, b) => a.startTime.isBefore(b.startTime) ? -1 : 1);
            return HomeCarousel(
              events: userEvents,
              rebuild: () {
                setState(() {});
              },
            );
          },
        );
      },
    );
  }
}
