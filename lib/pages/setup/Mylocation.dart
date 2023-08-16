import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'Mygeolocation.dart';
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyLocation(),
    );
  }
}


class MyLocation extends StatefulWidget {
  const MyLocation({Key? key}) : super(key: key);

  @override
  _MyLocationState createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  late User user;
  var locationMessage="";
  Map? data;
  //User? loggedInUser;
  //final userCollection = FirebaseFirestore.instance.collection("Users");

  /* void getCurrentLocation() async{
    var position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lastPosition=await Geolocator.getLastKnownPosition();
    print(lastPosition);
    var lat=position.latitude;
    var long=position.longitude;
    print("$lat,$long");
    setState(() {
      locationMessage= "Latitude: $lat, Longitude: $long";
    });
  } */

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    user=FirebaseAuth.instance.currentUser!;

  }
 /* addlocationfield() async {
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
  } */
  fetchData() {
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection('Users');
    Stream documentStream = collectionReference.doc(
        user!.uid).snapshots();
    print(FirebaseFirestore.instance.collection('Users')
        .doc(user!.uid)
        .get());
    documentStream.listen((snapshot) {
      setState(() {

        data = snapshot.data() as Map?;
        if(data!=null)
          locationMessage=data!['Location'];
        else
          locationMessage="";

        //_name=data!['displayName'];
        //_email=data!['email'];

        print(data.toString());
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location Service"),

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              size: 46.0,
              color: Colors.blue,


            ),
            SizedBox(
              height: 10.0,

            ),
            Text(
              "Get User Current Location",
              style: TextStyle(fontSize: 26.0,fontWeight: FontWeight.bold),

            ),
            SizedBox(
              height: 20.0,

            ),
            Text("$locationMessage"),
            FlatButton(
              onPressed: () {
               // getCurrentLocation();

              // addlocationfield();
                fetchData();


              },
              color: Colors.blue[800],
              child: Text("Get Current Location", style: TextStyle(color: Colors.white),),
            ),
            SizedBox(
              height: 20.0,
            ),
           /* RaisedButton(
              onPressed: navigateToMygeoloc,
              child: Text('To get map view click here'),
              color: Colors.tealAccent,

            ) */
          ],
        ),
      ),
      floatingActionButton: locationMessage!=""?FloatingActionButton(
        child: Text('Map View',textAlign: TextAlign.center,),
          onPressed: navigateToMygeoloc):null,
    );
  }
  void navigateToMygeoloc(){
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Mygeoloc()));
  }
}
