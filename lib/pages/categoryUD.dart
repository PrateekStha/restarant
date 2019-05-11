import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class categoryUD extends StatefulWidget {

  final id;
  categoryUD({this.id});
  @override
  _categoryUDState createState() => _categoryUDState();
}

class _categoryUDState extends State<categoryUD> {
  
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('List Of Categories '),
       ),
       body:Container(
            padding: const EdgeInsets.all(10.0),
            child: new StreamBuilder(
      stream: Firestore.instance.collection('categories').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        return new ListView(
          children: snapshot.data.documents.map<Widget>((document) {
            return new ListTile(
              title: new Text(document['category']),
              
              
            );
          }).toList(),
          
        );
        
      },
    ),
     )
     );
  }
}