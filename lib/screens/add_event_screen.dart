import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icragee_mobile/models/event.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/shared/globals.dart';
import 'package:icragee_mobile/utility/functions.dart';
import 'package:icragee_mobile/widgets/snackbar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../services/api_service.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  // State variables for selected venue, date, and time
  bool isLoading = false;
  String? selectedVenue;
  int? selectedDay;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  // TextEditingControllers for event title, description, and time
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    _titleController.dispose();
    _descriptionController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyColors.backgroundColor,
        title: const Text('Add Event'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Add Event Title',
                  labelStyle: const TextStyle(color: Colors.black87),
                  hintText: 'Enter event title',
                  filled: true,
                  fillColor: Colors.white,
                  border: _buildInputBorder(),
                  enabledBorder: _buildInputBorder(),
                  focusedBorder: _buildInputBorder(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              const SizedBox(height: 16),

              // Event Description TextField
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Add Event Description',
                  labelStyle: const TextStyle(color: Colors.black87),
                  hintText: 'Enter event description',
                  filled: true,
                  fillColor: Colors.white,
                  border: _buildInputBorder(),
                  enabledBorder: _buildInputBorder(),
                  focusedBorder: _buildInputBorder(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: 'Add Venue',
                  labelStyle: const TextStyle(color: Colors.black87),
                  filled: true,
                  fillColor: Colors.white,
                  border: _buildInputBorder(),
                  enabledBorder: _buildInputBorder(),
                  focusedBorder: _buildInputBorder(),
                  prefixIcon: const Icon(Icons.place),
                ),
                value: selectedVenue,
                hint: const Text('Venue'),
                items: venues.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedVenue = newValue;
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                decoration: InputDecoration(
                  labelText: 'Add Date',
                  labelStyle: const TextStyle(color: Colors.black87),
                  filled: true,
                  fillColor: Colors.white,
                  border: _buildInputBorder(),
                  enabledBorder: _buildInputBorder(),
                  focusedBorder: _buildInputBorder(),
                  prefixIcon: const Icon(Icons.calendar_today),
                ),
                value: selectedDay,
                hint: const Text('Day'),
                items: dates.map((String value) {
                  return DropdownMenuItem<int>(
                    value: dates.indexOf(value) + 1,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedDay = newValue;
                  });
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _startTimeController,
                      readOnly: true, // Disable manual input
                      decoration: InputDecoration(
                        labelText: 'Start Time',
                        labelStyle: const TextStyle(
                          color: Colors.black87,
                        ),
                        hintText: 'Start time',
                        filled: true,
                        fillColor: Colors.white,
                        border: _buildInputBorder(),
                        enabledBorder: _buildInputBorder(),
                        focusedBorder: _buildInputBorder(),
                      ),
                      onTap: () async {
                        await _selectTime(context, true);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _endTimeController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'End Time',
                        labelStyle: const TextStyle(
                          color: Colors.black87,
                        ),
                        hintText: 'End time',
                        filled: true,
                        fillColor: Colors.white,
                        border: _buildInputBorder(),
                        enabledBorder: _buildInputBorder(),
                        focusedBorder: _buildInputBorder(),
                      ),
                      onTap: () async {
                        await _selectTime(context, false);
                      },
                    ),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _addEvent,
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.primaryColor,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: isLoading
                    ? LoadingAnimationWidget.waveDots(
                        color: Colors.white, size: 32)
                    : const Text('Submit',
                        style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to handle adding an event
  Future<void> _addEvent() async {
    if (isLoading) return;
    final goRouter = GoRouter.of(context);
    if (_titleController.text.isEmpty ||
        selectedVenue == null ||
        selectedDay == null ||
        startTime == null ||
        endTime == null) {
      showSnackBar("Please fill all fields");
      return;
    }
    setState(() {
      isLoading = true; // Show loader
    });

    try {
      final startTimeDateTime = getEventDateFromTimeAndDay(
        hour: startTime!.hour,
        minute: startTime!.minute,
        day: selectedDay!,
      );

      final endTimeDateTime = getEventDateFromTimeAndDay(
        hour: endTime!.hour,
        minute: endTime!.minute,
        day: selectedDay!,
      );
      // Check if the start time is before the end time
      if (!startTimeDateTime.isBefore(endTimeDateTime)) {
        showSnackBar("Start time must be before end time");
        setState(() {
          isLoading = false; // Hide loader
        });
        return;
      }
      final newEvent = Event(
        title: _titleController.text.trim(),
        startTime: startTimeDateTime,
        endTime: endTimeDateTime,
        venue: selectedVenue!,
        description: _descriptionController.text.trim(),
        day: selectedDay!,
      );

      final eventId = await DataService.addEvent(newEvent);
      showSnackBar("Event added successfully");
      if (eventId == null) {
        showSnackBar("Failed to add event. Please try again.");
        return;
      }
      await ApiService.scheduleTopicNotification(
        topic: eventId,
        time: newEvent.startTime,
        title: "Event starting soon!",
        body: "'${newEvent.title}' event is about to start in 15 minutes! "
            "Please report to ${newEvent.venue}.",
      );
    } catch (e) {
      showSnackBar("Failed to add event. Please try again.");
    } finally {
      setState(() {
        isLoading = false; // Hide loader when done
      });
      goRouter.pop();
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color(0xFF40E0D0), // Set primary color
                onSurface: Color(0xFF121515), // Set text color
              ),
            ),
            child: child!,
          ),
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        if (isStartTime) {
          startTime = pickedTime;
          _startTimeController.text =
              pickedTime.format(context); // Update the start time field
        } else {
          endTime = pickedTime;
          _endTimeController.text =
              pickedTime.format(context); // Update the end time field
        }
      });
    }
  }

  OutlineInputBorder _buildInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: Colors.black),
    );
  }
}
