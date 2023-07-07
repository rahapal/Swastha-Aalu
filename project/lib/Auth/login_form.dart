import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/Constants/globalconstants.dart';



class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
   final _formKey = GlobalKey<FormState>();
   final emailController = TextEditingController();
   final passwordController = TextEditingController();
   bool toggle_password = true;
  @override

  void dispose(){
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Column(
        children: [
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
          SizedBox(height: 20,),
          SizedBox(
            height: 60,
            child: TextFormField(
              controller: passwordController,
              cursorColor: GlobalConstants.primaryColor,
              decoration: InputDecoration(
              labelStyle: TextStyle(
                color: GlobalConstants.primaryColor
              ),
              // hintText: 'Enter password',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: GlobalConstants.primaryColor),
                borderRadius: BorderRadius.circular(10.0)
                ),
              icon:  Icon(Icons.lock,
                        color: GlobalConstants.primaryColor,),  
          
              labelText: 'Password',
              suffix: IconButton(onPressed: (){ //add Icon button at end of TextField
                                        setState(() { //refresh UI
                                            if(toggle_password){ //if toggle_password == true, make it false
                                               toggle_password = false;
                                            }else{
                                               toggle_password = true; //if toggle_password == false, make it true
                                            }
                                        });
                                }, icon: Icon(toggle_password == true?Icons.remove_red_eye:Icons.password)),
                                //eye icon if toggle_password = true, else, Icon is ***__
                            
              focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color:GlobalConstants.primaryColor ),
                     ),
                
              ),
          
              obscureText: toggle_password,
               validator: (value) {
                            if(value != null && value.length < 7){
                              return'Enter minimum 7 characters';
                            } else{
                              return null;
                            }
              
                          }
            ),
          ),
          SizedBox(height: 20,),
          SizedBox(
          child: Row(
            children: [
              Text('          Forgot Password? '),
              InkWell(
                child: Text('Reset password',
                
                style: TextStyle(
                  color: GlobalConstants.primaryColor
                ),),
                onTap: (){
                  Navigator.pushNamed(context, 'forget_password');
                },
              )
            ],
          )
          ),
          SizedBox(height: 40,),
        OutlinedButton(
        style: ButtonStyle(
          
          backgroundColor: MaterialStateProperty.all<Color>(GlobalConstants.primaryColor),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white)
          ),
          
          onPressed: () async{
              try{
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim()
                          );
                          }
                          
                          on FirebaseAuthException catch(e) {
                            print(e);
                            // Utils.showSnackBar(e.message);
                            // utils.showSnackBar('Try with new email address');

                          }
                        
            
            if (_formKey.currentState!.validate()) {
                            Navigator.pushNamed(context, 'home');
                          }
                          else{
                            print('work garena');
                          }
        
          }, 
          child: Text('Login',
      
          ),
          
        )

        ],
      )
    );
  }
}