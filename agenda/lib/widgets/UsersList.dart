import 'dart:convert';

import 'package:Hande/models/login.dart';
import 'package:flutter/material.dart';
import 'package:Hande/models/users.dart';
import 'package:http/http.dart' as http;


class UsersList extends StatelessWidget{
final List<Users> users;

  UsersList({Key key,this.users}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder:(context,index ){
      return GestureDetector(
         child: Container(
           padding: EdgeInsets.all(10.0),
        //   color: index % 2==0? Colors.redAccent:Colors.yellowAccent,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
              new Text(users[index].username,style:TextStyle(fontWeight: FontWeight.bold,fontSize:16.0)),
              //new Text(users[index].nom,style:TextStyle(fontSize:16.0))
            ],
          ), 
        ),
      );
    });
  }
}

class UsersScreen extends StatefulWidget{
  @override  State createState()=>new UsersScreenState();
  
}

class UsersScreenState extends State<UsersScreen> {
  
   Future<List> getData() async{
    String token = await LoginState().getToken();
    String newStr = token.substring(1, token.length-1);
    final response= await http.get('https://bdfbfa40.ngrok.io/api/users',headers:{
       'Accept': 'application/json',
       'Authorization': 'Bearer $newStr',   
       });
      print(json.decode(response.body));
    return json.decode(response.body); 
 }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new FutureBuilder<List>(
        future: fetchUsers(http.Client()),
        builder: (context, snapshot){
          if(snapshot.hasError){
            print(snapshot.error);
          }
          return snapshot.hasData? 
          UsersList(users:snapshot.data):
          Center(child: CircularProgressIndicator());
        }, 
      ) 
      );
    }
}

