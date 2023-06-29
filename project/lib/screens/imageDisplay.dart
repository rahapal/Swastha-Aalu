import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project/screens/bottomNavBar.dart';
import 'package:provider/provider.dart';

import '../controller/provider.dart';

class ImageDisplay extends StatefulWidget {
  const ImageDisplay({super.key});

  @override
  State<ImageDisplay> createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.cancel_rounded,
            color: Colors.white,
            size: 35,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BottomNavBar()));
          },
        ),
        title: const Text('Image Display'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: FutureBuilder(
          future: Provider.of<ProviderApp>(context, listen: false).showImage(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: Image.file(
                  File(snapshot.data.image),
                  fit: BoxFit.cover,
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
