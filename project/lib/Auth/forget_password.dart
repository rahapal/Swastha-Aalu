import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/common/global_variables.dart';

import 'forgetPasswordForm.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.black),
            ),
            centerTitle: true),
        body: Center(
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: SizedBox(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      '\n Reset your password ',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            color: GlobalVariables.mainColor,
                            fontSize: 25,
                            letterSpacing: 2),
                      ),
                    ),
                    Image.asset(
                      'assets/logo.png',
                      width: 150,
                      height: 150,
                    ),
                    ResetPasswordForm()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
