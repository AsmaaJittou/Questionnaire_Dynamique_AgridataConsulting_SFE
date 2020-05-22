class User
{

  final String uid;
  final String nom; 
  final String prenom;
  final String email;
  final String cine;
  

User({this.uid,this.nom,this.prenom,this.email,this.cine});


User.fromData(Map<String,dynamic> data)
:uid = data['uid'], nom =data['nom'], prenom=data['prenom'] ,email=data['email'], cine =data['cine'];


Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'nom': nom,
      'prenom':prenom,
      'email': email,
      'cine': cine,
    };
  }

}

