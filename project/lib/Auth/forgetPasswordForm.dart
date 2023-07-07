import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
          SizedBox(height: 10,),
           SizedBox(
            height: 60,
            child: TextFormField(
              controller: emailController,
              cursorColor: GlobalConstants.primaryColor,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
              labelStyle: TextStyle(
                color: GlobalConstants.primaryColor
              ),
              // hintText: 'Enter Email Address',
              icon:  Icon(Icons.mail_outline,
               color: GlobalConstants.primaryColor),  
               enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: GlobalConstants.primaryColor),
                borderRadius: BorderRadius.circular(10.0)
                ),
                labelText: 'Email',
                focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color:GlobalConstants.primaryColor ),
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
          SizedBox(height: 40,),
          OutlinedButton(
        style: ButtonStyle(
          
          backgroundColor: MaterialStateProperty.all<Color>(GlobalConstants.primaryColor),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white)
          ),
          
          onPressed: () async{
            

            await FirebaseAuth.instance.sendPasswordResetEmail(
                           email: emailController.text.trim()
            );

            if (_formKey.currentState!.validate()) {
                            Navigator.pushNamed(context, 'login');
                          }
                          else{
                            print('work garena');
                          }
        
          }, 
          child: Text('Reset',
      
          ),
          
        )
        ],
      ),

    );
  }
}