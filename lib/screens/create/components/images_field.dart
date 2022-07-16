import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/create/components/image_source_modal.dart';
import 'package:xlo_mobx/stores/create_store.dart';

import 'image_dialog.dart';

class ImagesField extends StatelessWidget {
  final CreateStore createStore;

  const ImagesField({required this.createStore, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onImageSelected(File image) {
      createStore.images.add(image);
      Navigator.of(context).pop();
    }

    return Column(
      children: [
        Container(
          color: Colors.grey[200],
          height: 120,
          child: Observer(
            builder: (_) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: createStore.images.length < 5
                    ? createStore.images.length + 1
                    : 5,
                itemBuilder: (_, index) {
                  if (index == createStore.images.length) {
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: GestureDetector(
                        onTap: () {
                          if (Platform.isAndroid) {
                            showModalBottomSheet(
                                context: context,
                                builder: (_) => ImageSourceModal(
                                    onImageSelected: onImageSelected));
                          } else {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (_) => ImageSourceModal(
                                    onImageSelected: onImageSelected));
                          }
                        },
                        child: CircleAvatar(
                          radius: 44,
                          backgroundColor: Colors.grey[300],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.camera_alt,
                                size: 50,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => ImageDialog(
                              image: createStore.images[index],
                              onDelete: () =>
                                  createStore.images.removeAt(index),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 44,
                          backgroundImage: createStore.images[index] is File
                              ? FileImage(
                                  createStore.images[index],
                                )
                              : NetworkImage(createStore.images[index]) as ImageProvider,
                        ),
                      ),
                    );
                  }
                },
              );
            },
          ),
        ),
        Observer(builder: (_) {
          if (createStore.imagesError != null) {
            return Container(
              padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.red))),
              child: Text(
                createStore.imagesError!,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
            );
          } else {
            return Container();
          }
        })
      ],
    );
  }
}
