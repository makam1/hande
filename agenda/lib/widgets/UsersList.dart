import 'dart:convert';

import 'package:Hande/widgets/WeekEvent.dart';
import 'package:Hande/widgets/home.dart';
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
      padding: EdgeInsets.only(top: 60.0),
         //  color: index % 2==0? Colors.redAccent:Colors.yellowAccent,
           child: Column(
             
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               
               Row(
                 children: [
                new Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: 
                            new NetworkImage("https://40232c3dc018.ngrok.io/ASA2/public/images/users/$imageName?raw=true")
                            //AssetImage("assets/calendar.png")
                            )
                        )
                ),
                new Container(
                padding: EdgeInsets.only(left: 100.0),
               child: new Text(users[index]['username'],style:TextStyle(fontSize:18.0,fontWeight: FontWeight.bold,),textAlign: TextAlign.center),
                )],
          ), 
          ])),
        onTap:(){
          setId(users[index]['id']);
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return EventScreen();
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
    final response= await http.get('https://59a94914a712.ngrok.io/api/users',headers:{
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

