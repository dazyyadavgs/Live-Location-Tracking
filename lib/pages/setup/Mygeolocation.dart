

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mygeoloc extends StatefulWidget {
  //var locationMessage;
  const Mygeoloc({Key? key}) : super(key: key);

  @override
  _MygeolocState createState() => _MygeolocState();
}

class _MygeolocState extends State<Mygeoloc> {
  bool mapToggle = false;
  var currentLocation;

  late GoogleMapController mapController;



@override
  void initState()
  {
    super.initState();
    Geolocator.getCurrentPosition().then((currloc){
      setState(() {
        currentLocation =  currloc;
        mapToggle = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('location service'),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height -80,
                  width: double.infinity,
                  child: mapToggle ?
                  GoogleMap(
                    mapType: MapType.hybrid,
                    myLocationEnabled: true,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(currentLocation.latitude,currentLocation.longitude),

                        zoom: 10.0
                    ),
                    onMapCreated: (GoogleMapController controller){
                      mapController = controller;
                    },
                  ):
                  Center(child:
                  Text('loading..please wait..',
                    style: TextStyle(
                        fontSize: 20.0
                    ),
                  ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  void onMapCreated(controller){
    setState(() {
      mapController = controller;
    });
  }
}





















