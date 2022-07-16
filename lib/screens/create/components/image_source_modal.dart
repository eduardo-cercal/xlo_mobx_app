import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceModal extends StatelessWidget {
  final Function(File) onImageSelected;

  const ImageSourceModal({required this.onImageSelected, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return BottomSheet(
        onClosing: getFromCamera,
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
              onPressed: getFromCamera,
              child: const Text("Camera"),
            ),
            TextButton(
              onPressed: getFromGallery,
              child: const Text("Galeria"),
            ),
          ],
        ),
      );
    } else {
      return CupertinoActionSheet(
        cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Cancelar",
              style: TextStyle(color: Colors.red),
            )),
        actions: [
          CupertinoActionSheetAction(
            onPressed: getFromCamera,
            child: const Text("Camera"),
          ),
          CupertinoActionSheetAction(
            onPressed: getFromGallery,
            child: const Text("Galeria"),
          ),
        ],
      );
    }
  }

  Future<void> getFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile == null) return;
    final image = File(pickedFile.path);

    imageSelected(image);
  }

  Future<void> getFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    final image = File(pickedFile.path);

    imageSelected(image);
  }

  Future<void> imageSelected(File image) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      androidUiSettings: const AndroidUiSettings(
        toolbarTitle: "Editar Imagem",
        toolbarColor: Colors.deepPurple,
        toolbarWidgetColor: Colors.white,
      ),
      iosUiSettings: const IOSUiSettings(
          title: "Editar Imagem",
          cancelButtonTitle: "Cancelar",
          doneButtonTitle: "Concluir"),
    );
    if (croppedFile == null) return;
    onImageSelected(croppedFile);
  }
}
