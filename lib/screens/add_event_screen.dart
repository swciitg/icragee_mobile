
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/event_model.dart';
import '../services/data_service.dart';


class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  // State variables for selected venue and date
  String? selectedVenue;
  String? selectedDate;

  // Lists for dropdown values
  final List<String> dates = ['Day 1', 'Day 2', 'Day 3'];
  final List<String> venues = ['Venue 1', 'Venue 2', 'Venue 3'];

  // Text editing controllers for event title and description
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Instance of FirestoreService
  final DataService _dataService = DataService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC6FCED),
      appBar: AppBar(
        title: const Text('Add Event'),leading: IconButton( // Add leading icon for back navigation
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Navigator.of(context).pop(); // Handle back navigation
        },
      ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align all elements to the left
            children: [
              // TextField for Event Title
              TextField(
                controller: _titleController, // Bind controller
                decoration: InputDecoration(
                  labelText: 'Add Event Title',
                  labelStyle: TextStyle(color: Colors.black87, backgroundColor: Color(0xFFC7F7EF)),
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
              // TextField for Event Description
              TextField(
                controller: _descriptionController, // Bind controller
                decoration: InputDecoration(
                  labelText: 'Add Event Description',
                  labelStyle: TextStyle(color: Colors.black87, backgroundColor: Color(0xFFC7F7EF)),
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
              // Dropdown for Venue Selection
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Add Venue',
                  labelStyle: TextStyle(color: Colors.black87, backgroundColor: Color(0xFFC7F7EF)),
                  filled: true,
                  fillColor: Colors.white,
                  border: _buildInputBorder(),
                  enabledBorder: _buildInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.teal, width: 2.0),
                  ),
                  prefixIcon: Icon(Icons.place),
                ),
                value: selectedVenue,
                hint: Text('Select venue'),
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
              // Dropdown for Date Selection
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Add Date',
                  labelStyle: TextStyle(color: Colors.black87, backgroundColor: Color(0xFFC7F7EF)),
                  filled: true,
                  fillColor: Colors.white,
                  border: _buildInputBorder(),
                  enabledBorder: _buildInputBorder(),
                  focusedBorder: _buildInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                value: selectedDate,
                hint: Text('Select day'),
                items: dates.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedDate = newValue;
                  });
                },
              ),
              const Spacer(),
              // Add Button
              ElevatedButton(
                onPressed: _addEvent, // Call the add event method
                child: const Text('Add', style: TextStyle(fontSize: 18, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF40E0D0),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to handle adding an event
  void _addEvent() async {
    // Check if all required fields are filled
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        selectedVenue == null ||
        selectedDate == null) {
      Fluttertoast.showToast(
        msg: "Please fill all fields",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    // Create a new event object
    Event newEvent = Event(
      title: _titleController.text,
      description: _descriptionController.text,
      venue: selectedVenue!,
      date: DateTime.now(), // Replace with a proper date based on selectedDate
    );


    try {
      await _dataService.addEvent(newEvent);
      Fluttertoast.showToast(
        msg: "Event added successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );


      _clearFormFields();


      Future.delayed(Duration(milliseconds: 500), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AddEventScreen()),
        );
      });
    } catch (e) {

      Fluttertoast.showToast(
        msg: "Failed to add event. Please try again.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  OutlineInputBorder _buildInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Colors.black),
    );
  }
  void _clearFormFields() {
    setState(() {
      _titleController.clear();
      _descriptionController.clear();
      selectedVenue = null;
      selectedDate = null;
    });
  }
}


