import 'package:Hande/widgets/UsersList.dart';
import 'package:Hande/widgets/WeekEvent.dart';
import 'package:flutter/material.dart';

class Parametre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
      padding: EdgeInsets.only(top: 40.0),
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.close),
            title: Text('Paramètres',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,),textAlign: TextAlign.center),
            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context){
              return EventScreen();
              }));}
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Profils'),
            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context){
              return UsersScreen();
              }));}
          ),
          ListTile(
            leading: Icon(Icons.tab),
            title: Text('Emploi du temps'),
            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context){
              return EventScreen();
              }));}
          ),
          ListTile(
            leading: Icon(Icons.view_agenda),
            title: Text('Activités et événements'),
            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context){
              return EventScreen();
              }));}
          ),
          ListTile(
            leading: Icon(Icons.format_list_numbered),
            title: Text('Règles de vie commune'),
            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context){
              return EventScreen();
              }));}
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: Text('Devoirs et Examen'),
            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context){
              return EventScreen();
              }));}
          ),
          ListTile(
            leading: Icon(Icons.mood),
            title: Text('Humeur du jour'),
            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context){
              return EventScreen();
              }));}
          ),
          ListTile(
            leading: Icon(Icons.format_quote),
            title: Text('Proverbes et citations'),
            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context){
              return EventScreen();
              }));}
          ),
          ListTile(
            leading: Icon(Icons.lightbulb),
            title: Text('Devinettes'),
            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context){
              return EventScreen();
              }));}
          ),
          ListTile(
            leading: Icon(Icons.today),
            title: Text('Mot du jour'),
            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context){
              return EventScreen();
              }));}
          ),
          ListTile(
            leading: Icon(Icons.local_hospital),
            title: Text('Carnet de santé'),
            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context){
              return EventScreen();
              }));}
          ),
        ],
      ),
    );
  }
}