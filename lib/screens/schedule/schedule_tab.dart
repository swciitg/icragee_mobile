import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icragee_mobile/models/event.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/widgets/schedule_item.dart';
import 'package:icragee_mobile/widgets/schedule_tab/schedule_tab_title.dart';

class ScheduleTab extends StatefulWidget {
  const ScheduleTab({super.key});

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

class _ScheduleTabState extends State<ScheduleTab> {
  int selectedDay = 1;

  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          ScheduleTabTitle(scrollController: scrollController),
          SliverPersistentHeader(
            floating: true,
            delegate: _PinnedRowDelegate(
              minHeight: 60,
              maxHeight: 60,
              child: Container(
                decoration: const BoxDecoration(
                  color: MyColors.primaryColor,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(24),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedDay = index + 1;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: ShapeDecoration(
                              color: selectedDay == index + 1
                                  ? MyColors.whiteColor
                                  : MyColors.primaryColorTint,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x331C1C1C),
                                  blurRadius: 24,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Text(
                              'Day ${index + 1}',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: MyColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: FutureBuilder<List<Event>>(
              future: DataService.getDayWiseEvents(selectedDay),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Center(
                      child: Text('No schedules found for Day $selectedDay'),
                    ),
                  );
                } else {
                  List<Event> schedules = snapshot.data!;

                  return ListView.separated(
                    itemCount: schedules.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemBuilder: (context, index) =>
                        EventScheduleTile(event: schedules[index]),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class _PinnedRowDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _PinnedRowDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight > minHeight ? maxHeight : minHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxExtent ||
        minHeight != oldDelegate.minExtent ||
        child != (oldDelegate as _PinnedRowDelegate).child;
  }
}
