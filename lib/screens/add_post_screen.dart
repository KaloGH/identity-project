import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:identity_project/utils/colors.dart';
import 'package:identity_project/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen>
    with TickerProviderStateMixin {
  late AnimationController cameraAnimationController;
  late AnimationController galleryAnimationController;
  late AnimationController uploadFileAnimationController;

  Uint8List? _file;

  @override
  void initState() {
    super.initState();
    cameraAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    galleryAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    uploadFileAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    cameraAnimationController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        cameraAnimationController.reset();
      }
    });

    galleryAnimationController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        galleryAnimationController.reset();
      }
    });

    uploadFileAnimationController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        galleryAnimationController.reset();
      }
    });
  }

  @override
  void dispose() {
    cameraAnimationController.dispose();
    galleryAnimationController.dispose();
    uploadFileAnimationController.dispose();
    super.dispose();
  }

  _playAnimationOnTap(AnimationController controller) async {
    await controller.forward();
  }

  _selectImage(BuildContext parentContext) async {
    /**
     * Creamos diálogo para escoger una imagen entre galería o cámara.
     */

    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: appYellowColor,
          title: const Text(''),
          children: <Widget>[
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: IconButton(
                icon: Lottie.asset(
                  'assets/json/use_camera.json',
                  fit: BoxFit.fill,
                  repeat: false,
                  controller: cameraAnimationController,
                  onLoaded: (composition) {
                    cameraAnimationController.duration = composition.duration;
                  },
                ),
                iconSize: 230,
                onPressed: () async {
                  // await _playAnimationOnTap(cameraAnimationController);
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: IconButton(
                icon: Lottie.asset(
                  'assets/json/from_gallery.json',
                  fit: BoxFit.fill,
                  repeat: false,
                  controller: galleryAnimationController,
                  onLoaded: (composition) {
                    galleryAnimationController.duration = composition.duration;
                  },
                ),
                iconSize: 230,
                onPressed: () async {
                  // await _playAnimationOnTap(galleryAnimationController);
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _file == null
        ? Center(
            child: IconButton(
              icon: Lottie.asset(
                'assets/json/upload_file.json',
                fit: BoxFit.fill,
                repeat: false,
              ),
              iconSize: 230,
              onPressed: () async {
                // await _playAnimationOnTap(uploadFileAnimationController);
                _selectImage(context);
              },
            ),
          )
        : Scaffold(
            backgroundColor: appYellowColor,
            appBar: AppBar(
              backgroundColor: appYellowColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {},
              ),
              title: const Text('Post to'),
              centerTitle: true,
              actions: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Post',
                    style: TextStyle(
                      color: pinkColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
            body: Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 20,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 85,
                      ),
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1541701494587-cb58502866ab?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470',
                        ),
                        radius: 35,
                      ),
                      SizedBox(
                        width: 55,
                      ),
                      const Text(
                        'Username',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 30,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 300,
                        width: MediaQuery.of(context).size.width * 1,
                        child: AspectRatio(
                          aspectRatio: 300 / 780,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: MemoryImage(_file!),
                                fit: BoxFit.fill,
                                alignment: FractionalOffset.topCenter,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 35,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 1,
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Write a caption...',
                            border: InputBorder.none,
                          ),
                          maxLines: 8,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
