import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:identity_project/models/user.dart';
import 'package:identity_project/providers/user_provider.dart';
import 'package:identity_project/utils/colors.dart';
import 'package:identity_project/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

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
  final TextEditingController _captionController = TextEditingController();

  postImage(String uid, String username, String uImage) async {
    try {} catch (e) {}
  }

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
    _captionController.dispose();
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
              child: const Center(
                  child: Text(
                'Cancel',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
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
    final User user = Provider.of<UserProvider>(context).getUser;
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
                    children: const [
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
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          user.photoUrl,
                        ),
                        radius: 35,
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Text(
                        user.username,
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: const [
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
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
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
                    children: const [
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
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextField(
                          controller: _captionController,
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
