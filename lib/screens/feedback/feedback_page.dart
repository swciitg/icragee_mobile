import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icragee_mobile/controllers/user_controller.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/shared/globals.dart';
import 'package:icragee_mobile/widgets/snackbar.dart';

class FeedbackPage extends ConsumerStatefulWidget {
  const FeedbackPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends ConsumerState<FeedbackPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();
  bool loading = false;

  Future<void> _submitFeedback() async {
    if (loading) return;
    loading = true;
    if (!checkForm()) return;
    String name = _nameController.text;
    String email = _emailController.text;
    String feedback = _feedbackController.text;

    try {
      await DataService.submitFeedback(
        name: name,
        email: email,
        feedback: feedback,
      );
      _nameController.clear();
      _emailController.clear();
      _feedbackController.clear();
      navigatorKey.currentState!.pop();
      showSnackBar("Feedback submitted successfully");
    } catch (error) {
      showSnackBar("Failed to submit feedback: $error");
    }
    loading = false;
  }

  @override
  void initState() {
    final user = ref.read(userProvider)!;
    _nameController.text = user.fullName;
    _emailController.text = user.email;
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.only(
                  bottom: 20,
                  left: 30,
                  right: 30,
                ),
                child: Image.asset('assets/images/logo.png'),
              ),
              _buildTextField(_nameController, "Name"),
              _buildTextField(
                _emailController,
                "Email",
                keyboardType: TextInputType.emailAddress,
              ),
              _buildTextField(_feedbackController, "Feedback", maxLines: 5),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: _submitFeedback,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(8), color: MyColors.primaryColor),
          child: const Text(
            'Submit',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType keyboardType = TextInputType.text, int? maxLength, int? maxLines}) {
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

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: const Text(
        "Feedback",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
        ),
      ),
      backgroundColor: MyColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
    );
  }

  bool checkForm() {
    if (_nameController.text.isEmpty) {
      showSnackBar("Name cannot be empty");
      return false;
    }
    if (_emailController.text.isEmpty) {
      showSnackBar("Email cannot be empty");
      return false;
    }
    if (_feedbackController.text.isEmpty) {
      showSnackBar("Feedback cannot be empty");
      return false;
    }
    return true;
  }
}
