import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icragee_mobile/shared/colors.dart';

class ScheduleTabTitle extends StatefulWidget {
  const ScheduleTabTitle({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

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
    );
  }
}
