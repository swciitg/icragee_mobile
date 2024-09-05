import 'package:flutter/material.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/widgets/home_tab/home_carousel_tile.dart';

class HomeCarousel extends StatelessWidget {
  const HomeCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DataService.getUserEventIds("venkylm10@gmail.com"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('An error occurred'));
        }
        final eventIds = snapshot.data!;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
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
                    return const Center(child: Text('An error occurred'));
                  }
                  final event = snapshot.data!;
                  return HomeCarouselTile(event: event);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
