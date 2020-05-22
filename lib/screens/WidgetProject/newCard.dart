import 'package:flutter/material.dart';
import 'package:programe/screens/WidgetProject/newCheck.dart';
import 'package:programe/screens/WidgetProject/newListDerolante.dart';
import 'package:programe/screens/WidgetProject/newRadioButton.dart';
import 'package:programe/shares/constant.dart';
import 'package:programe/services/formService.dart';
import 'package:programe/models/card.dart';

class NewCard extends StatefulWidget {

   NewCard({Key key}) : super(key: key);
  @override 
  NewCardState createState() => NewCardState();
}

class NewCardState extends State<NewCard> {

  @override
  
 static String question ='';
 static String typeInput ='';
 static String typeInput2=''; //textInput !!
  List<String> listContextInput=[];
 int i=0;


  final FormService formDAO = new FormService();
    final _formKey = GlobalKey<FormState>();
  final CardModel cardModel = new CardModel(); 
 
  List<Key> listKeys=[];                                                          
  List<String> listValues=['Input Text'];
  List<String> inputsType = ['Liste Déroulante', 'Radio Button', 'check', 'Input Text'];

  String inputTest;
 

  final myController = TextEditingController();

  void resetForm() {
    setState(() {
      _formKey.currentState.reset();
    });
  }
 
   Widget build(BuildContext context) {
     
    return new SingleChildScrollView(
      child:   new Card(
              elevation: 8.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child:  Form( 
                key: _formKey,
                child : new Container(
                  decoration: BoxDecoration(color: Color.fromRGBO(245, 177, 42, .9)),
                child: new Column(
          children: <Widget>[
            Row(
            children: <Widget>[
              Expanded(
                  flex: 2,
                  
                  child: Container(
                    // tag: 'hero',
                    child:  SizedBox(
                     
                      child :RaisedButton(
                       child:  Icon(Icons.cancel,size: 20,color: Color.fromRGBO(42, 45, 46, .9)),
                       color: Color.fromRGBO(164, 203, 93, .9),
                       onPressed: () async{
                      
                          },
                    ),
                    ),
                  )),
              Expanded(
                flex: 10,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: textQuestion(),),
              )
            ],
          ),

            
            listChoix(),   
            SizedBox(
                    child: inputTextOnly(),
                   ) ,
               for(Key key in listKeys )
            SizedBox(
              child:newInputSelected(typeInput,key),
            ) ,
            
             buttonAdd(),
          ],
          
        ) ,
              ),
             
              ),
             
            ),
            
    );
  }

   Widget textQuestion(){
     return new TextFormField(
              // decoration: InputFormulaire,
              decoration: InputDecoration(
                  icon: Icon(Icons.question_answer)
                ),
                style: TextStyle(
                fontSize: 15.0,
                color: Colors.orange[300]            
              ),
                 validator: (val) => val.isEmpty ? 'remplir ce champs!' : null,
                onChanged : (val)
                {
             setState(() => cardModel.question=val);
                }
              );

   }

  
   Widget listChoix(){
     return  new DropdownButton<String>(
                hint: Text('choisir type input'),
                items: inputsType.map((String value) {
                 return new DropdownMenuItem<String>( 
                   value: value, 
                   child: new Text(value), 
                   ); 
                   }).toList(), 
                onChanged:  (val) async{
                    setState(() { typeInput=val; typeInput2=val; cardModel.inputType=val;
                    cardModel.idCard=widget.key.toString();
                    });
                 //print(val);
                 testValue(val);
                 addInputToList(typeInput);
              }, 
              );
   }



    Widget newInputSelected(String value, Key key) {
      Widget choix = SizedBox();

     if(value==inputsType[0]){
              choix= SizedBox( child: newListDeroul(key));
                }else if(value==inputsType[1]){
                choix= SizedBox( child: newRadioButton(key));
          
                }else if(value==inputsType[2]){
                  setState(() { i++; });
                 choix=  SizedBox( child: newCheck(key));
                 i++;
                
                } 
                 return  choix; 
  }

  
  Widget inputTextOnly(){
    Widget choix= SizedBox();
if(typeInput2==inputsType[3]){
                 choix= SizedBox(child: TextField( enabled: false,  decoration: new InputDecoration(
                hintText: 'Rédiger un text',
              ),) );
                }
   return choix;
  }

   Widget buttonAdd() {
     return new RaisedButton(
               child:  Icon(Icons.add),
               color: Color.fromRGBO(164, 203, 93, .9),
               onPressed: () async{
                counter();
               },
              );
   }

   //***************SIMPLE FUNCTIONS *********************
    counter(){ setState(() {
           listKeys.add(UniqueKey());
             });}

    addInputToList(String inpt){ setState(() {
      listValues.add(inpt);
    });}
    
    addInputContext(String inpt){ setState(() {
      listContextInput.add(inpt);
    });}

    testValue(String value){
      if(listValues[listValues.length-1]!=value){
        listKeys.clear();
        listContextInput.clear();
      }
    }

    ///*********CHECKKKKK */
      Widget newCheck(Key key){
     return new  Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
          children: <Widget>[
             Row(
            children: <Widget>[
              Expanded(
                 flex: 0,
                 child: Container(
                   child:  SizedBox(
                  width: 100,
                  child: newCheckbox(),
                  ),
                 ),
              ),
              Expanded(
                
                 child: Container(
                  child: SizedBox(
                    width: 100,
                    child:  inptText(key) ,
                    ),
            
                 ),),
              ],),
          
            
           
          ]
             );
   }

   Widget newCheckbox(){
   return new Checkbox(
                   value: false,
                    onChanged: (val) {
                     
                      },
                  );
   }
   Widget inptText(Key key){
     return new TextField(
       key: key,
      onChanged: (val) {
      setState(() {
        inputTest=val;
      });
      
      },
      
     /* onSubmitted: (value){
        listContextInput.add(inputTest);
       // listContextInput.add(value);
      },*/
       decoration: InputDecoration(
      contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0,),
      hintText: 'Option  ',//+ i.toString(),
       )
     );
     
   }
  

 ///******************RADIO BUTTON */
 Widget newRadioButton(Key key){
     return new  Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
             SizedBox(
  width: 200,
  child:  radioWidget(key),
   ),
        
          ]
             );
   }

   Widget radioWidget(Key key){
         return new  ListTile(
                  title: TextField(
                    key: key,
                   onChanged: (val)async{
                      addInputContext(val);
                    },
                  ),
                  leading: Radio(
                    value: key,
                    groupValue: key,
                    onChanged: (val) {
                      },
            ),
            );
   }

/////********LIST DEROULANTE */
 Widget newListDeroul(Key key){
     return new  Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  
          children: <Widget>[
                    SizedBox(
                    width: 100,
                    child: inputListDeroulante(key),
                    ),
                            
           
          ]
             );
    
   }
     Widget inputListDeroulante(Key key){
     return new TextField(
       key: key,
       onChanged: (val)async{
        addInputContext(val);
      },
       decoration: InputDecoration(
      contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0,)
       )
     );
   }

}


  