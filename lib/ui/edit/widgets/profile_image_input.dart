import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pettygram_flutter/widgets/circle_image.dart';

class ProfileImageInput extends StatefulWidget {
  const ProfileImageInput(
      {super.key, required this.handleImageInput, required this.imageUrl});

  final void Function(List<String> image) handleImageInput;
  final String imageUrl;
  @override
  State<ProfileImageInput> createState() => _ProfileImageInputState();
}

class _ProfileImageInputState extends State<ProfileImageInput> {
  File? takenImage;
  String? base64Image;

  void _takePicture() async {
    final imagePicker = ImagePicker();

    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (pickedImage == null) return;

    List<String> image = [];
    File imagefile = File(pickedImage.path);
    var imagebytes = imagefile.readAsBytesSync();
    String base64Image = base64.encode(imagebytes);
    image.add(base64Image);

    setState(() {
      takenImage = File(pickedImage.path);
    });
    widget.handleImageInput(image);
  }

  @override
  Widget build(BuildContext context) {
    return takenImage != null
        ? CircleAvatar(
            radius: 35,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Image.file(
                takenImage!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          )
        : GestureDetector(
            onTap: _takePicture,
            child: CircleImage(imageUrl: widget.imageUrl),
          );
  }
}
