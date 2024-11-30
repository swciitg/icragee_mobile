import 'dart:async';

import 'package:flutter/material.dart';
import 'package:icragee_mobile/models/user_details.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/widgets/snackbar.dart';
import 'package:image_picker/image_picker.dart';

class LostFoundItemForm extends StatefulWidget {
  static const id = "/lostItemForm";
  final XFile imageFile;
  final bool lostForm;

  const LostFoundItemForm({
    super.key,
    required this.imageFile,
    this.lostForm = true,
  });

  @override
  State<LostFoundItemForm> createState() => _LostFoundItemFormState();
}

class _LostFoundItemFormState extends State<LostFoundItemForm> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _contactNumber = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _email = TextEditingController();
  DataService dataService = DataService();
  bool isLoading = false;
  bool savingToDB = false;
  StreamController dbSavingController = StreamController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (!isLoading) {
              Navigator.of(context).pop();
            }
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text("${widget.lostForm ? "Lost" : "Found"} Item Details"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isLoading ? const LinearProgressIndicator() : Container(),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _title,
                      decoration: const InputDecoration(labelText: 'Title'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _location,
                      decoration: InputDecoration(
                          labelText: 'Location ${widget.lostForm ? "lost" : "found"}'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the location';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _contactNumber,
                      decoration: const InputDecoration(labelText: 'Contact Number'),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a contact number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _email,
                      decoration: const InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _description,
                      decoration: const InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (!formKey.currentState!.validate()) {
            return;
          }

          setState(() {
            isLoading = true;
          });

          try {
            // Call the postLostFoundData method from the LostAndFoundService class
            final user = await UserDetails.getFromSharedPreferences();
            await DataService.postLostFoundData(
              category: widget.lostForm ? "Lost" : "Found",
              title: _title.text.trim(),
              description: _description.text.trim(),
              location: _location.text.trim(),
              contact: _contactNumber.text.trim(),
              image: widget.imageFile,
              name: user!.fullName,
              email: user.email,
            );

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Lost item posted successfully!')),
            );

            Navigator.pop(context);
          } catch (e) {
            showSnackBar("Failed to post the lost item.");
          }

          setState(() {
            isLoading = false;
          });
        },
        child: StreamBuilder(
          stream: dbSavingController.stream,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData && snapshot.data == true) {
              return const CircularProgressIndicator();
            }
            return const Text('Submit');
          },
        ),
      ),
    );
  }
}
