import 'package:flutter/material.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/shared/colors.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _FeedbackPage();
  }
}

class _FeedbackPage extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();
  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String email = _emailController.text;
      String feedback = _feedbackController.text;

      DataService.submitFeedback(
        name: name,
        email: email,
        feedback: feedback,
      ).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Feedback submitted successfully')),
        );

        _formKey.currentState!.reset();
        _nameController.clear();
        _emailController.clear();
        _feedbackController.clear();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit feedback: $error')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyColors.backgroundColor,
        title: const Text(
          'Feedback',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                    left: 30,
                    right: 30,
                  ),
                  child: Image.asset('assets/images/logo.png'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  cursorHeight: 20,
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.5),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                  ),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  cursorHeight: 20,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.5),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return 'Please enter your email address';
                    }

                    return null;
                  },
                  controller: _emailController,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 100,
                  child: TextFormField(
                    cursorHeight: 20,
                    decoration: const InputDecoration(
                      labelText: 'Your Feedback',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                    ),
                    keyboardType: TextInputType.text,
                    maxLines: 4,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your feedback';
                      }
                      return null;
                    },
                    controller: _feedbackController,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Spacer(),
                    GestureDetector(
                      onTap: _submitFeedback,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: MyColors.secondaryColor),
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
