

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:llt/pages/setup/Welcome.dart';
import 'package:llt/pages/setup/DataController.dart';
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
        primarySwatch: Colors.blue,
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
        backgroundColor: Colors.indigoAccent,
      ),
      body: Center(
        child: Container(

        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage('https://th.bing.com/th/id/OIP.36irrAqHF7NFm5CPdRQwjwHaD3?pid=ImgDet&rs=1'),fit: BoxFit.fill,),

        ),

          child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Welcome()));
          },
          child: Center(child: Text('Click',textAlign: TextAlign.center, style: TextStyle(color: Colors.black, ),),),

        ),
        padding: EdgeInsets.fromLTRB(150.0, 60.0, 150.0, 60.0),


      ),
      ),

    );
  }
}



