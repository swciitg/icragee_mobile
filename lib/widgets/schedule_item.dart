import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icragee_mobile/models/event.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/shared/assets.dart';
import 'package:icragee_mobile/widgets/snackbar.dart';
import 'package:intl/intl.dart';

class ScheduleItem extends StatefulWidget {
  final Event schedule;

  const ScheduleItem({required this.schedule, super.key});

  @override
  State<ScheduleItem> createState() => _ScheduleItemState();
}

class _ScheduleItemState extends State<ScheduleItem> {
  var showDescription = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: MyColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.schedule.title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              _buildStatus(),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.schedule_outlined, size: 17),
              const SizedBox(width: 2),
              Expanded(
                child: Text(
                  '${DateFormat('kk:mm').format(widget.schedule.startTime.toLocal())}'
                  ' - ${DateFormat('kk:mm').format(widget.schedule.endTime.toLocal())}',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 17),
              Expanded(
                child: Text(
                  widget.schedule.venue,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showDescription = !showDescription;
                  });
                },
                child: Row(
                  children: [
                    Text(
                      "Check description",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: MyColors.primaryColor,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Transform.rotate(
                        angle: showDescription ? pi : 0,
                        child: SvgPicture.asset(MyIcons.toggleDown, height: 18))
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (showDescription)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                widget.schedule.description,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff1C1C1C),
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: MyColors.primaryColorTint,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SvgPicture.asset(MyIcons.location),
              ),
              GestureDetector(
                onTap: addEventToUser,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: MyColors.primaryColorTint,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SvgPicture.asset(MyIcons.addToList),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void addEventToUser() async {
    try {
      // TODO: remove email hardcoding
      await DataService.addEventToUser(
        "venkylm10@gmail.com",
        widget.schedule.id,
      );
      showSnackBar("Added to your schedule");
    } catch (e) {
      debugPrint(e.toString());
      showSnackBar("Failed to add to your schedule");
    }
  }

  Widget _buildStatus() {
    var status = "";
    late Color color;
    if (widget.schedule.endTime.isBefore(DateTime.now())) {
      status = "Finished";
      color = Colors.black;
    } else if (widget.schedule.startTime.isBefore(DateTime.now()) &&
        widget.schedule.endTime.isAfter(DateTime.now())) {
      status = "Ongoing";
      color = const Color(0xffFF8C40);
    } else {
      status = "Upcoming";
      color = MyColors.primaryColor;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 10,
            width: 10,
            margin: const EdgeInsets.only(right: 4),
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
          Text(
            status,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
