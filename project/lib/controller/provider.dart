import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model/localdb.dart';

class ProviderApp with ChangeNotifier {
  Future<void> addImage(Details details) async {
    var box = await Hive.openBox<Details>('details');
    box.add(details);
    notifyListeners();
  }

  Future<Details> showImage() async {
    var box = await Hive.openBox<Details>('details');

    var image = box.getAt(box.length - 1);

    return image!;
  }
}
