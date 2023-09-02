import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

import '../common/global_variables.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool toggle_password = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2), // Adjust the duration as needed
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 70,
              child: TextFormField(
                controller: emailController,
                cursorColor: GlobalVariables.mainColor,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: GlobalVariables.mainColor),
                  // hintText: 'Enter Email Address',
                  icon: Icon(Icons.mail_outline,
                      color: GlobalVariables.mainColor),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: GlobalVariables.mainColor),
                      borderRadius: BorderRadius.circular(10.0)),
                  labelText: 'Email',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: GlobalVariables.mainColor),
                  ),
                ),
                validator: (value) {
                  // Check if this field is empty
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }

                  // using regular expression
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return "Please enter a valid email address";
                  }

                  // the email is valid
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 60,
              child: TextFormField(
                  controller: passwordController,
                  cursorColor: GlobalVariables.mainColor,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: GlobalVariables.mainColor),
                    // hintText: 'Enter password',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: GlobalVariables.mainColor),
                        borderRadius: BorderRadius.circular(10.0)),
                    icon: Icon(
                      Icons.lock,
                      color: GlobalVariables.mainColor,
                    ),

                    labelText: 'Password',
                    suffix: IconButton(
                        onPressed: () {
                          //add Icon button at end of TextField
                          setState(() {
                            //refresh UI
                            if (toggle_password) {
                              //if toggle_password == true, make it false
                              toggle_password = false;
                            } else {
                              toggle_password =
                                  true; //if toggle_password == false, make it true
                            }
                          });
                        },
                        icon: Icon(toggle_password == true
                            ? Icons.remove_red_eye
                            : Icons.password)),
                    //eye icon if toggle_password = true, else, Icon is ***__

                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: GlobalVariables.mainColor),
                    ),
                  ),
                  obscureText: toggle_password,
                  validator: (value) {
                    if (value != null && value.length < 7) {
                      return 'Enter minimum 7 characters';
                    } else {
                      return null;
                    }
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
                child: Row(
              children: [
                Text('          Already Registered? '),
                InkWell(
                  child: Text(
                    'Login',
                    style: TextStyle(color: GlobalVariables.mainColor),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, 'login');
                  },
                )
              ],
            )),
            SizedBox(
              height: 40,
            ),
            OutlinedButton(
              onPressed: () async {
                if (emailController.text.isEmpty) {
                  Logger().d("Email field should not be empty.");
                  Fluttertoast.showToast(
                      msg: "Email field should not be empty.",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);

                  return;
                }

                if (passwordController.text.isEmpty) {
                  Logger().d("Password field should not be empty");
                  Fluttertoast.showToast(
                      msg: "Password field should not be empty.",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);

                  return;
                }
                try {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );

                  final userId = FirebaseAuth.instance.currentUser?.uid;
                  print(userId);
                  print(FirebaseAuth.instance.currentUser?.email);

                  final docUser =
                      FirebaseFirestore.instance.collection('users');

                  final user = User(
                    email_address: emailController.text,
                  );

                  final json = user.toJson();
                  await docUser.doc(userId).set(json);

                  // Display a success Snackbar
                  _showSnackbar("Account created successfully!");

                  if (_formKey.currentState!.validate()) {
                    Navigator.pushNamed(context, 'login');
                  }
                } catch (e) {
                  // Handle account creation error
                  _showSnackbar("Account already exists or an error occurred.");
                  Logger().e("Account creation error: $e");
                }
              },
              child: Text('Signup'),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      GlobalVariables.mainColor),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
            ),
          ],
        ));
  }
}

class User {
  final String id;

  final String email_address;

  User({
    this.id = '',
    required this.email_address,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email_address,
      };

  static User fromJson(Map<String, dynamic> json()) => User(
        email_address: 'email',
      );
}
