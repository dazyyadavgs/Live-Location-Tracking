import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroupLocation extends StatefulWidget {
  List<dynamic> group;
  GroupLocation({Key? key, required this.group}) : super(key: key);

  @override
  _GroupLocationState createState() => _GroupLocationState(group);
}

class _GroupLocationState extends State<GroupLocation> {
  List<dynamic> group;
  List<dynamic> position = <String>[];
  bool loading = true;
  _GroupLocationState(this.group);
  Future<void> getUsers() async {
    for(int i = 0; i<group.length;i++) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection("Users")
          .doc(group[i])
          .get();
      if (userSnapshot.exists) {
        Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
        String Location = userData["Location"];
        position.insert(i, Location.toString());
        print("Location: $Location");
      } else {
        print("User document not found.");
        position.insert(i, "Location not found");
      }
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return CircularProgressIndicator(); // Show loading indicator
    }
    // getUsers();
    return ListView.builder(itemCount: group.length, itemBuilder: (BuildContext context, int index) {
      return Card(
        child: ListTile(
          title: Text('${group[index]}'),
          subtitle: Text('${position[index]}'),
          leading: Icon(Icons.accessibility_new_rounded),
        ),
      );
    },
    );
  }
}
