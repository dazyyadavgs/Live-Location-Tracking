


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CrudeScreen extends StatefulWidget {
  const CrudeScreen({Key? key}) : super(key: key);

  @override
  _CrudeScreenState createState() => _CrudeScreenState();
}

class _CrudeScreenState extends State<CrudeScreen> {

  Color primaryColor = Color(0xff18203d);
  Color secondaryColor = Color(0xff23c51);
  Color logoGreen = Color(0xff25cbb);

  Map? data;



  addData() {
    Map<String, dynamic> demoData = {"name": "Dazy",
      "phone": "999xxx"
    };


    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection(
        'Users');
    collectionReference.add(demoData);
  }
  fetchData(){
    CollectionReference collectionReference=FirebaseFirestore.instance.collection('Users');
    collectionReference.snapshots().listen((snapshot) {

      setState(() {
        data = snapshot.docs[0].data() as Map?;
        print(data);
      });
    });
  }
  deleteData() async{
    CollectionReference collectionReference=FirebaseFirestore.instance.collection('Users');
    QuerySnapshot querySnapshot=  await collectionReference.get();
    querySnapshot.docs[0].reference.delete();

  }
  EditProfile() async{
    CollectionReference collectionReference=FirebaseFirestore.instance.collection('Users');
    QuerySnapshot querySnapshot=  await collectionReference.get();
    querySnapshot.docs[0].reference.update({"displayName":"Daisy"});
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      backgroundColor: Colors.blue,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 30,),
            Text(
              'Profile Page',
              textAlign: TextAlign.center,
              style:
              GoogleFonts.openSans(color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 70,),
            MaterialButton(
              elevation: 0,
              minWidth: double.maxFinite,
              height: 50,
              onPressed: fetchData,
              color: Colors.amber[900],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 10),
                  Text('Fetch Data',
                      style: TextStyle(color: Colors.white, fontSize: 20)),

                ],
              ),
              textColor: Colors.white,

            ),
            SizedBox(height: 20,),
            MaterialButton(
              elevation: 0,
              minWidth: double.maxFinite,
              height: 50,
              onPressed: addData,
              color: Colors.pink,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 10),
                  Text('Add Data',
                      style: TextStyle(color: Colors.white, fontSize: 20)),

                ],
              ),
              textColor: Colors.white,

            ),
            SizedBox(height: 20,),
            MaterialButton(
              elevation: 0,
              minWidth: double.maxFinite,
              height: 50,
              onPressed:EditProfile,
              color: Colors.green,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 10),
                  Text('Edit Profile',
                      style: TextStyle(color: Colors.white, fontSize: 20)),

                ],
              ),
              textColor: Colors.white,

            ),
            SizedBox(height: 20,),
            MaterialButton(
              elevation: 0,
              minWidth: double.maxFinite,
              height: 50,
              onPressed: deleteData,
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 10),
                  Text('Delete Data',
                      style: TextStyle(color: Colors.white, fontSize: 20)),

                ],
              ),
              textColor: Colors.white,

            ),
            SizedBox(height: 30,),
            Text(
              data.toString(),
              textAlign: TextAlign.center,
              style:
              GoogleFonts.openSans(color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}



















