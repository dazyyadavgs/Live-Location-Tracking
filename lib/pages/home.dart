

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:llt/pages/setup/LoginPage.dart';


import 'package:llt/pages/setup/Mylocation.dart';

import 'package:llt/pages/setup/editprofile.dart';
import 'package:llt/pages/setup/createGroup.dart';
import 'package:llt/pages/setup/register_screen.dart';
import 'package:llt/pages/setup/search.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final userCollection = FirebaseFirestore.instance.collection("Users");
  String? name, email,uid;
  User? loggedInUser;


  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }



  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future<void> userData()  async{
    final user= loggedInUser!.uid;
    await FirebaseFirestore.instance.collection('Users').where('uid',isEqualTo: uid).get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        name = loggedInUser!.displayName;
        email = loggedInUser!.email;


      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
        backgroundColor: Colors.deepPurple,
        actions: [
          Row(
            children: <Widget>[
              FlatButton.icon(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Register()));
                  },
                  icon: Icon(
                    Icons.person_outline,
                    color: Colors.white,
                  ),

                  label: Text(
                    'Log out',
                    style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  )),
              Row(
                children: [
                  IconButton(icon: Icon(Icons.edit,color: Colors.blue,),onPressed: () {Navigator.push(context,
                      MaterialPageRoute(builder: (context) => edit()));}),
                ],
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProfileAvatar(
                'https://www.bing.com/th?id=OIP.MUtWvqmGVFkhQJLgUhvKHQHaLH&w=86&h=100&c=8&rs=1&qlt=90&o=6&dpr=1.5&pid=3.1&rm=2',
                radius: 100,
                elevation: 5,
                borderWidth: 10,
                backgroundColor: Colors.brown,

              ),
              SizedBox(
                height: 10,
              ),
              FutureBuilder(
            future: userData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done)
                return Text("Loading data...Please wait");
              return Text("Name : $name,Email:$email",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),);
              },
              ),


              SizedBox(
                height: 10.0,
              ),


          IconButton(icon: Icon(Icons.location_on,color: Colors.blue,),onPressed: () {Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyLocation()));}),
              SizedBox(
                height: 10.0,
              ),

           Text(
          "To Get User Current Location click on the location icon",
           style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),

           ),
              SizedBox(
                height: 300,
              ),
              RaisedButton(
                onPressed: () {Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>Search()));},
                child: Text('Group details'),
                color: Colors.brown,
              )
            ],
          ),
        ),
      ),

    );
  }
}

