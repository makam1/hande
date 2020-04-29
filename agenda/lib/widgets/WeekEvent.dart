import 'dart:convert';

import 'package:Hande/models/login.dart';
import 'package:Hande/widgets/register.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:Hande/models/users.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';



class EventList extends StatelessWidget{
final List events;

  EventList({Key key,this.events}):super(key:key);

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
      itemCount: events.length,
      itemBuilder:(context,index ){
        String heure = events[index]['heuredebut'].substring(11, events[index]['heuredebut'].length-9);
        // DateTime hour = DateTime.parse(heure);
        // DateTime midi = DateTime.parse('12:00');


        //TimeOfDay _startTime = events[index]['heuredebut'](hour:int.parse(s.split(":")[0]),minute: int.parse(s.split(":")[1]));
        //print(_startTime);
      return GestureDetector(
         child: 
        //  Container(
        //    padding: EdgeInsets.all(10.0),
        //  //  color: index % 2==0? Colors.redAccent:Colors.yellowAccent,
        //    child: Column(
        //      mainAxisAlignment: MainAxisAlignment.spaceBetween,r(( ))
        //      crossAxisAlignment: CrossAxisAlignment.start,
        //      children: <Widget>[
        //         new Container(
        //             width: 50.0,
        //             height: 50.0,
        //             decoration: new BoxDecoration(
        //                 shape: BoxShape.circle,
        //                 image: new DecorationImage(
        //                     fit: BoxFit.fill,
        //                     image: 
        //                     new 
        //                     AssetImage("assets/calendar.png")
        //                     )
        //                 )
        //         ),
        //         new Text(events[index]['libelle'],style:TextStyle(fontWeight: FontWeight.bold,fontSize:16.0)),
        //         new Text(events[index]['statut'],style:TextStyle(fontSize:16.0)),
        //     ],
        //   ), 
        // ),
        // onTap:(){
        //   setId(events[index]['id']);
        //   Navigator.push(context, MaterialPageRoute(builder: (context){
        //     return Register();
        //  }
        Container(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(padding: const EdgeInsets.only(top:20.0)),
              Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left:30.0)),
                  Text("Lun",style:TextStyle(
                    fontSize:15,
                    fontWeight: FontWeight.bold
                  )),
                  Padding(padding: const EdgeInsets.only(left:50.0)),
                  Text('Matin',style:TextStyle(
                    fontSize:10)),
                  Padding(padding: const EdgeInsets.only(left:50.0)),
                  Text('Après-midi',style:TextStyle(
                    fontSize:10)),
                  Padding(padding: const EdgeInsets.only(left:50.0)),
                  Text('Soir',style:TextStyle(
                    fontSize:10)),                 
                ]
              ),
              Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left:120.0)),
                 // if(hour.isBefore(midi))
                   Text(events[index]['libelle'],style:TextStyle(
                    fontSize:10,
                    fontWeight: FontWeight.bold
                  )
                  ),
                  //else 
                  Text(events[index]['statut'],style:TextStyle(
                    fontSize:10,
                    fontWeight: FontWeight.bold
                  )
                  ),              
                ]
              ),
                            
            ],)
        ),
          );
      });
      }
      }

class EventScreen extends StatefulWidget{
  @override  State createState()=>new EventScreenState();
  
}

class EventScreenState extends State<EventScreen> {
  
  Future<List> getEvents() async{
    String token = await LoginState().getToken();
    String newStr = token.substring(1, token.length-1);
    final response= await http.get('https://b5eca8da.ngrok.io/api/evenement/liste',headers:{
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
        future: getEvents(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            print(snapshot.error);
          }
          return snapshot.hasData? 
          EventList(events:snapshot.data):
          Center(child: CircularProgressIndicator());
        }, 
      ) 
      );
    }
}

