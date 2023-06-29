import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project/model/localdb.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project/controller/provider.dart';
import 'package:project/route/routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(DetailsAdapter());
  var Dbox = await Hive.openBox<Details>('details');

  //print(Dbox.values);

  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderApp()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'main',
        initialRoute: Routes.home,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
