import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AppDecorations {
  showLoadingModal() {
    ///
  }
}

class MyUtils {}

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  /// Variables
  CroppedFile? imageFile;

  /// Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0XFF307777),
          title: Text("Image Cropper"),
        ),
        body: Container(
            child: imageFile == null
                ? Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            _getFromGallery();
                          },
                          child: const Text(
                            "PICK FROM GALLERY",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    child: Image.file(
                      File(imageFile!.path),
                      fit: BoxFit.cover,
                    ),
                  )));
  }

  /// Get from gallery
  _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    _cropImage(pickedFile!.path);
  }

  /// Crop Image
  _cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      aspectRatioPresets: [CropAspectRatioPreset.square],
    );
    if (croppedImage != null) {
      imageFile = croppedImage;
      setState(() {});
    }
  }
}
