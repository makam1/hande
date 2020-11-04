import 'dart:convert';

import 'package:Hande/models/login.dart';
import 'package:Hande/widgets/WeekEvent.dart';
import 'package:Hande/widgets/register.dart';
import 'package:flutter/material.dart';
import 'package:Hande/models/users.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class EventDetail extends StatelessWidget{
final List list;

  EventDetail({Key key,this.list}):super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
  
 
}

class EventDetailScreen extends StatefulWidget{
  @override  State createState()=>new EventDetailScreenState();
}
class EventDetailScreenState extends State<EventDetailScreen> {
  
  String libelle;
  String descriptif;
  Future<String> lib() async{
    String lib = await EventList().getLib(); 
     setState(() {
       libelle=lib;
     });
     print(libelle);
    return libelle; 
  }
  Future<String> des() async{
    String des = await EventList().getdesc(); 
    setState(() {
       descriptif=des;
     });
     print(descriptif);
    return descriptif; 
  }
  
  @override
  Widget build(BuildContext context) {
    lib();
    des();
    print(libelle);
    return new Scaffold(
      body: AlertDialog(
          title: new Text('Evénement: $libelle'),
          content: new Text('Descriptif: $descriptif'),
          actions: <Widget>[
            new FlatButton(
              child : new Text("ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        )
    
      );
    }
}

