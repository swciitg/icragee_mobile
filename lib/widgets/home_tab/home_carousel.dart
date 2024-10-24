import 'package:flutter/material.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/widgets/home_tab/home_carousel_tile.dart';

class HomeCarousel extends StatefulWidget {
  const HomeCarousel({super.key});

  @override
  State<HomeCarousel> createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DataService.getUserEventIds("venkylm10@gmail.com"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('An error occurred'));
        }
        List<String> eventIds = snapshot.data!;
        if (eventIds.isEmpty) {
          return const Center(child: Text('No events lined up'));
        }
        
        // userEvents.sort((a, b) => a.startTime.isBefore(b.startTime) ? -1 : 1);
        return Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              physics: const PageScrollPhysics(),
              child: Row(
                children: List.generate(
                  eventIds.length,
                  (index) => StreamBuilder(
                    stream: DataService.getEventById(eventIds[index]),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return const Center(child: Text('Something went wrong!'));
                      }
                      final event = snapshot.data!;
                      return HomeCarouselTile(event: event);
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
