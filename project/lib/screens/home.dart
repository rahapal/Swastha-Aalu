import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project/common/global_variables.dart';
import 'package:project/historyPage.dart';
import 'package:project/model/localdb.dart';

class HomePage extends StatefulWidget {
  final String username;
  HomePage({Key? key, required this.username}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Box<Details> Dbox;

  @override
  void initState() {
    Dbox = Hive.box<Details>('details');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading:
              false, //to remove the back button from the appbar
          backgroundColor: GlobalVariables.mainColor,
          title: const Text(
            'SwasthaAlu',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HistoryPage(username: widget.username),
                  ),
                );
              },
              icon: const Icon(Icons.history),
              iconSize: 33,
            ),
          ],
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(
              //     top: 20,
              //     left: 16,
              //     right: 16,
              //   ),
              //   child: Text('Welcome, ${widget.username.split('@')[0]}',
              //       style: const TextStyle(
              //         fontSize: 26,
              //         fontWeight: FontWeight.bold,
              //       )),
              // ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  left: 16,
                  right: 8,
                ),
                child: Text(
                    'The Common Disease of Potatoes are Early and Late Blight',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              // Early Blight Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Early Blight',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Early blight is caused by two different closely related fungi, Alternaria tomatophila, and Alternaria solani, which live in soil and plant debris.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Symptoms of early blight disease first appear in the base of the affected plant, with roughly round brown spots on the leaves and stems.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'As the lesions expand, the spots appear yellow halos. Lesions usually have dark concentric rings.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Eventually, multiple spots on a single leaf will merge, resulting in extensive destruction of the leaf tissue. Early disease can cause the lower leaves to be completely deleaved and even lead to the death of infected plants.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    // Add an image for Early Blight here
                    Center(child: Image.asset('assets/EarlyBlight.jpg')),
                  ],
                ),
              ),

              // Late Blight Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Late Blight',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Late blight is caused by Phytophthora infestans, a microorganism that prefers moist and cool environments.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'The most obvious early signs of late blight are brown spots or disease spots on plant stems.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'They expand rapidly and produce white fungal growth in wet conditions. Soft rot causes the stem to collapse quickly, turning into dark brown.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    // Add an image for Late Blight here
                    Center(child: Image.asset('assets/LateBlight.jpg')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
