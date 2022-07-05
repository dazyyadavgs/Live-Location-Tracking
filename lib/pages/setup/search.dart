import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'createGroup.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  late final User user;
  bool _isSearching = false;
  bool _isLoading = false;
  List<String> _usernames = <String>[];
  List<String> _selectedusernames = <String>[];
  Map<String, bool> _selectedusernamesbool = <String, bool>{};
  TextEditingController _textEditingController=TextEditingController();
  @override
  @override
  void initState() {
    super.initState();

    user = FirebaseAuth.instance.currentUser!;

  }


  /*
  refreshState(VoidCallback fn) {
    if (mounted) setState(fn);
  }
  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

 */

  void _deleteselected(String label) {
    setState(
          () {
        _selectedusernamesbool.update(label, (value) => false,
            ifAbsent: () => false);
        _selectedusernames.removeAt(_selectedusernames.indexOf(label));
      },
    );
  }
  Widget _buildChip(String label,Color colour)
  {
    return Chip(
      labelPadding: EdgeInsets.all(2.0),
      avatar: CircleAvatar(
        backgroundColor: Colors.black,
        child: Text(label[0].toUpperCase()),
      ),
      label: Text(label,style: TextStyle(color: Colors.white),),
      deleteIcon: Icon(
        Icons.close,
      ),
      onDeleted: (){
        _deleteselected(label);
      },
      
    );
        
  }
  


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 30.0,),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Add Existing Users in a Group!',style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              SizedBox(height: 10.0,),

              TextField(
                controller: _textEditingController,

                onChanged: (text)async {
                  int i=0;

                      _usernames.clear();

                 await  FirebaseFirestore.instance
                      .collection("Users")
                      .where("displayName", isEqualTo: text)
                      .get()
                      .then((snapshot) {
                        setState(() {

                        snapshot.docs.forEach((element)
                       {
                         if (element['displayName']!=user.displayName.toString()!) {
                         if (!_usernames.contains(element['displayName'])) {
                           _usernames.insert(i, element['displayName']);
                           if (_selectedusernames.contains(
                               element['displayName'])) {
                             _selectedusernamesbool.update(
                                 element['displayName'], (value) => true,
                                 ifAbsent: () => true);
                           } else {
                             _selectedusernamesbool.update(
                                 element['displayName'], (value) => false,
                                 ifAbsent: () => false);
                           }
                         }
                         i++;
                         _textEditingController.clear();
                       }
                     else
                        {

                           coolalertfailure('Owner cannot be Added');
                          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Owner Cannot be Added')));
                         _textEditingController.clear();
                        }

                       }
                       );
                    });
                  });

                         },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  )
                ),

                ),
              Expanded(
                child: _isLoading? Center(child: CircularProgressIndicator())
                    :Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.symmetric(),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Wrap(
                          spacing: 6.0,
                          runSpacing: 6.0,
                          children: _selectedusernames.map((item) => _buildChip(item,Color(0xFFff6666)))
                            .toList().cast<Widget>()),
                        ),
                      ),
                    Divider(thickness: 1.0,),
                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: _usernames.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 1.0, horizontal: 4.0),
                            child: Card(
                                child: ListTile(
                                    onTap: () {
                                      setState(() {
                                        if (!_selectedusernamesbool[
                                        _usernames[index]]!) {
                                          _selectedusernames.insert(
                                              _selectedusernames.length,
                                              _usernames[index]);
                                          _selectedusernamesbool.update(
                                              _usernames[index], (value) => true,
                                              ifAbsent: () => true);
                                        }else{
                                          _deleteselected(_usernames[index]);
                                        }
                                      });
                                    },
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.black,
                                      child: Text(
                                          _usernames[index][0].toUpperCase()),
                                    ),
                                    title: Text(_usernames[index]),
                                    trailing:
                                    _selectedusernamesbool[_usernames[index]]!
                                        ? Icon(Icons.check)
                                        : null)));
                      },
                    ),
                  ],
                ),
              ),
                ],
              ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.check),
          onPressed: creategroup,
        ),
      ),

    );
  }
  void creategroup() {
    if (_selectedusernames.isEmpty) {
      coolalertfailure('No users selected');
    } else {

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Groups(isload: _isLoading, selectedusernamesbool: _selectedusernamesbool, selectedusernames: _selectedusernames,)));
    }
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
