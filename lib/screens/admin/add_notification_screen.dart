import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icragee_mobile/controllers/user_controller.dart';
import 'package:icragee_mobile/models/notification_model.dart';
import 'package:icragee_mobile/services/api_service.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/shared/globals.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddNotificationScreen extends ConsumerStatefulWidget {
  const AddNotificationScreen({super.key});

  @override
  ConsumerState<AddNotificationScreen> createState() =>
      _AddNotificationScreenState();
}

class _AddNotificationScreenState extends ConsumerState<AddNotificationScreen> {
  bool isLoading = false;
  bool important = false;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyColors.backgroundColor,
        title: const Text('Add Notification'),
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
                  labelText: 'Title',
                  labelStyle: const TextStyle(color: Colors.black87),
                  hintText: "Announcement",
                  hintStyle: const TextStyle(color: Colors.black38),
                  filled: true,
                  fillColor: Colors.white,
                  border: _buildInputBorder(),
                  enabledBorder: _buildInputBorder(),
                  focusedBorder: _buildInputBorder(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: const TextStyle(color: Colors.black87),
                  filled: true,
                  fillColor: Colors.white,
                  border: _buildInputBorder(),
                  enabledBorder: _buildInputBorder(),
                  focusedBorder: _buildInputBorder(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                maxLines: null,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Expanded(child: Text("Important Notification")),
                  Switch.adaptive(
                    value: important,
                    onChanged: (val) {
                      setState(() {
                        important = val;
                      });
                    },
                    activeColor: MyColors.primaryColor,
                    thumbColor: WidgetStateProperty.resolveWith((state) {
                      if (state.contains(WidgetState.selected)) {
                        return MyColors.primaryColor;
                      }
                      return Colors.grey;
                    }),
                    trackColor: WidgetStateProperty.resolveWith((state) {
                      if (state.contains(WidgetState.selected)) {
                        return MyColors.primaryColor.withOpacity(0.5);
                      }
                      return Colors.grey[300];
                    }),
                    trackOutlineColor: WidgetStateProperty.resolveWith((state) {
                      if (state.contains(WidgetState.selected)) {
                        return MyColors.primaryColor.withOpacity(0.5);
                      }
                      return Colors.grey;
                    }),
                  )
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _addNotification,
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
  Future<void> _addNotification() async {
    if (isLoading) return;
    final valid = _titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty;
    if (!valid) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please fill all fields'),
        behavior: SnackBarBehavior.floating,
      ));
      return;
    }
    setState(() {
      isLoading = true;
    });

    final user = ref.read(userProvider)!;
    final notification = NotificationModel(
      title: _titleController.text,
      description: _descriptionController.text,
      timestamp: DateTime.now().toUtc().toString(),
      creatorId: user.id,
      creatorName: user.fullName,
      important: important,
    );
    try {
      await DataService.addNotification(notification);
      await ApiService.sendInstantTopicNotification(
        topic: 'All',
        title: notification.title,
        body: notification.description,
      );
      navigatorKey.currentContext!.pop();
      ScaffoldMessenger.of(navigatorKey.currentContext!)
          .showSnackBar(const SnackBar(
        content: Text('Notification added successfully'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ));
    } catch (e) {
      ScaffoldMessenger.of(navigatorKey.currentContext!)
          .showSnackBar(const SnackBar(
        content: Text('Failed to add notification'),
        behavior: SnackBarBehavior.floating,
      ));
    }
    setState(() {
      isLoading = false;
    });
  }

  OutlineInputBorder _buildInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: Colors.black),
    );
  }
}
