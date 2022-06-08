import 'package:flutter/material.dart';
import 'package:llt/pages/setup/register_screen.dart';

import 'LoginPage.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('my firebase app'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 3, 50, 3),
            child: ElevatedButton(
              onPressed: navigateToLoginPage,
              child: Text('Sign in'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 3, 50, 3),
            child: ElevatedButton(
              onPressed: navigateToRegister,
              child: Text('Sign up'),
            ),
          ),
        ],

      ),
    );
  }
  void navigateToLoginPage(){
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => LoginPage(), fullscreenDialog: true));
  }
  void navigateToRegister(){
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Register(), fullscreenDialog: true));
  }

}

