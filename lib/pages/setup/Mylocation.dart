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
  var locationMessage="";
  void getCurrentLocation() async{
    var position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lastPosition=await Geolocator.getLastKnownPosition();
    print(lastPosition);
    var lat=position.latitude;
    var long=position.longitude;
    print("$lat,$long");
    setState(() {
      locationMessage= "Latitude: $lat, Longitude: $long";
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
            Text("Position: $locationMessage"),
            FlatButton(
              onPressed: () {
                getCurrentLocation();
              },
              color: Colors.blue[800],
              child: Text("Get Current Location", style: TextStyle(color: Colors.white),),
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              onPressed: navigateToMygeoloc,
              child: Text('To get map view click here'),
              color: Colors.tealAccent,

            )
          ],
        ),
      ),
    );
  }
  void navigateToMygeoloc(){
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Mygeoloc()));
  }
}
