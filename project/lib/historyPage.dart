import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project/common/global_variables.dart';

import 'model/localdb.dart';

class HistoryPage extends StatefulWidget {
  final String username;
  HistoryPage({Key? key, required this.username}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Box<Details> dbox;

  @override
  void initState() {
    dbox = Hive.box<Details>('details');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: GlobalVariables.mainColor,
        elevation: 3,
        title: const Text(
          'History',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: dbox.length,
        itemBuilder: (context, index) {
          final reversedIndex =
              dbox.length - 1 - index; // Calculate the reversed index
          final activity =
              dbox.getAt(reversedIndex); // Get the activity in reverse order

          // Check if the username matches the useremail
          if (activity?.useremail == widget.username) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 11.5,
                        height: 11.5,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.fromBorderSide(
                            BorderSide(
                              color: GlobalVariables.mainColor,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      Image.file(
                        File(activity?.image ?? ''), // Use File directly
                        width: 100,
                        height: 100,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              activity?.disease ?? '',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Text(
                            activity?.useremail ?? '',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: GlobalVariables.mainColor,
                ),
              ],
            );
          } else {
            // Return an empty container if there is no match
            return Container();
          }
        },
      ),
    );
  }
}
