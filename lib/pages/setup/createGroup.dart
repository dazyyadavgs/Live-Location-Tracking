import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'Showgroup.dart';

class Groups extends StatefulWidget {
  bool isload;
  List<String> selectedusernames;
  Map<String, bool> selectedusernamesbool;
  Groups({Key? key,required this.isload,required this.selectedusernames,required this.selectedusernamesbool}) : super(key: key);

  //const Groups({Key? key}) : super(key: key);

  @override
  _GroupsState createState() => _GroupsState(isload ,selectedusernames,selectedusernamesbool);
}

class _GroupsState extends State<Groups> {
  late final User user;


  TextEditingController _groupnamecontroller=TextEditingController();
  bool isload;
  List<String> selectedusernames;
  Map<String, bool> selectedusernamesbool;
  _GroupsState(this.isload,this.selectedusernames,this.selectedusernamesbool);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
           // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                  controller: _groupnamecontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    hintText: "Group Name",

                  ),
                  style: TextStyle(

                  ),
                ),

                  // add button
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     ElevatedButton(
                        child: Text('CREATE'),
                        onPressed: () {
                          if (_groupnamecontroller.text.length != 0)
                          {
                            //TO DO
                            createcollectiongroup();
                          }
                          setState(
                                () {
                             isload =false;
                            },
                          );
                        },
                      ),
                     SizedBox(width: 5.0,),
                     ElevatedButton(
                       child: const Text('CANCEL'),
                       onPressed: () {
                         setState(
                            () {
                          isload = false;
                        },
                      );
                         //
                         // Navigator.of(context).pop();
                         _groupnamecontroller.clear();
                         Navigator.of(context).pop();

                       },

                     ),
                   ],
                 ),
                  // Cancel button




            ],
          ),
        ),
      ),
    );
  }
  Future<void> createcollectiongroup() async {
    user=FirebaseAuth.instance.currentUser!;
    Map<String, dynamic> mapgroups = {
      'groupname': _groupnamecontroller.text,
      'owner':user.displayName.toString(),
      'users': selectedusernames,

    };
    try {
      await FirebaseFirestore.instance.collection('groups').add(mapgroups);


    //  Navigator.of(context).pop();
     // Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context)=>GroupList()));
      setState(() {
        selectedusernames.clear();
        selectedusernamesbool.clear();
      });
      coolalertsuccess('Group created');
    } catch (e) {
      coolalertfailure('Failed to create group ${e}');
    }
  }
  coolalertsuccess(String text) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      title: 'Congratulations',
      text: text,
      loopAnimation: false,
    );
  }

  coolalertfailure(String text) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.error,
      title: 'Oops...',
      text: text,
      loopAnimation: false,
    );
  }
}
