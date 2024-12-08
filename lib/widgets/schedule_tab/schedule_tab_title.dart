import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/widgets/snackbar.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ScheduleTabTitle extends StatefulWidget {
  const ScheduleTabTitle({
    super.key,
    required this.scrollController,
    required this.calendarView,
    required this.onCalendarViewChanged,
  });

  final ScrollController scrollController;
  final bool calendarView;
  final VoidCallback onCalendarViewChanged;

  @override
  State<ScheduleTabTitle> createState() => _ScheduleTabTitleState();
}

class _ScheduleTabTitleState extends State<ScheduleTabTitle> {
  var _showRoundedCorner = false;

  @override
  void initState() {
    widget.scrollController.addListener(() {
      if (widget.scrollController.offset > 30 && !_showRoundedCorner) {
        setState(() {
          _showRoundedCorner = true;
        });
      } else if (widget.scrollController.offset <= 30 && _showRoundedCorner) {
        setState(() {
          _showRoundedCorner = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: MyColors.primaryColor,
      title: Text(
        'Schedule',
        style: GoogleFonts.poppins(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: MyColors.whiteColor,
        ),
      ),
      pinned: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(widget.scrollController.offset > 30 ? 24 : 0),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            final url = await DataService.getScheduleUrl();
            if (url != null) {
              launchUrlString(url);
            } else {
              showSnackBar('Schedule not available');
            }
          },
          icon: Icon(
            Icons.picture_as_pdf_rounded,
            color: MyColors.whiteColor,
          ),
        ),
        const SizedBox(width: 4),
        IconButton(
          onPressed: widget.onCalendarViewChanged,
          icon: Icon(
            widget.calendarView ? Icons.list : Icons.calendar_today,
            color: MyColors.whiteColor,
          ),
        ),
        const SizedBox(width: 4),
      ],
    );
  }
}
