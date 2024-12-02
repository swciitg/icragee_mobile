import 'package:flutter/material.dart';
import 'package:icragee_mobile/shared/globals.dart';
import 'package:image_picker/image_picker.dart';

import '../../screens/profile/lost_found_item_form.dart';
import '../../shared/colors.dart';

class AddItemButton extends StatefulWidget {
  const AddItemButton({
    super.key,
    required this.type,
  });

  final String type;

  @override
  State<AddItemButton> createState() => _AddItemButtonState();
}

class _AddItemButtonState extends State<AddItemButton> {
  @override
  Widget build(BuildContext context) {
    if (widget.type == "My Ads") {
      return const SizedBox();
    }
    return GestureDetector(
      onTap: () async {
        XFile? xFile;
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "Choose your option",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    GestureDetector(
                      child: const Text("Gallery"),
                      onTap: () async {
                        xFile = await ImagePicker().pickImage(
                            source: ImageSource.gallery, imageQuality: 50);
                        navigatorKey.currentState!.pop();
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: const Text("Camera"),
                      onTap: () async {
                        xFile = await ImagePicker().pickImage(
                            source: ImageSource.camera, imageQuality: 50);
                        navigatorKey.currentState!.pop();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
        if (xFile != null) {
          // var imageSize = (await xFile!.length()) / (1024 * 1024); // MB
          // if (imageSize > 2.5) {
          //   showSnackBar("Maximum image size can be 2.5 MB");
          //   return;
          // }
          navigatorKey.currentState!.push(
            MaterialPageRoute(
              builder: (context) => LostFoundItemForm(
                imageFile: xFile!,
                lostForm: widget.type == "Lost",
              ),
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        decoration: BoxDecoration(
          color: MyColors.primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Icon(
                Icons.add_rounded,
                color: MyColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
