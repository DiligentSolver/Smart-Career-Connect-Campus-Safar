import 'dart:io';
import 'dart:typed_data';
import 'package:campus_safar/utils/device/device_utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/widgets/icons/circular_icon.dart';
import '../constants/colors.dart';
import '../constants/sizes.dart';

class CameraView extends StatefulWidget {
  const CameraView(
      {super.key, required this.onImage, required this.onInputImage});

  final Function(Uint8List image) onImage;
  final Function(InputImage inputImage) onInputImage;

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  File? _image;
  ImagePicker? _imagePicker;

  @override
  void initState() {
    super.initState();

    _imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _image != null
            ? CircleAvatar(
                radius: CSDeviceUtils.getScreenHeight() * 0.15,
                backgroundColor: const Color(0xffD9D9D9),
                backgroundImage: FileImage(_image!),
              )
            : CircleAvatar(
                radius: CSDeviceUtils.getScreenHeight() * 0.15,
                backgroundColor: CSColors.darkBg,
                child: Icon(
                  Icons.camera_alt,
                  size: CSDeviceUtils.getScreenHeight() * 0.09,
                  color: CSColors.white,
                ),
              ),
        Ver(CSSizes.defaultSpace*2),
        CSCircularIcon(
          showLabel: true,
          iconColor: CSColors.white,
          padding: const EdgeInsets.all(CSSizes.sm),
          icon: Icons.camera,
          iconSize: CSSizes.iconLg+2,
          onPressed: (){_getImage();},
          showBorder: true,
        ),
      ],
    );
  }

  Future _getImage() async {
    setState(() {
      _image = null;
    });
    final pickedFile = await _imagePicker?.pickImage(
      source: ImageSource.camera,
      maxWidth: 400,
      maxHeight: 400,
      // imageQuality: 50,
    );
    if (pickedFile != null) {
      _setPickedFile(pickedFile);
    }
    setState(() {});
  }

  Future _setPickedFile(XFile? pickedFile) async {
    final path = pickedFile?.path;
    if (path == null) {
      return;
    }
    setState(() {
      _image = File(path);
    });

    Uint8List imageBytes = _image!.readAsBytesSync();
    widget.onImage(imageBytes);

    InputImage inputImage = InputImage.fromFilePath(path);
    widget.onInputImage(inputImage);
  }
}
