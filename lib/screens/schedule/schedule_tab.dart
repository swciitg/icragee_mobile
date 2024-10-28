import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icragee_mobile/models/event.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/shared/globals.dart';
import 'package:icragee_mobile/widgets/schedule_item.dart';
import 'package:icragee_mobile/widgets/schedule_tab/schedule_tab_days.dart';
import 'package:icragee_mobile/widgets/schedule_tab/schedule_tab_title.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ScheduleTab extends StatefulWidget {
  const ScheduleTab({super.key});

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

class _ScheduleTabState extends State<ScheduleTab> {
  int selectedDay = 1;
  bool calendarView = false;
  late CalendarController calendarController;
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    calendarController = CalendarController();
    super.initState();
    calendarController.displayDate = dayOneDate;
    setState(() {});
  }

  @override
  void dispose() {
    scrollController.dispose();
    calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          ScheduleTabTitle(
            scrollController: scrollController,
            calendarView: calendarView,
            onCalendarViewChanged: () {
              setState(() {
                calendarView = !calendarView;
              });
            },
          ),
          ScheduleTabDays(
            selectedDay: selectedDay,
            onDaySelected: (val) {
              setState(() {
                selectedDay = val;
                calendarController.displayDate =
                    dayOneDate.add(Duration(days: val - 1));
              });
            },
          ),
          SliverToBoxAdapter(
            child: FutureBuilder<List<Event>>(
              future: DataService.getDayWiseEvents(selectedDay),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: CircularProgressIndicator(
                        color: MyColors.primaryColor,
                      ),
                    ),
                  );
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
                  return calendarView
                      ? _buildCalendarView(schedules)
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: _buildListView(schedules),
                        );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Padding _buildCalendarView(List<Event> schedules) {
    final minDate = dayOneDate;
    final maxDate = dayOneDate.add(const Duration(days: 4));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height - 64,
        child: SfCalendar(
          view: CalendarView.timelineDay,
          minDate: minDate,
          maxDate: maxDate,
          dataSource: EventDataSource(schedules),
          controller: calendarController,
          timeSlotViewSettings: const TimeSlotViewSettings(
            startHour: 8,
            endHour: 20,
            timeInterval: Duration(hours: 1),
          ),
          headerStyle: CalendarHeaderStyle(
            textStyle: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            backgroundColor: MyColors.primaryColorTint,
          ),
          cellBorderColor: MyColors.primaryTextColor,
          selectionDecoration: BoxDecoration(
            color: MyColors.secondaryColor.withOpacity(0.2),
            border: Border.all(color: MyColors.secondaryColor),
            borderRadius: BorderRadius.circular(4),
          ),
          onDragUpdate: (details) {
            if (details.draggingTime == null) return;
            // TODO: update selected day tab
            setState(() {
              selectedDay = details.draggingTime!.day - dayOneDate.day + 1;
              calendarController.displayDate =
                  dayOneDate.add(Duration(days: selectedDay - 1));
            });
          },
          onViewChanged: (viewChangedDetails) {
            //TODO: update seleceted day tab
            selectedDay =
                viewChangedDetails.visibleDates.first.day - dayOneDate.day + 1;
          },
          appointmentBuilder: (context, calendarAppointmentDetails) {
            final events = (calendarAppointmentDetails.appointments).toList();
            final event = events.first as Event;
            return Container(
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: MyColors.primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                event.title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: MyColors.whiteColor,
                ),
                overflow: TextOverflow.clip,
              ),
            );
          },
        ),
      ),
    );
  }

  ListView _buildListView(List<Event> schedules) {
    return ListView.separated(
      itemCount: schedules.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(
            top: index == 0 ? 10 : 0,
            bottom: index == schedules.length - 1 ? 20 : 0),
        child: EventScheduleTile(event: schedules[index]),
      ),
    );
  }
}

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return (appointments![index] as Event).startTime;
  }

  @override
  DateTime getEndTime(int index) {
    return (appointments![index] as Event).endTime;
  }

  @override
  String getSubject(int index) {
    return (appointments![index] as Event).title;
  }

  @override
  Color getColor(int index) {
    return MyColors.primaryColor;
  }

  @override
  bool isAllDay(int index) {
    return false;
  }
}
