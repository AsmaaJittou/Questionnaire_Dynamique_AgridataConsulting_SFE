import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class EditFormResponse extends StatefulWidget {
  
    final List<dynamic> listCards;
     EditFormResponse({Key key,this.listCards}) : super(key: key);

     @override
     _EditFormResponseState createState() => new _EditFormResponseState();
}

const List<String> tabNames = const<String>[
     'Questions', 'Réponses'
];

class _EditFormResponseState extends State<EditFormResponse> {

     int _screen = 0;
     var txt = TextEditingController();
     
 final _formKey = GlobalKey<FormState>();
     Future getCards() async{
        var firestore = Firestore.instance;
       QuerySnapshot query = await  firestore.collection('card').getDocuments();
      
             return query.documents;
   }

   
     @override
     Widget build(BuildContext context) {
       return new DefaultTabController(
         length: tabNames.length,
         child: new Scaffold(
           appBar: new AppBar(
             title: new Text('Editer le formulaire'),
           ),
           body: new TabBarView(
             children: new List<Widget>.generate(tabNames.length, (int index) {
               switch (_screen) {
                 case 0: return Center(
                   child:  Container(
                     child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
            .collection('card')
            .snapshots(),
          builder: ( _, snapshot){
           Widget list;
           if(snapshot.connectionState == ConnectionState.waiting){
            list = Center(child: Text('Loading ... '),);
            
          }
          else {
            
       list= ListView.separated(
                       shrinkWrap: true,
                      padding: EdgeInsets.all(10.0),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, nbr) {
          
          for(dynamic item in widget.listCards){
          // print(snapshot.data.documents);
            if(snapshot.data.documents[nbr].data['idCard'].contains(item)){
              print(snapshot.data.documents[nbr].data['idCard']);
           return new Card( 
              child:  Form(  
             key: new GlobalKey<FormState>(),
              child: TextFormField(
              initialValue: 'tfo',
               ),),);
            }
            }
           },
           separatorBuilder: (context, nbr) {
          return Divider();
        }
           
         //  }
           
     //   else return Text('tfo');
         //  }
           );
            print('*******');
          }
          return list;
          }
                      ),
                     ),
 
                     
                 );
                 case 1: return new Center(
                   child: new Text('Second screen'),
                 );
               }
             }),
           ),

           bottomNavigationBar: new Column(
             mainAxisSize: MainAxisSize.min,
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
            
               new BottomNavigationBar(
                 currentIndex: _screen,
                 onTap: (int index) {
                   setState(() {
                     _screen = index;
                   });
                 },
                 items: [
                   new BottomNavigationBarItem(
                     icon: new Icon(Icons.question_answer),
                     title: new Text('Questions'),
                   ),
                   new BottomNavigationBarItem(
                     icon: new Icon(Icons.check_circle),
                     title: new Text('Réponses'),
                   ),
                 ],
               ),
             ],
           ),
         ),
       );
     }
}