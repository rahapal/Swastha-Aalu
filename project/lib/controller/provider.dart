import 'dart:io';

import 'package:flutter/material.dart';

class ProviderApp with ChangeNotifier {
  File? _image;

  Future<void> imagePath(String path) async {
    _image = path as File?;
    notifyListeners();
  }
}
