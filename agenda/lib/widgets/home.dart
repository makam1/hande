import 'dart:io';


import 'package:flutter/services.dart';
import 'package:image/image.dart' as pic;
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:Hande/models/login.dart';
import 'package:date_format/date_format.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:Hande/widgets/UsersList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' ;


class Home extends StatefulWidget {
  Home({Key key, this.title}): super(key:key);
  final String title;

  @override
  _HomeState createState()=> new _HomeState();
}

class _HomeState extends State<Home>{
  File imageFile;
  File newImage ; 


String en='green';
static Color col= Colors.green;

// static int tes=0xff443a49;
// static Color pickerColor = new Color(tes);
String testingColorString = col.toString();
Color newColor = new Color(col.value);

String color=col.toString();

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
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
      body:Container(
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
                  Padding(padding: const EdgeInsets.only(left:100.0)),
                  Container(
                    color: Colors.pink,
                    child: Text('-------',style:TextStyle(color:Colors.pink))
                  )              
                ]
              ),
              Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left:100.0)),
                  Container(
                    color: Colors.yellow,
                    child: Text('-------',style:TextStyle(color:Colors.yellow))
                  )               
                ]
              ),
               Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left:30.0)),
                  Text("Mar",style:TextStyle(
                    fontSize:15,
                    fontWeight: FontWeight.bold
                  )),   
                ]
              ),
              Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left:300.0)),
                  Container(
                    width: 30,
                    height: 15,
                    color: newColor
                    //child: Text('-------',style:TextStyle(color:Colors.red))
                  )              
                ]
              ),
              Padding(padding: const EdgeInsets.only(top:10.0)),
               Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left:30.0)),
                  Text("Mer",style:TextStyle(
                    fontSize:15,
                    fontWeight: FontWeight.bold
                  )),
                  
                ]
              ),
              Padding(padding: const EdgeInsets.only(top:40.0)),
               Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left:30.0)),
                  Text("Jeu",style:TextStyle(
                    fontSize:15,
                    fontWeight: FontWeight.bold
                  )),
                  
                ]
              ),
              Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left:200.0)),
                  Container(
                    color: Colors.pink,
                    child: Text('-------',style:TextStyle(color:Colors.pink))
                  )              
                ]
              ),
               Padding(padding: const EdgeInsets.only(top:10.0)),
               Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left:30.0)),
                  Text("Ven",style:TextStyle(
                    fontSize:15,
                    fontWeight: FontWeight.bold
                  )), 
                ]
              ),
              Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left:100.0)),
                  Container(
                    color: Colors.yellow,
                    child: Text('-------',style:TextStyle(color:Colors.yellow))
                  )              
                ]
              ),
              Padding(padding: const EdgeInsets.only(top:10.0)),
               Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left:30.0)),
                  Text("Sam",style:TextStyle(
                    fontSize:15,
                    fontWeight: FontWeight.bold
                  )),
                  
                ]
              ),
              Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left:200.0)),
                  Container(
                    color: Colors.red,
                    child: Text('-------',style:TextStyle(color:Colors.red))
                  )              
                ]
              ),
              Padding(padding: const EdgeInsets.only(top:10.0)),
               Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left:30.0)),
                  Text("Dim",style:TextStyle(
                    fontSize:15,
                    fontWeight: FontWeight.bold
                  )),
                ]
              ), 
               Padding(padding: const EdgeInsets.only(top:40.0)),
               Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left:70.0)),
                  Text("Tâches du jour",style:TextStyle(
                    fontSize:25,
                    fontWeight: FontWeight.bold,
                    color:Colors.pink
                  )),
                ]
              ), 
               Padding(padding: const EdgeInsets.only(top:10.0)),
               Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left:30.0)),
                  Text("Exemple",style:TextStyle(
                    fontSize:15,
                    fontWeight: FontWeight.bold
                  )),
                ]
              ),       
            ],)
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        child: Icon(
          Icons.add,
          size: 26.0,
        ),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return Login();
          }));
        },
      ),
                );
        }


 
}


