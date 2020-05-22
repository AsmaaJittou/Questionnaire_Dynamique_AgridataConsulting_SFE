import 'package:flutter/material.dart';

class UpdateForm extends StatefulWidget {
     UpdateForm({Key key}) : super(key: key);

     @override
     _UpdateFormState createState() => new _UpdateFormState();
}

const List<String> tabNames = const<String>[
     'foo', 'bar', 'baz', 'quox', 'quuz', 'corge', 'grault', 'garply', 'waldo'
];

class _UpdateFormState extends State<UpdateForm> {

     int _screen = 0;
     bool isSwitched = true;
     @override
     Widget build(BuildContext context) {
       return new DefaultTabController(
         length: tabNames.length,
         child: new Scaffold(
           appBar: new AppBar(
             title: new Text('Navigation example'),
           ),
           body: new TabBarView(
             children: new List<Widget>.generate(tabNames.length, (int index) {
               switch (_screen) {
                 case 0: return new Center(
                   child: Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                      activeTrackColor: Colors.lightGreenAccent, 
                      activeColor: Colors.green,
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
               new AnimatedCrossFade(
                 firstChild: new Material(
                   color: Theme
                     .of(context)
                     .primaryColor,
                   child: new TabBar(
                     isScrollable: true,
                     tabs: new List.generate(tabNames.length, (index) {
                       return new Tab(text: tabNames[index].toUpperCase());
                     }),
                   ),
                 ),
                 secondChild: new Container(),
                 crossFadeState: _screen == 0
                                 ? CrossFadeState.showFirst
                                 : CrossFadeState.showSecond,
                 duration: const Duration(milliseconds: 300),
               ),
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
                     title: new Text('Qestions'),
                   ),
                   new BottomNavigationBarItem(
                     icon: new Icon(Icons.check),
                     title: new Text('Responses'),
                   ),
                 ],
               ),
             ],
           ),
         ),
       );
     }
}