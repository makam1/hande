
import 'dart:io';
import 'package:Hande/widgets/home.dart';
import 'package:async/async.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:date_format/date_format.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:Hande/widgets/home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image/image.dart' as pic;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';






class Profil extends StatefulWidget{
  @override
  State createState()=> new ProfilState();
}

class ProfilState extends State<Profil> with SingleTickerProviderStateMixin{



  @override
  void initState(){
    super.initState();
    
  }

  

  TextEditingController username = new TextEditingController();
  TextEditingController password= new TextEditingController();
  TextEditingController nom= new TextEditingController();
  TextEditingController prenom= new TextEditingController();
  TextEditingController email= new TextEditingController();
  TextEditingController datenaissance= new TextEditingController();
  TextEditingController telephone= new TextEditingController();


  Future<List> _editUser() async {
    String token = await LoginState().getToken();
    String newStr = token.substring(1, token.length-1);

    print(token);
    final response= await http.patch(Uri.encodeFull("https://dfbec76c.ngrok.io/api/32/profil"),headers:{
      'Accept': 'application/json',
      'Authorization': 'Bearer $newStr',

    }, body: {
      "username":username.text,
      "password":password.text,
      "email":email.text,
      "datenaissance":formatDate(choix, [yyyy, '-', mm, '-', dd]),

    });

      print(response.body); 

  }

 double age;
  File imageFile;

  DateTime choix=new DateTime.now();

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                    width: 75.0,
                    height: 75.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new AssetImage("assets/calendar.png"))
                        )
                    ),
              
              new Form(
                child: new Container(
                  padding: const EdgeInsets.only(left:50.0,right: 50.0),
                  child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:<Widget> [
                  new TextFormField(
                    controller: username,
                  decoration: new InputDecoration(
                    labelText:"nom d'utilisateur", 
                  ),
                  keyboardType: TextInputType.text,
                  ),
                  new TextFormField(
                    controller: password,
                  decoration: new InputDecoration(
                    labelText:"mot de passe", 
                  ),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                ),

                  new TextFormField(
                    controller: email,
                  decoration: new InputDecoration(
                    labelText:"E-mail", 
                  ),
                   keyboardType: TextInputType.emailAddress,
                  ),
                  new DateTimeField(
                    controller: datenaissance,
                  decoration: new InputDecoration(
                    labelText:age==null?"Date de naissance":age<=18?
                    "erreur":formatDate(choix, [dd, '-', mm, '-', yyyy]), 
                  icon:IconButton (
                    icon:new Icon(
                      Icons.date_range,
                    ),
                    onPressed: (()=> montrerPicker())
                    
                    ),
                  ),
                  initialValue: choix,
                  ),
                  new Padding(
                padding: const EdgeInsets.only(left:85.0,top: 10.0),

                )
               ,                  
                new Padding(
                padding: const EdgeInsets.only(left:85.0,top: 10.0),

                ),
                new MaterialButton(
                  color: Colors.grey,
                  textColor: Colors.black,
                  child: new Text(
                    "Envoyer",
                  ),
                  onPressed:()  {
                   _editUser();
                  },
                  splashColor: Colors.black,
                  ),

                  new Container(
                  padding: const EdgeInsets.only(top:10.0),
                  child: new Text(
                    "Un compte? Se connecter",
                    style: TextStyle(color:Colors.red),
                  ), 
                )
                  ])
              )
            )],
          )],
          
       ),
    );  
  }


  Future<Null> montrerPicker() async{
    DateTime date= await showDatePicker(
      context: context,
      initialDate: new DateTime.now(), 
      firstDate: new DateTime(1940), 
      lastDate: new DateTime.now(),
      initialDatePickerMode: DatePickerMode.year,  
       );
      if(date!=null){
        var difference= new DateTime.now().difference(date);
        var jours= difference.inDays;
        var ans= (jours/365);
        setState((){
          age =ans;
          choix=date;

        });
      }
  }
  } 
 