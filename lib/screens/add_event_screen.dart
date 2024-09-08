import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icragee_mobile/models/event.dart';
import 'package:icragee_mobile/services/data_service.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  // State variables for selected venue, date, and time
  String? selectedVenue;
  int? selectedDay;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  // Lists for dropdown values
  final dates = ['Day 1', 'Day 2', 'Day 3'];
  final venues = ['Venue 1', 'Venue 2', 'Venue 3'];

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
      backgroundColor: const Color(0xFFC6FCED),
      appBar: AppBar(
        title: const Text('Add Event'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop(); // Back navigation
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event Title TextField
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Add Event Title',
                  labelStyle: const TextStyle(
                    color: Colors.black87,
                    backgroundColor: Color(0xFFC7F7EF),
                  ),
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
                  labelStyle: const TextStyle(
                    color: Colors.black87,
                    backgroundColor: Color(0xFFC7F7EF),
                  ),
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

              // Venue and Date Dropdowns in a Row
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Add Venue',
                        labelStyle: const TextStyle(
                          color: Colors.black87,
                          backgroundColor: Color(0xFFC7F7EF),
                        ),
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
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        labelText: 'Add Date',
                        labelStyle: const TextStyle(
                          color: Colors.black87,
                          backgroundColor: Color(0xFFC7F7EF),
                        ),
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
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Start Time and End Time in a Row
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
                          // backgroundColor: Color(0xFFC7F7EF),
                        ),
                        hintText: 'Start time',
                        filled: true,
                        fillColor: Colors.white,
                        border: _buildInputBorder(),
                        enabledBorder: _buildInputBorder(),
                        focusedBorder: _buildInputBorder(),
                      ),
                      onTap: () async {
                        await _selectTime(
                            context, true); // Open time picker for start time
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _endTimeController,
                      readOnly: true, // Disable manual input
                      decoration: InputDecoration(
                        labelText: 'End Time',
                        labelStyle: const TextStyle(
                          color: Colors.black87,
                          //backgroundColor: Color(0xFFC7F7EF),
                        ),
                        hintText: 'End time',
                        filled: true,
                        fillColor: Colors.white,
                        border: _buildInputBorder(),
                        enabledBorder: _buildInputBorder(),
                        focusedBorder: _buildInputBorder(),
                      ),
                      onTap: () async {
                        await _selectTime(
                            context, false); // Open time picker for end time
                      },
                    ),
                  ),
                ],
              ),
              const Spacer(),

              // Add Button
              ElevatedButton(
                onPressed: _addEvent,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF40E0D0),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                    'Add', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to handle adding an event
  void _addEvent() async {
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        selectedVenue == null ||
        selectedDay == null ||
        startTime == null ||
        endTime == null) {
      Fluttertoast.showToast(
        msg: "Please fill all fields",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    try {
      final startTimeDateTime = DateTime(
        DateTime
            .now()
            .year,
        DateTime
            .now()
            .month,
        DateTime
            .now()
            .day,
        startTime!.hour,
        startTime!.minute,
      );

      final endTimeDateTime = DateTime(
        DateTime
            .now()
            .year,
        DateTime
            .now()
            .month,
        DateTime
            .now()
            .day,
        endTime!.hour,
        endTime!.minute,
      );

      final newEvent = Event(
        title: _titleController.text.trim(),
        startTime: startTimeDateTime,
        endTime: endTimeDateTime,
        venue: selectedVenue!,
        description: _descriptionController.text.trim(),
        day: selectedDay!,
      );

      await DataService.addEvent(newEvent);
      Fluttertoast.showToast(
        msg: "Event added successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to add event. Please try again.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
    Navigator.of(context).pop();
  }

  // Function to select time using TimePicker

  // Function to select time using TimePicker
  // Future<void> _selectTime(BuildContext context, bool isStartTime) async {
  //   final TimeOfDay? pickedTime = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(), // Use current time as the initial value
  //   );
  //
  //   if (pickedTime != null) {
  //     setState(() {
  //       if (isStartTime) {
  //         startTime = pickedTime;
  //         _startTimeController.text =
  //             pickedTime.format(context); // Update the start time field
  //       } else {
  //         endTime = pickedTime;
  //         _endTimeController.text =
  //             pickedTime.format(context); // Update the end time field
  //       }
  //     });
  //   }
  // }
  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary:Color(0xFF40E0D0) , // Set primary color to green
              onSurface: Color(0xFF121515) ,// Set the text color to green
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        if (isStartTime) {
          startTime = pickedTime;
          _startTimeController.text = pickedTime.format(context); // Update the start time field
        } else {
          endTime = pickedTime;
          _endTimeController.text = pickedTime.format(context); // Update the end time field
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

