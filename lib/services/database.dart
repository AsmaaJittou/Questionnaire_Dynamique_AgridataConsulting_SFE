import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:programe/models/test.dart';
import 'package:programe/models/user.dart';

class DatabaseService 
{

final String uid;

DatabaseService({this.uid});

  final CollectionReference userCollection = Firestore.instance.collection("user");

Future updateUserData(String name ,String lastName , int age)
async {
 return await userCollection.document(uid).setData({
   'name' : name,
   'lastName' : lastName,
   'age' : age
 });

}

updateUserAccess(String selectedDocument, newValue)
 async {
 Firestore.instance
 .collection('user')
 .document(selectedDocument)
 .updateData({"access": newValue});
}

 Future getUsers() async{
        var firestore = Firestore.instance;
       QuerySnapshot query = await  firestore.collection('user').getDocuments();
  return query.documents;
  
   }

}