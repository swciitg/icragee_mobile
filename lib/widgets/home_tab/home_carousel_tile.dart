import 'package:flutter/material.dart';
import 'package:icragee_mobile/models/event.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:intl/intl.dart';

class HomeCarouselTile extends StatefulWidget {
  final Event event;

  // final UserDetails userEventDetails;

  const HomeCarouselTile({
    super.key,
    required this.event,
    // required this.userEventDetails,
  });

  @override
  State<HomeCarouselTile> createState() => _HomeCarouselTileState();
}

class _HomeCarouselTileState extends State<HomeCarouselTile> {
  void _updateUserEventDetails() {
    //   if (widget.userEventDetails.lastUpdated
    //       .isBefore(widget.event.lastUpdated)) {
    //     // TODO: remove hardcoded email once auth is implemented
    //     DataService.updateUserEvent("venkylm10@gmail.com", widget.event);
    //   }
  }

  @override
  void initState() {
    _updateUserEventDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width - 24,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: MyColors.navBarBackgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.event.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Speaker Name: Speaker",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            widget.event.description,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.access_time_outlined),
                const SizedBox(width: 5),
                Text(
                  DateFormat('k:mm').format(widget.event.startTime),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(width: 15),
                const Icon(Icons.location_on_outlined),
                const SizedBox(width: 5),
                Text(
                  widget.event.venue,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
