import 'package:flutter/material.dart';
import 'package:project/Auth/splash_screen.dart';
import 'package:project/common/global_variables.dart';

class ProfilePage extends StatefulWidget {
  final String username;
  ProfilePage({Key? key, required this.username}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: GlobalVariables.mainColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 100,
                height: 120,
                child: CircleAvatar(
                    //   backgroundColor: GlobalVariables.mainColor,
                    //   child: Icon(Icons.person, size: 75, color: Colors.white),
                    // ),
                    backgroundImage: AssetImage('assets/profile.jpg')),
              ),
            ],
          ),
          const SizedBox(
            height: 9,
          ),
          Text(
            '${widget.username.split('@')[0]}',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ListTile(
                  leading: Icon(Icons.person, color: GlobalVariables.mainColor),
                  title: Text(
                    'Personal Information',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios,
                      color: GlobalVariables.mainColor),
                ),
                ListTile(
                  leading:
                      Icon(Icons.password, color: GlobalVariables.mainColor),
                  title: Text(
                    'Change Password',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios,
                      color: GlobalVariables.mainColor),
                ),
                ListTile(
                  leading: Icon(
                    Icons.article,
                    color: GlobalVariables.mainColor,
                  ),
                  title: Text(
                    'Terms and Conditions',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios,
                      color: GlobalVariables.mainColor),
                ),
                ListTile(
                  leading: Icon(Icons.contact_page,
                      color: GlobalVariables.mainColor),
                  title: Text(
                    'Contact Us',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios,
                      color: GlobalVariables.mainColor),
                ),
                ListTile(
                  leading: Icon(
                    Icons.help,
                    color: GlobalVariables.mainColor,
                  ),
                  title: Text(
                    'Help and Support',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios,
                      color: GlobalVariables.mainColor),
                ),
                ListTile(
                  leading: Icon(Icons.info, color: GlobalVariables.mainColor),
                  title: Text(
                    'About Us',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios,
                      color: GlobalVariables.mainColor),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 45),
            child: Container(
              width: 160,
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: GlobalVariables.mainColor,
              ),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SplashScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                //  Text(
                //   'Logout',
                //   style: TextStyle(
                //     fontSize: 22,
                //     color: Colors.white,
                //   ),
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
