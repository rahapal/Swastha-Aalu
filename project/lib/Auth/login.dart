// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/Auth/login_form.dart';

import '../common/global_variables.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: SizedBox(
            child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      '\n Login your account ',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            color: GlobalVariables.mainColor,
                            fontSize: 25,
                            letterSpacing: 2),
                      ),
                    ),
                    // SizedBox(height: 10,),
                    Image.asset(
                      'assets/logo.png',
                      width: 150,
                      height: 150,
                    ),

                    LoginForm()
                  ],
                )),
          ),
        )),
      ),
    );
  }
}
// import 'package:google_fonts/google_fonts.dart';

// import '../Constants/globalconstants.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//       final _formKey = GlobalKey<FormState>();
//       final passwordController = TextEditingController();
//       final emailController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body: Center(
        
//         child: Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.0),
//               ),
              
//           child: Padding(
//             padding:  const EdgeInsets.all(20.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                    Text(
//                     '\n\n\n LOGIN \n',
//                     style: GoogleFonts.lato(
//                         textStyle: const TextStyle(
//                             color:GlobalVariables.mainColor,
//                             // color: Colors.greenAccent,
//                             fontSize: 30,
//                             letterSpacing: 2)),
//                   ),
//                   SizedBox(height: 30,),
//                   Row(
//                     children:[
//                   Text('Email'),
//                   TextFormField(
//                      controller: emailController,
//                           decoration: const InputDecoration(
//                               prefixIcon: Icon(
//                                   Icons.email,
//                                   color:GlobalVariables.mainColor, 
//                                   ),
//                                 labelStyle: TextStyle(
//                                               color:GlobalVariables.mainColor,
//                                 ) ,
//                                 hintText: 'Email Address',
//                                 label: Text('Email Address'),
//                                 border: OutlineInputBorder(),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                     width: 2.0,
//                                     color:GlobalVariables.mainColor,
//                                   )
//                                 )
//                               ),
//                               // validator: (value) {
//                               //   value !=null && !EmailValidator.validate(value)
//                               //   ?'Enter a proper email address'
//                               //   : null;
//                               // },
//                               validator: (value) {
//                       // Check if this field is empty
//                       if (value == null || value.isEmpty) {
//                         return 'This field is required';
//                       }
            
//                       // using regular expression
//                       if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
//                         return "Please enter a valid email address";
//                       }
            
//                       // the email is valid
//                       return null;
//                     },
//                   )
//                     ]
//                   ),
//                    SizedBox(height: 30,),
//                   Row(
//                     children:[
//                   Text('Password'),
//                   TextFormField(
//                     controller: passwordController,
//                           obscureText: true,
//                           decoration: const InputDecoration(
//                             icon: Icon(Icons.password),
//                             hintText: 'Password',
//                           ),
//                           validator: (value) {
//                           if(value != null && value.length < 7){
//                             return'Enter minimum 7 characters';
//                           } else{
//                             return null;
//                           }
            
//                         }
//                   ),

//                     ]
//                   ),
//                   Row(
//                     children: [
//                       Text('Forgot password?'),
                    
//                       OutlinedButton(onPressed: (){
//                          Navigator.pushNamed(context, 'forget_password');
//                       },
//                        child: Text('Reset')
//                       )
                     
                      
                      
//                     // )
                   
                      
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       OutlinedButton(
//                         onPressed: (){
//                           Navigator.pushNamed(context, 'home');
//                         }, 
//                         child: Text('Login')
//                         )
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }