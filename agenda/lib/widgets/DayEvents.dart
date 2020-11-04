import 'dart:convert';

import 'package:Hande/widgets/home.dart';
import 'package:Hande/widgets/register.dart';
import 'package:flutter/material.dart';
import 'package:Hande/models/users.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class DayList extends StatelessWidget{
final List list;

  DayList({Key key,this.list}):super(key:key);

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
      itemCount: list.length,
      itemBuilder:(context,index ){
         String tache=list[index]['libelle'];
         String desc=list[index]['descriptif'];
          String heure = list[index]['heuredebut'].substring(11, list[index]['heuredebut'].length-9);
      return GestureDetector(
         child: Container(
           padding: EdgeInsets.all(10.0),
         //  color: index % 2==0? Colors.redAccent:Colors.yellowAccent,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               
                new Text('$tache: $desc à $heure',style:TextStyle(fontWeight: FontWeight.bold,fontSize:16.0)),
            ],
          ), 
        ),
        onTap:(){
          setId(list[index]['id']);
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return Register();
          }));
        }
      );
    });
    
  }
}

class DayListScreen extends StatefulWidget{
  @override  State createState()=>new DayListScreenState();
}
class DayListScreenState extends State<DayListScreen> {
  Future<List> getData() async{
    String token = await LoginState().getToken();
    String newStr = token.substring(1, token.length-1);
    final response= await http.get('https://5b7a400119b2.ngrok.io/api/evenement/today',headers:{
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
          DayList(list:snapshot.data):
          Center(child: CircularProgressIndicator());
        }, 
      ) 
      );
    }
}

