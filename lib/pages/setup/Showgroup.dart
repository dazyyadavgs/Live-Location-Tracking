import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:llt/pages/setup/createGroup.dart';

import 'GroupLocation.dart';


class GroupList extends StatefulWidget {
  // String grpname;
  // GroupList(this.grpname);
  const GroupList({Key? key}) : super(key: key);

  @override
  _GroupListState createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  late final User user;
  //  String grpname;
  //_GroupListState(this.grpname);
  @override
  void initState() {
    // TODO: implement initState
    user=FirebaseAuth.instance.currentUser!;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> cs =  FirebaseFirestore.instance
        .collection('groups')
       // .where('users', isEqualTo: user.displayName.toString())
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text('Group List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: cs,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
        {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if ( snapshot.connectionState == ConnectionState.active)
          {
            List<QueryDocumentSnapshot<Object?>> groupdata =
                snapshot.data!.docs;
            print(groupdata.length);
            if(groupdata.length != 0)
            {
              return ListView.builder(
                  itemCount: groupdata.length,
                  itemBuilder: (BuildContext context, int index){
                    return
                     Card(
                        child: ListTile(
                          title: Text(
                            groupdata[index]['groupname'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: FlatButton(
                            child: Text(
                              groupdata[index]['users'].join(', '),
                              maxLines: 1,
                            ),
                            onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GroupLocation(group: groupdata[index]['users'])));
                            },
                          )
                        ),
                      );
                  }
              );
            }
            else
              {
              return Center(
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    // TODO
                      "Create a group by clicking on the '+' button",
                      textAlign: TextAlign.center),
                ),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Groups(isload: false, selectedusernames: [], selectedusernamesbool: {})));
      },
        child: Icon(Icons.add),
      ),
    );

  }
}
