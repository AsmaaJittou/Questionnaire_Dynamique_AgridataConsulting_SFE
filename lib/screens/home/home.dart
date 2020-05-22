
import 'package:flutter/material.dart';
import 'package:programe/screens/WidgetProject/newForm.dart';
import 'package:programe/services/auth.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:programe/admin/listForms/listForm.dart';
class Home extends StatefulWidget  {
  
     @override
     _HomeState createState() => new _HomeState();
}

const List<String> tabNames = const<String>[
     'Questions', 'Réponses'
];

class _HomeState extends State<Home> {
  int _screen = 0;
  @override
  Widget build(BuildContext context) {
    
    const List<String> tabNames = const<String>[
     'Accueil', 'Utilisateurs','Formulaires'
];
    return MaterialApp(
       title: 'Espace Administrateur',
      theme: ThemeData(
        backgroundColor: Color.fromRGBO(245, 177, 42, .9),
        primarySwatch: Colors.red,
        bottomAppBarColor: Color.fromRGBO(42, 45, 46, .9),
        scaffoldBackgroundColor:  Color.fromRGBO(42, 45, 46, .9),
      ),
    home: Scaffold(
    // backgroundColor: Color.fromRGBO(42, 45, 46, .9),
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Color.fromRGBO(164, 203, 93, .9),
        elevation: 0.0,
        actions : <Widget>[
        
         
        ],
      ),

     
   
       body: new DefaultTabController(
         length: tabNames.length,
         child: new Scaffold(
           
           body: new TabBarView(
             children: new List<Widget>.generate(tabNames.length, (int index) {
               switch (_screen) {
                 case 0: return Center(
                   child: new Text('first screen'),
                 );
                 case 1: return new Center(
                   child: new Text('Second screen'),
                 );
                  case 2: return new Center(
                   child: Column(
                    children: <Widget>[
                  //  ListForms(),
                    FloatingActionButton(
        backgroundColor: Color.fromRGBO(164, 203, 93, .9),
       onPressed: (){
              Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                return new NewForm();
              }));
            },
        tooltip: 'add new form',
        child: Icon(Icons.add),
      ),
      ],
                   ),
                 );
                  
               }
             }),
           ),

           bottomNavigationBar: 
           new Theme(
    data: Theme.of(context).copyWith(
        // sets the background color of the `BottomNavigationBar`
        canvasColor:  Color.fromRGBO(164, 203, 93, .9),
        // sets the active color of the `BottomNavigationBar` if `Brightness` is light
        primaryColor:  Colors.black,
        textTheme: Theme
            .of(context)
            .textTheme
            .copyWith(caption: new TextStyle(color: Color.fromRGBO(42, 45, 46, .9)))), // sets the inactive color of the `BottomNavigationBar`
   child : new Column(
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
                     icon: new Icon(Icons.home),
                     title: new Text('Accueil'),
                   ),
                   new BottomNavigationBarItem(
                     icon: new Icon(Icons.contacts),
                     title: new Text('Utilisateurs'),
                   ),
                    new BottomNavigationBarItem(
                     icon: new Icon(Icons.filter_list),
                     title: new Text('Formulaires'),
                   ),
                 ],
               ),
             ],
           ),
         ),
       ),
    )
    )
      );
    
  }
}
/*
    floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(164, 203, 93, .9),
       onPressed: (){
              Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                return new NewForm();
              }));
            },
        tooltip: 'add new form',
        child: Icon(Icons.add),
      ),
    */