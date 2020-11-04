import 'dart:convert';

import 'package:Hande/widgets/home.dart';
import 'package:Hande/widgets/register.dart';
import 'package:flutter/material.dart';
import 'package:Hande/models/users.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class ChildrenList extends StatelessWidget{
final List users;

  ChildrenList({Key key,this.users}):super(key:key);

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
        String color=users[index]['enfant']['couleur'].substring(6,users[index]['enfant']['couleur'].length-1);
         int c=int.parse(color);
         Color pickerColor = new Color(c);
        return GestureDetector(
         child: Container(
           padding: EdgeInsets.all(10.0),
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
                            )
                        )
                ),
                Padding(padding: const EdgeInsets.only(left:100.0,top:5.0)),
                Container(
                      width: 50,
                      height: 15,
                      color:
                      pickerColor,
                    )
                
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
    }
    );
    
  }
}

class ChildrenScreen extends StatefulWidget{
  @override  State createState()=>new ChildrenScreenState();
}
class ChildrenScreenState extends State<ChildrenScreen> {
  Future<List> getChildren() async{
    String token = await LoginState().getToken();
    String newStr = token.substring(1, token.length-1);
    final response= await http.get('https://5b7a400119b2.ngrok.io/api/evenement/liste/enfants',headers:{
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
          ChildrenList(users:snapshot.data):
          Center(child: CircularProgressIndicator());
        }, 
      ),
      );
    }
  }

