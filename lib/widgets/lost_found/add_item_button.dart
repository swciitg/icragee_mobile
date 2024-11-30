import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../screens/profile/found_item_form.dart';
import '../../screens/profile/lost_item_form.dart';
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
              title: const Text("From where do you want to take the photo?"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: const Text("Gallery"),
                      onTap: () async {
                        xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                        if (!mounted) return;
                        Navigator.of(context).pop();
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: const Text("Camera"),
                      onTap: () async {
                        xFile = await ImagePicker().pickImage(source: ImageSource.camera);
                        if (!mounted) return;
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );

        if (!mounted) return;
        if (xFile != null) {
          // Check the image size
          var imageSize = (await xFile!.length()) / (1024 * 1024); // MB
          if (imageSize > 2.5) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                "Maximum image size can be 2.5 MB",
                style: TextStyle(fontSize: 20),
              ),
            ));
            return;
          }

          // Pass the XFile directly to LostItemForm
          if (widget.type == "Lost") {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => LostFoundItemForm(
                imageFile: xFile!,
              ),
            ));
          } else if (widget.type == "Found") {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const FoundItemForm()));
          }
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
