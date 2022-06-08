
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home.dart';

class edit extends StatefulWidget {


  @override

  _editState createState() => _editState();
}

class _editState extends State<edit> {
  String? _name,_email;
  Map? data;
  User? loggedInUser;
  final _auth = FirebaseAuth.instance;
  final userCollection = FirebaseFirestore.instance.collection("Users");


  void getCurrentUser() async{
    try {
      final user = _auth.currentUser;
      if(user!=null) {
        loggedInUser = user;
        print(loggedInUser);
      }
    }catch (e) {
      print(e);
    }
  }

  void initState(){
    super.initState();
    getCurrentUser();
  }


  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  Future<void> addUser() {
    return users
        .doc(loggedInUser!.uid)
        .set({"name": _name,"email":_email}).then((value)=>print("User Added"))
        .catchError((error)=>print("Failed to add user: $error"));
  }


  fetchData() {
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection('Users');
    Stream documentStream = FirebaseFirestore.instance.collection('Users').doc(
        loggedInUser!.uid).snapshots();
    print(FirebaseFirestore.instance.collection('Users')
        .doc(loggedInUser!.uid)
        .get());
    documentStream.listen((snapshot) {
      setState(() {
        data = snapshot.data() as Map?;
        print(data.toString());
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Edit Profile Page"),
    ),
    body: Center(
    child: Column(
    children: [
      FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done)
            return Text("Update Details");
          return Text("name:$_name,email: $_email");

          },
      ),
    Padding(
    padding: const EdgeInsets.fromLTRB(0,32,0,0),
    child: Text(
    data.toString(),
    style: TextStyle(fontSize: 25)
    ),
    ),

    FlatButton (
    onPressed: fetchData,
    child: Text(" Detail here"),
    ),
    TextField(
    onChanged: (value) {
    _name = value;
    },
    decoration: InputDecoration(
    hintText: "Enter Name"
    )
    ),
      TextField(
          onChanged: (value) {
            _email = value;
          },
          decoration: InputDecoration(
              hintText: "Enter email"
          )
      ),
    ElevatedButton (
    onPressed: addUser,
      child: Text("Update"),
    ),
      ],
    ),
    ),
    );
  }

}
