
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:programe/USER/screens/authenticate/register.dart';
import 'package:programe/USER/screens/forgotPassword.dart';
import 'package:programe/USER/screens/home/home.dart';
import 'package:programe/services/Login_phone.dart';
import 'package:programe/services/auth.dart';
import 'package:programe/services/signInmethod.dart';
import 'package:programe/shares/constant.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:programe/admin/home/home.dart';

class SignIn extends StatefulWidget {
   final Function toggleView;
   
  SignIn({this.toggleView});

 
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

 final AuthService _auth = AuthService();
final _authe = FirebaseAuth.instance;
FirebaseUser loggedInUser;
 final _formKey = GlobalKey<FormState>();

  @override
void initState() 
 {
  getCurrentUser();
  super.initState();
}


 void getCurrentUser() async{
  try{
    final user = await _authe.currentUser() ;
    if(user!=null)
    {
      loggedInUser =user;
      print(loggedInUser.uid);
    }
  }catch(e)
  {
    print(e);
  }
}
  
 bool loading =false;
 String email ='';
 String password ='';
 String error='';
 bool _isEmailVerified = false;
 AuthService auth = AuthService();
ProgressDialog pr;
  @override
  Widget build(BuildContext context) {
 pr = new ProgressDialog(context);
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
pr.style(

  borderRadius: 10.0,
  backgroundColor: Colors.white,
  progressWidget: CircularProgressIndicator(),
  elevation: 10.0,
  insetAnimCurve: Curves.easeInOut,
  progress: 0.0,
  maxProgress: 100.0,
  progressTextStyle: TextStyle(
     color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
  messageTextStyle: TextStyle(
     color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
  );
    return  Scaffold(
      resizeToAvoidBottomPadding: false ,
      backgroundColor: Colors.green[255],

      appBar: AppBar(

backgroundColor: Colors.green,
elevation: 0.0,


actions: <Widget>[
 FlatButton.icon(
   icon: Icon(Icons.person),
   onPressed: () {
      Navigator.of(context).push(CupertinoPageRoute(
                    builder: (BuildContext context) => Register()));
   }, 
   label: Text('Inscrire'),
   ) 
],

      ),
body: Container(

  decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.green, Colors.orange])
              ),

  padding: EdgeInsets.symmetric(vertical:10.0,horizontal:50.0),
  child : Form( 
    key: _formKey,
    child: Column(
children: <Widget>[
  SizedBox(
          height: 120.0,
          child: Image.asset(
            "images//beOne.png",
            fit: BoxFit.contain,
          width: 300,
          ),
        ),
 TextFormField(
   decoration: emailField,
    validator: (val) => val.isEmpty ? 'Enter an Email' : null,
   onChanged : (val)
   {
setState(() => email = val);
   }
 ),
SizedBox(height: 20.0),
TextFormField(
 decoration: passwordField,
   validator: (val) => val.length <6 ? 'Enter a password 6+ chars Long ' : null,
  obscureText: true,
onChanged: (val)
{
setState(() => password = val);
},
),
SizedBox(height:30.0),
Material(
 borderRadius: BorderRadius.circular(32.0),
  color:  Colors.orange,
  child : MaterialButton(
child: Text(
    'Connecter',
    
     style: TextStyle(color : Colors.white , fontFamily: 'Montserrat' ,fontWeight: FontWeight.bold) ,
  ),
  minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () async {
if(_formKey.currentState.validate())
{  
final user = await _authe.signInWithEmailAndPassword(email: email.trim(), password: password);
  
  FirebaseUser userID = await FirebaseAuth.instance.currentUser();

 var result = await Firestore.instance 
      .collection("user")
      .where("ID_user", isEqualTo: userID.uid) 
      .getDocuments();
  result.documents.forEach((res) {
   if(res.data['role']=="admin")
   {
 pr.show();
 Future.delayed(Duration(seconds: 3)).then((value) {
              pr.hide().whenComplete(() {
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (BuildContext context) => Home()));
              });
 });
   }else
   {
     pr.show();
 Future.delayed(Duration(seconds: 3)).then((value) {
              pr.hide().whenComplete(() {
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (BuildContext context) => home()));
              });
 });
   }
  });

  

  //dynamic  result =await _auth.SignInWithEmailandPassword(email, password);

}

}
            
  ),

  
  
  

 
),
SizedBox(height:20.0),

_signInButton(),

showForgotPassword(),


SizedBox(height:30.0),

 new FloatingActionButton.extended(
        onPressed: () {
Navigator.of(context).push(CupertinoPageRoute(
                    builder: (BuildContext context) => Login_phone()));
        },
        tooltip: 'get code',
        icon: Icon(Icons.send),
        label: Text('Connexion par Telephone'),
        backgroundColor: Colors.green[200],
      ),
],
    ), 
  
  ),

  
),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.black,
      hoverColor: Colors.green[100],
      onPressed: (){
    signInWithGoogle().whenComplete(() {
        pr.show();
         Future.delayed(Duration(seconds: 3)).then((value) {
              pr.hide().whenComplete(() {
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (BuildContext context) => home()));
              });
 });
    });
  },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.green[100]),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Image(image: AssetImage("images/google_logo.png"), height: 30.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Continuer avec Google ',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );

  }
Widget showForgotPassword()
{
  
  return FlatButton(
  child: Text("Mot de passe oublié ?",
  style: TextStyle(
    color:Colors.black26,
    fontFamily: 'Montserrat',
  ),
  ),
  onPressed: ()
  {
  Navigator.of(context).push(CupertinoPageRoute(
                    builder: (BuildContext context) => ForgotPassword()));
  },
  );
  
}
 void _checkEmailVerification() async {
	    _isEmailVerified = await auth.isEmailVerified();
	    if (!_isEmailVerified) {
	      _showVerifyEmailDialog();

	    }else 
      {
         Navigator.of(context).push(CupertinoPageRoute(
                    builder: (BuildContext context) => home()));
      }
	  }

	

	  void _showVerifyEmailDialog() {
	    showDialog(
	      context: context,
	      builder: (BuildContext context) {
	        // return object of type Dialog
	        return AlertDialog(
	          title: new Text("Verify your account"),
	          content: new Text("Please verify account in the link sent to email"),
	          actions: <Widget>[
	            new FlatButton(
	              child: new Text("Resent link"),
	              onPressed: () {
                auth.sendEmailVerification();
	                Navigator.of(context).pop();
	                //_resentVerifyEmail();
	              },
	            ),
	            new FlatButton(
	              child: new Text("Dismiss"),
	              onPressed: () {
	                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (BuildContext context) => SignIn()));
	              },
	            ),
	          ],
	        );
	      },
	    );
	  }


    
  
}

