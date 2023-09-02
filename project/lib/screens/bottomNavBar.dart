import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/model/localdb.dart';
import 'package:project/screens/Profile/profilepage.dart';
import 'package:project/screens/home.dart';
import 'package:provider/provider.dart';

import '../common/global_variables.dart';
import '../controller/provider.dart';
import 'demopage.dart';
import 'imageDisplay.dart';

class BottomNavBar extends StatefulWidget {
  final String username;
  const BottomNavBar({Key? key, required this.username}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentTab = 0;
  final List<Widget> screens = [
    HomePage(username: ''),
    const Demo(),
    ProfilePage(
      username: '',
    ),
  ];

  late Box<Details> dbox;
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomePage(username: '');
  File? _image;

  @override
  void initState() {
    dbox = Hive.box<Details>('details');
    super.initState();
  }

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
    final provider = Provider.of<ProviderApp>(context, listen: false);
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
                      height: MediaQuery.of(context).size.height / 7.1,
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
                              print("Camera:${widget.username}");
                              imageGallery(ImageSource.camera).then((value) {
                                if (value != null) {
                                  setState(() {
                                    _image = value;
                                  });
                                  provider.addImage(Details(
                                      image: _image!.path,
                                      useremail: widget.username));
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ImageDisplay(
                                              useremail: widget.username,
                                              image: _image!.path,
                                            )),
                                  );
                                }
                              });
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
                              print("Gallery:${widget.username}");
                              imageGallery(ImageSource.gallery).then((value) {
                                if (value != null) {
                                  setState(() {
                                    _image = value;
                                  });
                                  provider.addImage(Details(
                                      image: _image!.path,
                                      useremail: widget.username));
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ImageDisplay(
                                              useremail: widget.username,
                                              image: _image!.path,
                                            )),
                                  );
                                }
                              });
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
                      //dbox.clear();
                      print("HOME:${widget.username}");
                      setState(() {
                        currentScreen = HomePage(username: widget.username);
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
                      print("Profile:${widget.username}");
                      setState(() {
                        currentScreen = ProfilePage(username: widget.username);
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
