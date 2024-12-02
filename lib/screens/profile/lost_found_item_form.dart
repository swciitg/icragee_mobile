import 'package:flutter/material.dart';
import 'package:icragee_mobile/models/lost_found_model.dart';
import 'package:icragee_mobile/models/user_details.dart';
import 'package:icragee_mobile/services/api_service.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/shared/globals.dart';
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
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _contactNumber = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _email = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isLoading ? const LinearProgressIndicator() : Container(),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  _buildTextField(_title, "Title"),
                  _buildTextField(_location,
                      'Location ${widget.lostForm ? "lost" : "found"}'),
                  _buildTextField(
                    _contactNumber,
                    "Contact Number",
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                  ),
                  _buildTextField(
                    _email,
                    "Email",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  _buildTextField(_description, "Description", maxLines: 5),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (isLoading) return;
          final check = checkForm();
          if (!check) return;
          setState(() {
            isLoading = true;
          });
          try {
            final user = await UserDetails.getFromSharedPreferences();
            final imageUrl = await ApiService.uploadImage(widget.imageFile);
            final model = LostFoundModel(
              id: "",
              category: widget.lostForm ? "lost" : "found",
              title: _title.text.trim(),
              description: _description.text.trim(),
              location: _location.text.trim(),
              contact: _contactNumber.text.trim(),
              imageUrl: imageUrl,
              // Replace with image url
              name: user!.fullName,
              email: user.email,
              submittedAt: DateTime.now().toString(),
              submittedBy: user.id,
            );

            await DataService.postLostFoundData(model);

            showSnackBar(
                '${widget.lostForm ? "Lost" : "Found"} item posted successfully!');
            isLoading = false;

            navigatorKey.currentState!.pop();
          } catch (e) {
            showSnackBar("Failed to post the lost item.");
          }
          setState(() {
            isLoading = false;
          });
        },
        backgroundColor: MyColors.primaryColor,
        child: isLoading
            ? const CircularProgressIndicator()
            : const Icon(
                Icons.save,
                color: Colors.white,
              ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        "${widget.lostForm ? "Lost" : "Found"} Item Details",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: isLoading
          ? SizedBox()
          : GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
            ),
      backgroundColor: MyColors.primaryColor,
    );
  }

  bool checkForm() {
    if (_title.text.trim().isEmpty) {
      showSnackBar("Please enter a title.");
      return false;
    }

    if (_description.text.trim().isEmpty) {
      showSnackBar("Please enter a description.");
      return false;
    }

    if (_contactNumber.text.trim().isEmpty) {
      showSnackBar("Please enter a contact number.");
      return false;
    }

    if (_location.text.trim().isEmpty) {
      showSnackBar("Please enter a location.");
      return false;
    }

    if (_email.text.trim().isEmpty) {
      showSnackBar("Please enter an email.");
      return false;
    }

    if (_contactNumber.text.trim().length != 10) {
      showSnackBar("Please enter a valid 10-digit contact number.");
      return false;
    }

    return true;
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType keyboardType = TextInputType.text,
      int? maxLength,
      int? maxLines}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        maxLength: maxLength,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black87),
          hintText: label,
          hintStyle: const TextStyle(color: Colors.black26),
          filled: true,
          fillColor: Colors.white,
          border: _buildInputBorder(),
          enabledBorder: _buildInputBorder(),
          focusedBorder: _buildInputBorder(),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }

  OutlineInputBorder _buildInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: Colors.black),
    );
  }
}
