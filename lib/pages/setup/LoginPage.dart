
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


import '../home.dart';


class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email, password;
  late User user;
  var locationMessage="";

 Future<void> addlocationfield() async {
    var position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lastPosition=await Geolocator.getLastKnownPosition();
    print(lastPosition);
    var lat=position.latitude;
    var long=position.longitude;
    print("$lat,$long");
    setState(() {
      locationMessage= "Latitude: $lat, Longitude: $long";

    });
    FirebaseFirestore.instance.collection('Users')
        .doc(user.uid)
        .set({
      'Location': '$locationMessage'
    },SetOptions(merge: true)).then((value){
      //Do your stuff.
      print(locationMessage);
    });
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user=FirebaseAuth.instance.currentUser!;

  }
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (input) {
                if (input!.isEmpty) {
                  return 'please type an email';
                }
              },
              onSaved: (input) => email = input!,
              decoration: InputDecoration(
                  labelText: 'Email'
              ),
            ),
            TextFormField(
              validator: (input) {
                if (input!.length < 6) {
                  return 'your password needs to be of 6 character';
                }
              },
              onSaved: (input) => password = input!,
              decoration: InputDecoration(
                  labelText: 'Password'
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: (){
                  signIn();
                  addlocationfield();
                  },
              child: Text('Sign in'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }on FirebaseAuthException catch (e) {
      print(e);

      }
    }
  }
}