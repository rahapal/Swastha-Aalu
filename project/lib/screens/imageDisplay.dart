import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project/screens/bottomNavBar.dart';
import 'package:provider/provider.dart';

import '../controller/provider.dart';

class ImageDisplay extends StatefulWidget {
  File? image;
  ImageDisplay({super.key, this.image});

  @override
  State<ImageDisplay> createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BottomNavBar()));
          },
        ),
        title: const Text('Image Display'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: widget.image == null
            ? const Text('No image selected.')
            : Image.file(widget.image!),
      ),
    );
  }
}
