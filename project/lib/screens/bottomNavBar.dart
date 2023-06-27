import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/screens/Profile/profilepage.dart';
import 'package:provider/provider.dart';

import '../common/global_variables.dart';
import 'demopage.dart';
import 'imageDisplay.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentTab = 0;
  final List<Widget> screens = [
    const Demo(),
    const ProfilePage(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const Demo();
  File? _image;

  Future imageGallery(ImageSource media) async {
    final image = await ImagePicker().pickImage(source: media);
    if (image == null) return;
    final imageTemp = File(image.path);

    setState(() {
      _image = imageTemp;
    });
    return _image;
  }

  Future imageCamera(ImageSource media) async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTemp = File(image.path);

    setState(() {
      _image = imageTemp;
    });
    return _image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: SizedBox(
        height: 75.0,
        width: 75.0,
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (builder) {
                  return Card(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 7.2,
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(
                              Icons.camera_alt,
                              size: 50,
                              color: GlobalVariables.mainColor,
                            ),
                            title: const Text(
                              "Camera",
                            ),
                            onTap: () {
                              imageCamera(ImageSource.camera)
                                  .then((value) => setState(() {
                                        _image = value;
                                      }));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImageDisplay(
                                    image: _image,
                                  ),
                                ),
                              );
                            },
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.photo_album,
                              size: 50,
                              color: GlobalVariables.mainColor,
                            ),
                            title: const Text("Gallery"),
                            onTap: () {
                              imageGallery(ImageSource.gallery)
                                  .then((value) => setState(() {
                                        _image = value;
                                      }));

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImageDisplay(
                                    image: _image,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
          backgroundColor: GlobalVariables.mainColor,
          elevation: 15.0,
          highlightElevation: 20,
          child: const Icon(
            Icons.camera_alt,
            size: 50,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const Demo();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          size: 55,
                          color: currentTab == 0
                              ? GlobalVariables.mainColor
                              : Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const ProfilePage();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          size: 55,
                          color: currentTab == 1
                              ? GlobalVariables.mainColor
                              : Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
