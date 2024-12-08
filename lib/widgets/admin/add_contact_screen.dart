import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icragee_mobile/models/contact_model.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/shared/globals.dart';
import 'package:icragee_mobile/widgets/snackbar.dart';

class AddContactScreen extends ConsumerStatefulWidget {
  final List<String> types;
  const AddContactScreen({super.key, required this.types});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddContactDialogState();
}

class _AddContactDialogState extends ConsumerState<AddContactScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final category = TextEditingController(text: 'Hospital');
  bool other = false;
  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(nameController, "Name"),
            const SizedBox(height: 8),
            _buildTextField(phoneController, "Phone", keyboardType: TextInputType.phone),
            const SizedBox(height: 8),
            Text("category"),
            Wrap(
              children: [
                ...List.generate(
                  widget.types.length,
                  (index) {
                    return _categoryChip(index);
                  },
                ),
                Container(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text('Other'),
                    selected: other,
                    color: WidgetStateProperty.resolveWith(
                      (states) {
                        if (states.contains(WidgetState.selected)) {
                          return MyColors.primaryColor;
                        }
                        return Colors.white;
                      },
                    ),
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          category.text = '';
                          other = true;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            if (other) const SizedBox(height: 8),
            if (other) _buildTextField(category, "Category", keyboardType: TextInputType.text),
          ],
        ),
      ),
      floatingActionButton: _buildSubmitButton(),
    );
  }

  Container _categoryChip(int index) {
    return Container(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(widget.types[index]),
        selected: category.text == widget.types[index],
        color: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return MyColors.primaryColor;
            }
            return Colors.white;
          },
        ),
        onSelected: (selected) {
          if (selected) {
            setState(() {
              category.text = widget.types[index];
              other = false;
            });
          }
        },
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Add Contact',
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

  FloatingActionButton _buildSubmitButton() {
    return FloatingActionButton(
      onPressed: () async {
        if (loading) return;
        setState(() {
          loading = true;
        });
        final name = nameController.text.trim();
        final phone = phoneController.text.trim();
        final noCategory = other && category.text.isEmpty;
        if (name.isEmpty || phone.isEmpty || noCategory) {
          showSnackBar('Please fill all the fields.');
          return;
        }
        final model = ContactModel(
          name: name,
          phone: phone,
          category: category.text,
        );
        try {
          await DataService.addNewContact(model);
          setState(() {
            loading = false;
          });
          navigatorKey.currentState!.pop();
          showSnackBar('Added contact. Please reopen "Important Contacts" screen to see changes.');
        } catch (e) {
          setState(() {
            loading = false;
          });
          showSnackBar('Something went wrong. Please try again.');
        }
      },
      child: loading ? CircularProgressIndicator() : Icon(Icons.save),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType keyboardType = TextInputType.text, int? maxLength, int? maxLines}) {
    return TextField(
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
    );
  }

  OutlineInputBorder _buildInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: Colors.black),
    );
  }
}
