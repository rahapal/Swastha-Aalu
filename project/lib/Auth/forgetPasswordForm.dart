import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Constants/globalconstants.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Column(
        children: [
          Text('Please mention your email address'),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 60,
            child: TextFormField(
              controller: emailController,
              cursorColor: GlobalConstants.primaryColor,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelStyle: TextStyle(color: GlobalConstants.primaryColor),
                // hintText: 'Enter Email Address',
                icon: Icon(Icons.mail_outline,
                    color: GlobalConstants.primaryColor),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: GlobalConstants.primaryColor),
                    borderRadius: BorderRadius.circular(10.0)),
                labelText: 'Email',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: GlobalConstants.primaryColor),
                ),
              ),
              validator: (value) {
                // Check if this field is empty
                if (value == null || value.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "Email field should not be empty.",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                
                }
                // using regular expression
                if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value!)) {
                   Fluttertoast.showToast(
                      msg: "Please enter a valid email address",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  return ;
                }

                // the email is valid
                return null;
              },
            ),
          ),
          SizedBox(
            height: 40,
          ),
          OutlinedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    GlobalConstants.primaryColor),
                foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.white)),
            onPressed: () async {
              if (!emailController.text.isEmpty) {
                try{ FirebaseAuth.instance
                  .sendPasswordResetEmail(email: emailController.text.trim());
                  Fluttertoast.showToast(
                      msg: "Please check you email and reset your password",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
                Navigator.pushNamed(context, 'login');
              } on FirebaseAuthException catch(e){
                Fluttertoast.showToast(
                      msg: e.message!,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
              }
              
              }else{
                Fluttertoast.showToast(
                      msg: "Email address should not be empty.",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
              }
              
               
            },
            child: Text(
              'Reset',
            ),
          )
        ],
      ),
    );
  }
}
