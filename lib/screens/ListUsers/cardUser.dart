import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:programe/services/database.dart';

class CardUser extends StatefulWidget {
  final AsyncSnapshot<dynamic> snapshot;
   int index=0;
   CardUser({Key key, this.snapshot,this.index}) : super(key: key);
  @override 
  CardUserState createState() => CardUserState();
}

class CardUserState extends State<CardUser> {
  
 
final _formKey = new GlobalKey<FormState>(); 
DatabaseService serviceData = new DatabaseService();
 
  @override
  Widget build(BuildContext context) {
    return Card(
        //   margin:EdgeInsets.fromLTRB(10.0,3.0,20.0,0.0),
              child:  Form( 
              key: _formKey,
        child:Column(children: <Widget>[
         ListTile(
          title: Text(widget.snapshot.data[widget.index].data["nom"]??''),
          ),
         Switch(
           
             value: widget.snapshot.data == null ? false : widget.snapshot.data[widget.index].data["access"],
          
          onChanged: (value) async {
             Firestore.instance.runTransaction((transaction) async { 
              DocumentSnapshot freshSnap = await transaction.get(widget.snapshot.data[widget.index].documentID);
              await transaction.update(freshSnap.reference, {
                "access": value
              });
            });
         
          },
          /*
          print(widget.snapshot.data[widget.index].documentID);
        serviceData.updateUserAccess(widget.snapshot.data[widget.index].documentID,value);
          }*/
          activeTrackColor: Colors.lightGreenAccent, 
          activeColor: Colors.green,
        ),
          ]
           ),
              ),
    );
  }
}