import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:llt/main.dart';
import 'package:llt/pages/setup/search.dart';

class samplegroups extends StatefulWidget {
  const samplegroups ({Key? key}) : super(key: key);


  @override
  _samplegroupsState createState() => _samplegroupsState();
}

class _samplegroupsState extends State<samplegroups> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a Group'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () { Navigator.push(context,
          MaterialPageRoute(builder: (context) => WelcomePage())); },
        child: Text('click'),


      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('groups').snapshots(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot ){
          if(!snapshot.hasData){
            return Center(
              child:
              CircularProgressIndicator(),
            );
          }
          return ListView(
            children:
            snapshot.data!.docs.map((docs)
          {
            return Center(
              child: Container(
                  width:
                  MediaQuery
                      .of(context)
                      .size
                      .height / 1.2,

              )

            );

            }).toList(),
          );

    }
      ),
    );
  }
}
