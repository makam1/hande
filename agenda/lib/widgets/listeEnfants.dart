import 'dart:convert';
import 'package:Hande/models/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';




class ListeEnfants extends StatelessWidget{
  final List children;

  ListeEnfants({Key key,this.children}):super(key:key);

  String enfant; 
  String  prenom;

  @override
  Widget build(BuildContext context) {
    
    return Container(
          child: Container(
             child:Column(
                children: <Widget>[
                  // Text(children[index]['username'])
                new Form(
                  child: new Container(
                  padding: const EdgeInsets.only(left:50.0,right: 50.0),
                  child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:<Widget> [
                  DropdownButton(items: children.map((item) {
                    prenom =item['username'];
                            return new DropdownMenuItem(
                              
                              child: new Text(item['username']==null?'':item['username']),
                              value: item['id'].toString()    
                            );
                          }).toList(),
                          onChanged: (newVal){
                            enfant = newVal;
                            (context as Element).markNeedsBuild();
                            print(enfant);
                            enfantId();
                            hint: Text(prenom);
                          }, 
                          hint: Text('Enfant'),
                          value: enfant,
                        ),
                  ]),
                    ))])));
                  }  


enfantId(){
  print(enfant);
  return enfant;
}

}

class ListeEnfantsScreen extends StatefulWidget{
  @override  State createState()=>new ListeEnfantsScreenState();
  
}

class ListeEnfantsScreenState extends State<ListeEnfantsScreen> {
  
 Future<List> getChildren() async{
    String token = await LoginState().getToken();
    String newStr = token.substring(1, token.length-1);
    final response= await http.get('https://08e727baf2f9.ngrok.io/api/evenement/liste/enfants',headers:{
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
        future: getChildren(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            print(snapshot.error);
          }
          return snapshot.hasData? 
          ListeEnfants(children:snapshot.data):
          Center(child: CircularProgressIndicator());
        }, 
      ),
      );
    }
  }
