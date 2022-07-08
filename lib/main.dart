

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:llt/pages/home.dart';
import 'package:llt/pages/setup/LoginPage.dart';
import 'package:llt/pages/setup/Welcome.dart';

import 'package:llt/pages/setup/search.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepPurple,
      ),
      home: WelcomePage()
    );
  }

}
class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome To Location Tracking App",),
        centerTitle: true,

      ),
      body: Column(
      //  mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height:   MediaQuery.of(context).size.height/3,

            width: MediaQuery.of(context).size.width,


          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage('https://th.bing.com/th/id/OIP.36irrAqHF7NFm5CPdRQwjwHaD3?pid=ImgDet&rs=1'),fit: BoxFit.fill,),

          ),

          ),
          SizedBox(height: 5.0,),
          Container(
            child: ElevatedButton(
              onPressed: () {
              /*  FirebaseAuth.instance
                    .authStateChanges()
                    .listen((User? user) {
                  if (user == null) {
                    print('User is currently signed out!');

                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                    print('User is signed in!');
                  }
                }); */
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Welcome()));
              },
              child: Center(child: Text('Get Started',textAlign: TextAlign.center, ),),

            ),
            padding: EdgeInsets.fromLTRB(150.0, 60.0, 150.0, 60.0),

          )
        ],
      ),

    );
  }
}



