import 'dart:convert';
import 'dart:ffi';

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

    getday(int j,int m,int a)  {
    int day;
    int codejour= j;
    int codemois;
    if(m==1 || m==10){
      codemois=0;
    }else if(m==2 || m==3 || m==11){
      codemois=3;
    }else if(m==4 || m==7){
      codemois=6;
    }else if(m==5){
      codemois=1;
    }else if(m==6){
      codemois=4;
    }else if(m==8){
      codemois=2;
    }else{
      codemois=5;
    } 
    double bis=a/4;   
    int biss=bis.toInt();
    int codeannee=(a+biss);
    int somme=codejour+codemois+codeannee+6;
    day=somme%7;
    return day;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: 
      new ListView(
        children: <Widget>[
          Row(
            children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left:100.0)),
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
          ListTile(
            title: Text('Lun'),
            ),
          new Container(    
            child:new ListView.builder(
              shrinkWrap: true,
              itemCount: events.length,
              itemBuilder:(context,index ){
                String heure = events[index]['heuredebut'].substring(11, events[index]['heuredebut'].length-12);
                String jour = events[index]['datedebut'].substring(8, events[index]['datedebut'].length-15);
                String mois = events[index]['datedebut'].substring(5, events[index]['datedebut'].length-18);
                String annee = events[index]['datedebut'].substring(2,events[index]['datedebut'].length-21);
                int j=int.parse(jour);
                int m=int.parse(mois);
                int a=int.parse(annee);
                int day=getday(j, m, a);
                int h =int.parse(heure); 
                return GestureDetector(
                  child: Container(
                    child:Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            if(h<=12 && h>=6)
                            Padding(padding: const EdgeInsets.only(left:120.0))
                            else if(h>12 && h<= 20)
                            Padding(padding: const EdgeInsets.only(left:200.0))
                            else
                            Padding(padding: const EdgeInsets.only(left:280.0)),
                            if(day==1)
                            Container(
                              width: 30,
                              height: 15,
                              color: Colors.red,
                              //child: Text('-------',style:TextStyle(color:Colors.red))
                            ) 
                            ,            
                            ]),             
                        ],)
                    ),onTap:(){} ,
                    );
                })),
            ListTile(
              title: Text('Mar'),
            ),
            new Container(    
            child:new ListView.builder(
              shrinkWrap: true,
              itemCount: events.length,
              itemBuilder:(context,index ){
                String jour = events[index]['datedebut'].substring(8, events[index]['datedebut'].length-15);
                String mois = events[index]['datedebut'].substring(5, events[index]['datedebut'].length-18);
                String annee = events[index]['datedebut'].substring(2,events[index]['datedebut'].length-21);
                int j=int.parse(jour);
                int m=int.parse(mois);
                int a=int.parse(annee);
                int day=getday(j, m, a);
                return GestureDetector(
                  child: Container(
                    child:Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(padding: const EdgeInsets.only(left:120.0)),
                            if(day==2)
                            Text(events[index]['groupe']['nomGroupe'],style:TextStyle(
                              fontSize:10,
                              fontWeight: FontWeight.bold
                            ))
                            ,            
                            ]),             
                        ],)
                    ));
                })),
            ListTile(
              title: Text('Mer'),
            ),
            new Container(    
            child:new ListView.builder(
              shrinkWrap: true,
              itemCount: events.length,
              itemBuilder:(context,index ){
                String jour = events[index]['datedebut'].substring(8, events[index]['datedebut'].length-15);
                String mois = events[index]['datedebut'].substring(5, events[index]['datedebut'].length-18);
                String annee = events[index]['datedebut'].substring(2,events[index]['datedebut'].length-21);
                int j=int.parse(jour);
                int m=int.parse(mois);
                int a=int.parse(annee);
                int day=getday(j, m, a);
                return GestureDetector(
                  child: Container(
                    child:Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(padding: const EdgeInsets.only(left:120.0)),
                            if(day==3)
                            Text(events[index]['libelle'],style:TextStyle(
                              fontSize:10,
                              fontWeight: FontWeight.bold
                            ))
                            ,            
                            ]),             
                        ],)
                    ));
                })),
            ListTile(
              title: Text('Jeu'),
            ),
            new Container(    
            child:new ListView.builder(
              shrinkWrap: true,
              itemCount: events.length,
              itemBuilder:(context,index ){
                String heure = events[index]['heuredebut'].substring(11, events[index]['heuredebut'].length-12);
                int h =int.parse(heure); 
                String jour = events[index]['datedebut'].substring(8, events[index]['datedebut'].length-15);
                String mois = events[index]['datedebut'].substring(5, events[index]['datedebut'].length-18);
                String annee = events[index]['datedebut'].substring(2,events[index]['datedebut'].length-21);
                int j=int.parse(jour);
                int m=int.parse(mois);
                int a=int.parse(annee);
                int day=getday(j, m, a);
                return GestureDetector(
                  child: Container(
                    child:Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                             if(h<=12 && h>=6)
                            Padding(padding: const EdgeInsets.only(left:120.0))
                            else if(h>12 && h<= 20)
                            Padding(padding: const EdgeInsets.only(left:170.0))
                            else
                            Padding(padding: const EdgeInsets.only(left:200.0)),
                            if(day==4)
                            Text(events[index]['libelle'],style:TextStyle(
                              fontSize:10,
                              fontWeight: FontWeight.bold
                            )),
                                        
                            ]),             
                        ],)
                    ));
                })),
            ListTile(
              title: Text('Ven'),
            ),
            new Container(    
            child:new ListView.builder(
              shrinkWrap: true,
              itemCount: events.length,
              itemBuilder:(context,index ){
                String jour = events[index]['datedebut'].substring(8, events[index]['datedebut'].length-15);
                String mois = events[index]['datedebut'].substring(5, events[index]['datedebut'].length-18);
                String annee = events[index]['datedebut'].substring(2,events[index]['datedebut'].length-21);
                int j=int.parse(jour);
                int m=int.parse(mois);
                int a=int.parse(annee);
                int day=getday(j, m, a);
                return GestureDetector(
                  child: Container(
                    child:Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(padding: const EdgeInsets.only(left:120.0)),
                            if(day==5)
                            Text(events[index]['libelle'],style:TextStyle(
                              fontSize:10,
                              fontWeight: FontWeight.bold
                            ))
                            ,            
                            ]),             
                        ],)
                    )
                    );
                })),
            ListTile(
              title: Text('Sam'),
            ),new Container(    
            child:new ListView.builder(
              shrinkWrap: true,
              itemCount: events.length,
              itemBuilder:(context,index ){
                String jour = events[index]['datedebut'].substring(8, events[index]['datedebut'].length-15);
                String mois = events[index]['datedebut'].substring(5, events[index]['datedebut'].length-18);
                String annee = events[index]['datedebut'].substring(2,events[index]['datedebut'].length-21);
                int j=int.parse(jour);
                int m=int.parse(mois);
                int a=int.parse(annee);
                int day=getday(j, m, a);
                return GestureDetector(
                  child: Container(
                    child:Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(padding: const EdgeInsets.only(left:120.0)),
                            if(day==6)
                            Text(events[index]['libelle'],style:TextStyle(
                              fontSize:10,
                              fontWeight: FontWeight.bold
                            ))
                            ,            
                            ]),             
                        ],)
                    ));
                })),
            ListTile(
              title: Text('Dim'),
            ),new Container(    
            child:new ListView.builder(
              shrinkWrap: true,
              itemCount: events.length,
              itemBuilder:(context,index ){
                String jour = events[index]['datedebut'].substring(8, events[index]['datedebut'].length-15);
                String mois = events[index]['datedebut'].substring(5, events[index]['datedebut'].length-18);
                String annee = events[index]['datedebut'].substring(2,events[index]['datedebut'].length-21);
                int j=int.parse(jour);
                int m=int.parse(mois);
                int a=int.parse(annee);
                int day=getday(j, m, a);
                return GestureDetector(
                  child: Container(
                    child:Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(padding: const EdgeInsets.only(left:120.0)),
                            if(day==0)
                            Text(events[index]['libelle'],style:TextStyle(
                              fontSize:10,
                              fontWeight: FontWeight.bold
                            ))
                            ,            
                            ]),             
                        ],)
                    ));
                })),
          ] )
    ,);
      }
    }

class EventScreen extends StatefulWidget{
  @override  State createState()=>new EventScreenState();
  
}

class EventScreenState extends State<EventScreen> {
  
  Future<List> getEvents() async{
    String token = await LoginState().getToken();
    String newStr = token.substring(1, token.length-1);
    final response= await http.get('https://5686c1d8.ngrok.io/api/evenement/events',headers:{
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