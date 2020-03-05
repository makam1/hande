import 'package:flutter/material.dart';
import 'dart:async';
import 'package:Hande/models/login.dart';
import 'package:date_format/date_format.dart';


class Home extends StatefulWidget {
  Home({Key key, this.title}): super(key:key);
  final String title;

  @override
  _HomeState createState()=> new _HomeState();
}

class _HomeState extends State<Home>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  static DateTime date= new DateTime.now();
  String today =formatDate(new DateTime.now(), [dd, ' ',M, ' ', yyyy]);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
     appBar: new AppBar(
      
      title:new  Text(
        today,
        style: TextStyle(fontSize: 15.0,fontStyle:FontStyle.italic,color: Colors.grey ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
              Colors.red[500],
              Colors.yellow[300]
            ]))),         
      leading: GestureDetector(
          onTap: () { /* Write listener code here */ },
          child: Icon(
            Icons.home,  // add custom icons also
          ),
      ),
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
          Icons.notifications,
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
      body:login(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return Login();
          }));
        },
      ),
                );
        }
      
        login() {}    
}
