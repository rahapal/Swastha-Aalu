import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:project/common/global_variables.dart';
import 'package:project/screens/bottomNavBar.dart';
import 'package:provider/provider.dart';

import '../controller/provider.dart';
import '../model/localdb.dart';

class ImageDisplay extends StatefulWidget {
  const ImageDisplay({super.key});

  @override
  State<ImageDisplay> createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay> {
  String disease = '';
  String percentage = '';

  Future<Response> predict(File image) async {
    final url = Uri.parse('http://192.168.0.6:8000/api/predict');
    final request = http.MultipartRequest('POST', url);
    request.files.add(
      await http.MultipartFile.fromPath('file', image.path),
    );

    final response = await http.Response.fromStream(await request.send());
    if (response.statusCode == 200) {
      final result = response.body.toString();
      final decodedResult = json.decode(result);
      print("Hi:$decodedResult");
      final diseaseValue = decodedResult['class'];
      final percentageValue = decodedResult['confidence'];
      setState(() {
        disease = diseaseValue != null ? diseaseValue.toString() : '';
        percentage = percentageValue != null ? percentageValue.toString() : '';
      });
      print(result);
    } else if (response.statusCode == 422) {
      final result = response.body.toString();
      print('Validation Error: $result');
    } else {
      print('Request failed with status code: ${response.statusCode}');
    }

    return response;
  }

  @override
  Widget build(BuildContext context) {
    //final provider = Provider.of<ProviderApp>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.mainColor,
        leading: IconButton(
          icon: const Icon(
            Icons.cancel_rounded,
            color: Colors.white,
            size: 35,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BottomNavBar()),
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.check,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () {
              Provider.of<ProviderApp>(context, listen: false)
                  .showImage()
                  .then((value) {
                File image = File(value.image);
                predict(image);
              });

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const BottomNavBar(),
              //   ),
              // );

              // showDialog(
              //   context: context,
              //   builder: (BuildContext context) {
              //     return AlertDialog(
              //       title: const Text('Do you want to proceed?'),
              //       content: const Text('This will give you a result.'),
              //       actions: <Widget>[
              //         TextButton(
              //           onPressed: () {
              //             Navigator.of(context).pop();
              //           },
              //           child: const Text('NO'),
              //         ),
              //         TextButton(
              //           onPressed: () {
              //             provider.updateImage(Details(
              //               image: provider.showImage().toString(),
              //               disease: '',
              //               percentage: '',
              //             ));
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => const BottomNavBar(),
              //               ),
              //             );
              //           },
              //           child: const Text('YES'),
              //         ),
              //       ],
              //     );
              //   },
              // );
            },
          ),
        ],
        title: const Text('Image Display'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future:
                  Provider.of<ProviderApp>(context, listen: false).showImage(),
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
            const SizedBox(height: 20),
            if (disease.isNotEmpty)
              Text(
                "Class:$disease ",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            if (percentage.isNotEmpty)
              Text(
                "Percentage:$percentage ",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
