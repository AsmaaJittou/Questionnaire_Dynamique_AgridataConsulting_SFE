import 'package:flutter/material.dart';
import 'package:programe/services/database.dart';
import 'package:programe/admin/listForms/questionResponse.dart';

class CardForm extends StatefulWidget {
  final AsyncSnapshot<dynamic> snapshot;
   int index;
   CardForm({Key key, this.snapshot,this.index}) : super(key: key);
  @override 
  CardFormState createState() => CardFormState();
}

class CardFormState extends State<CardForm> {
  
 
final _formKey = new GlobalKey<FormState>(); 
DatabaseService serviceData = new DatabaseService();
 
  @override
  Widget build(BuildContext context) {
    return Card(
        //   margin:EdgeInsets.fromLTRB(10.0,3.0,20.0,0.0),
            
        child:Column(
          
          children: <Widget>[
            Row(
            children: <Widget>[
              Expanded(
                flex:6,
                child: Container(
               child: ListTile(
              
               title: Text(widget.snapshot.data[widget.index].data["title"]??'test'),
          ),
                )
                ),
                Expanded(
                  flex:1,
                  child: Container(
                    child:  SizedBox(
                     
                      child :RaisedButton(
                       child:  Icon(Icons.more,size: 20,color: Colors.white),
                       color: Colors.blue,
                       onPressed: () async{
                   Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                   return new EditFormResponse(key: _formKey, listCards: widget.snapshot.data[widget.index].data['keyCards']);
                    
                    }));
                          },
                    ),
                    ),
                  ))
            ],
            ),
         
          ]
           ),
              
    );
  }
}