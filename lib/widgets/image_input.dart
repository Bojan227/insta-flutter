import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../theme/custom_theme.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.handleImageInput});

  final void Function(List<String> image) handleImageInput;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
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
    final customTheme = Theme.of(context).extension<CustomTheme>();

    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: customTheme!.onSecondary),
      ),
      child: takenImage != null
          ? Image.file(
              takenImage!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            )
          : TextButton.icon(
              onPressed: _takePicture,
              icon: Icon(
                Icons.camera,
                color: customTheme.onSecondary,
              ),
              label: Text(
                'Take Picture',
                style: TextStyle(color: customTheme.onSecondary),
              ),
            ),
    );
  }
}
