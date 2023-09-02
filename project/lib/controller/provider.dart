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

  Future<void> addInformation(Details details) async {
    var box = await Hive.openBox<Details>('details');
    box.put(box.length - 1, details);
    notifyListeners();
  }
}
