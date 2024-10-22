import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:icragee_mobile/models/event.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/widgets/home_tab/home_carousel_tile.dart';

class HomeCarousel extends StatefulWidget {
  final List<Event> events;

  const HomeCarousel({required this.events, super.key});

  @override
  State<HomeCarousel> createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Row(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(15, 8, 15, 0),
            child: Text(
              "Upcoming Events",
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
      CarouselSlider(
        items: widget.events.map((event) {
          return HomeCarouselTile(event: event);
        }).toList(),
        options: CarouselOptions(
          height: 190,
          viewportFraction: 1,
          animateToClosest: false,
          enableInfiniteScroll: false,
          padEnds: false,
          aspectRatio: 1,
          onPageChanged: (index, reason) {
            setState(() {
              activeIndex = index;
            });
          },
        ),
      ),
      widget.events.length <= 1
          ? const SizedBox.shrink()
          : DotsIndicator(
              position: activeIndex,
              decorator: const DotsDecorator(
                color: Colors.white,
                activeColor: MyColors.secondaryColor,
                spacing: EdgeInsets.symmetric(horizontal: 3),
                size: Size(5, 5),
                activeSize: Size(5, 5),
              ),
              dotsCount: widget.events.length,
            ),
    ]);
  }
}
