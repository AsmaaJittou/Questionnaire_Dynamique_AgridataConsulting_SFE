
import 'package:flutter/material.dart';

import 'package:programe/USER/screens/home/onboarding3.dart';
import 'package:flutter/cupertino.dart';
class Onboar2 extends StatefulWidget  {
  
     @override
     _Onboar2State createState() => new _Onboar2State();
}

class _Onboar2State extends State<Onboar2> {
  int _screen = 0;
  @override
  Widget build(BuildContext context) {
    
    const List<String> tabNames = const<String>[
     'Accueil', 'Utilisateurs','Formulaires'
];
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        bottomAppBarColor: Color.fromRGBO(42, 45, 46, .9),
        scaffoldBackgroundColor:  Color.fromRGBO(253, 235, 208 , .9),
      ),
    home: Scaffold(
       body: Container(
         child: new DefaultTabController(
           length: tabNames.length,
           child: new Scaffold(
             
             body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/Slide2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
             SizedBox(height: 500,),
              Row(
                children: <Widget>[
                   SizedBox(width: 250,),
                FlatButton(
  child: Text("Suivant",
  style: TextStyle(
    color:Colors.white,
    fontFamily: 'Montserrat',
  ),
  ),
  onPressed: ()
  {
  Navigator.of(context).push(CupertinoPageRoute(
                    builder: (BuildContext context) => Onboar3()));
  },
  )  ],
              ),
            ],
          ),
        ), 
       
      ),

         ),
    ),
       )
    )
      );
    
  }
}
