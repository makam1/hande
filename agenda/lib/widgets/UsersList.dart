import 'dart:convert';

import 'package:Hande/models/login.dart';
import 'package:Hande/widgets/register.dart';
import 'package:flutter/material.dart';
import 'package:Hande/models/users.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class UsersList extends StatelessWidget{
final List users;

  UsersList({Key key,this.users}):super(key:key);

  Future<bool> setId(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt('id', value);
  }

  Future<int> getId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('id');
  }
  String imageName;
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder:(context,index ){
        imageName=users[index]['imageName'];
      return GestureDetector(
         child: Container(
           padding: EdgeInsets.all(10.0),
         //  color: index % 2==0? Colors.redAccent:Colors.yellowAccent,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
                new Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: 
                            new NetworkImage("https://github.com/makam1/ASA/blob/master/public/images/users/$imageName?raw=true")
                            //AssetImage("assets/calendar.png")
                            )
                        )
                ),
                new Text(users[index]['imageName'],style:TextStyle(fontWeight: FontWeight.bold,fontSize:16.0)),
                new Text(users[index]['nom'],style:TextStyle(fontSize:16.0)),
            ],
          ), 
        ),
        onTap:(){
          setId(users[index]['id']);
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return Register();
          }));
        }
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
    final response= await http.get('https://8ca5739f.ngrok.io/api/users',headers:{
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
        future: getData(),
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

