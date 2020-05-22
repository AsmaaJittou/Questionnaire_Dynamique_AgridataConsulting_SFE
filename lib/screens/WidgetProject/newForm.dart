import 'package:flutter/material.dart';
import 'package:programe/screens/WidgetProject/newCard.dart';
import 'package:programe/services/formService.dart';
import 'package:programe/models/form.dart';
import 'package:programe/models/card.dart';
import 'package:programe/screens/home/home.dart';
//var myCard= NewCard();
final keyCard = new GlobalKey<NewCardState>();
final List<GlobalKey<NewCardState>> listKeysCard=[];

class NewForm extends StatefulWidget {
  @override
NewFormState createState() => new NewFormState();
}
class NewFormState extends State<NewForm>{
  int newVal=1;  
  int lastVal=0;
  List<Key> listKeys=[];
  CardModel testModel ;
  List<String> testList;
  String inputTest;
  final FormService formDAO = new FormService();
List<String> listKeysToString=[];
int valInt=0;
  Formulaire formTest= new Formulaire();
    @override
 
  Widget build(BuildContext context){
   
    return new Scaffold(
   backgroundColor: Color.fromRGBO(42, 45, 46, .9),
      appBar: new AppBar(
        title: Text('new Formulaire'),
        
         backgroundColor: Color.fromRGBO(164, 203, 93, .9),
      ),
      
      body: new Center(
      
        child: new ListView(
          
         children: <Widget>[
          Text('Titre de formulaire:'), 
          TextField(decoration: InputDecoration(hintText: 'Saisir le titre'),
                onChanged: (val)
                  {
                  setState(() => formTest.title = val);
                  },
                      ),
             for(GlobalKey<NewCardState> itemKey in listKeysCard) 
           
            NewCard(key: itemKey),
           
          buttonRegisterForm(),
          ],         
        )
      ),
       floatingActionButton: FloatingActionButton(
       
          backgroundColor: Color.fromRGBO(164, 203, 93, .9),
       onPressed: (){
            counter();
            },
        child: Icon(Icons.add),
      ),
   
    );
  

  }
  
  Widget buttonRegisterForm(){
    return  SizedBox(
              width: double.infinity,
              child:  RaisedButton(
                 color: Color.fromRGBO(164, 203, 93, .9),
                 child: Text('Enregistrer'),
                 onPressed: () async{
               
                setState(() {
                  for(GlobalKey<NewCardState> itemKey in listKeysCard){
                  listKeysToString.add(itemKey.toString());
                   testList=itemKey.currentState.listContextInput;
                   
                   }
                   });
                   formTest.listCards=listKeysToString;
                   formDAO.createForm(formTest);
                   print('*******first************');
                    for(GlobalKey<NewCardState> itemKey in listKeysCard){
                      itemKey.currentState.listContextInput.add(itemKey.currentState.inputTest);
                  itemKey.currentState.cardModel.listContextInput=testList;
                    }
                     print('********another************');
                     for(GlobalKey<NewCardState> itemKey in listKeysCard){
                          formDAO.createCard(itemKey.currentState.cardModel); 
                          itemKey.currentState.resetForm();

                     }
                     setState(() {
                     listKeysToString.clear();
                     listKeysCard.clear();
                     });
                   
               },
              ),
            );
  } 
    counter(){ setState(() {
               listKeysCard.add(new GlobalKey<NewCardState>());
             });}
  
}