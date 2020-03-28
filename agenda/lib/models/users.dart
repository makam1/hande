import 'dart:async';
import 'dart:convert';
import 'package:Hande/models/login.dart';
import 'package:http/http.dart' as http;

class Users{
  int id;
  String prenom;
  String nom;
  String username;

  Users({
    this.id,
    this.nom,
    this.prenom,
    this.username
  });

  factory Users.fromJson(Map <String, dynamic> json){
    return Users(
      id:json['id'],
      prenom:json['prenom'],
      nom:json['nom'],
      username:json['username'],
    );
  }
}

  Future<List<Users>> fetchUsers(http.Client client) async{
    String token = await LoginState().getToken();
    String newStr = token.substring(1, token.length-1);
    final response= await client.get('https://bdfbfa40.ngrok.io/api/users',headers:{
       'Accept': 'application/json',
       'Authorization': 'Bearer $newStr',   
       });
       print(response);
    if(response.statusCode==200){
      Map <String, dynamic> mapResponse= jsonDecode(response.body);
      final users= mapResponse['data'].cost<Map<String, dynamic>>();
      final listOfUsers= await users.map<Users>((json){
        return Users.fromJson(json[0]);
      }).toList();
        return listOfUsers;
      }else{
        throw Exception('Error');
  }
}