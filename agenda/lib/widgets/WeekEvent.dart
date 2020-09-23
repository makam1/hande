import 'dart:convert';
import 'package:Hande/models/login.dart';
import 'package:Hande/widgets/ajoutEvenement.dart';
import 'package:flutter/material.dart';
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

  tableau(int n){
    return new Container( 
      child:ListView.builder(
        shrinkWrap: true,
        itemCount: events.length,
        itemBuilder:(context,index ){
          String heure = events[index]['heuredebut'].substring(11, events[index]['heuredebut'].length-12);
          String jour = events[index]['datedebut'].substring(8, events[index]['datedebut'].length-15);
          String mois = events[index]['datedebut'].substring(5, events[index]['datedebut'].length-18);
          String annee = events[index]['datedebut'].substring(2,events[index]['datedebut'].length-21);
          String color=events[index]['enfant']['couleur'].substring(6,events[index]['enfant']['couleur'].length-1);
          int c=int.parse(color);
          Color pickerColor = new Color(c);
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
                    if(day==n)
                    Container(
                      width: 30,
                      height: 15,
                      color: pickerColor,
                    ),]),             
                    ],)
                    ),onTap:(){} ,
                    );
                }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: 
      new ListView(
        children: <Widget>[
          Row(
            children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left:100.0,top:80.0)),
                  Text('Matin',style:TextStyle(
                    fontSize:10)),
                  Padding(padding: const EdgeInsets.only(left:50.0,top:80.0)),
                  Text('Après-midi',style:TextStyle(
                    fontSize:10)),
                  Padding(padding: const EdgeInsets.only(left:50.0,top:80.0)),
                  Text('Soir',style:TextStyle(
                    fontSize:10)),                 
                ]
          ),
          ListTile(
            title: Text('Lun'),
            ),
            tableau(1),
          ListTile(
            title: Text('Mar'),
            ),
            tableau(2),
          ListTile(
              title: Text('Mer'),
            ),
            tableau(3),
            ListTile(
              title: Text('Jeu'),
            ),
            tableau(4),
            ListTile(
              title: Text('Ven'),
            ),
            tableau(5),
            ListTile(
              title: Text('Sam'),
            ),
            tableau(6),
            ListTile(
              title: Text('Dim'),
            ),            
            tableau(7)
            ]));
      }
    }

class EventScreen extends StatefulWidget{
  @override  State createState()=>new EventScreenState();
  
}

class EventScreenState extends State<EventScreen> {
  
  Future<List> getEvents() async{
    String token = await LoginState().getToken();
    String newStr = token.substring(1, token.length-1);
    final response= await http.get('https://08e727baf2f9.ngrok.io/api/evenement/events',headers:{
       'Accept': 'application/json',
       'Authorization': 'Bearer $newStr',   
       });
    print(json.decode(response.body));
    return json.decode(response.body); 

  }
  Future<List> getChildren() async{
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
      title:new  Text(
        'HANDE',
        style: TextStyle(fontSize: 15.0,fontStyle:FontStyle.italic,),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
              Colors.red[500],
              Colors.yellow[400],
            ]))),         
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 20.0),
      child: GestureDetector(
        onTap: () {},
        child: Icon(
          Icons.search,
          size: 26.0,
        ),
      )
    ),
     
    Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: GestureDetector(
        onTap: () {},
        child: Icon(
            Icons.more_vert
        ),
            )
          ),
        ],
      
      ),
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
      ) ,floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        child: Icon(
          Icons.add,
          size: 26.0,
        ),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return AjoutEvenement();
          }));
        },
      ),
      );
    }

}
