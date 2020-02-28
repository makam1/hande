
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:date_format/date_format.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';


class Login extends StatefulWidget{
  @override
  State createState()=> new LoginState();
}

class LoginState extends State<Login> with SingleTickerProviderStateMixin{
  AnimationController _logoAnimationController;
  Animation<double>   _logoAnimation;


  @override
  void initState(){
    super.initState();
    _logoAnimationController= new AnimationController(
      vsync: this,
      duration: new Duration(milliseconds:2000)
      );
    _logoAnimation= new CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.bounceIn);
    _logoAnimation.addListener(()=>this.setState((){}));
    _logoAnimationController.forward();
  }

  TextEditingController username = new TextEditingController();
  TextEditingController password= new TextEditingController();
  TextEditingController nom= new TextEditingController();
  TextEditingController prenom= new TextEditingController();
  TextEditingController email= new TextEditingController();
  TextEditingController datenaissance= new TextEditingController();
  TextEditingController telephone= new TextEditingController();

  Future<List> _register() async {
    final response= await http.post(Uri.encodeFull("https://b0ae1adf.ngrok.io/api/login/inscription"),headers:{
      'Accept': 'application/json',
    }, body: {
      "username":username.text,
      "password":password.text,
      "email":email.text,
      "datenaissance":formatDate(choix, [yyyy, '-', mm, '-', dd])
    });
    
   // var datauser= json.decode(response.body);
        print(response.body);
    
  }
 double age;
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
              new Image(
                image: new AssetImage("assets/calendar.png"),
                height: _logoAnimation.value*99,
                
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
                    "error":formatDate(choix, [dd, '-', mm, '-', yyyy]), 
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

                ),
                new MaterialButton(
                  color: Colors.grey,
                  textColor: Colors.black,
                  child: new Text(
                    "Envoyer",
                  ),
                  onPressed:()  {
                   _register();
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