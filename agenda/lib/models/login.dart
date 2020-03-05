
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

import 'package:flutter/material.dart';
//import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;
import 'dart:async';


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

  String msg='';
  Future<List> _login() async {
    final response= await http.post("https://cacc4532.ngrok.io/api/login",headers:{
      'Accept': 'application/json',
    }, body: {
      "username":username.text,
      "password":password.text,
    });
    if(response.statusCode==200){

      var datauser= json.decode(response.body);
      var token=datauser.values.toString();
      print(token);
      final parts = token.split('.');
      final payload = parts[1];
      final String decoded = B64urlEncRfc7515.decodeUtf8(payload);
      print(decoded);

      addTokenToSF() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);
      }
      getTokenFromSF() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
       
        String tokenValue = prefs.getString('token');
        return tokenValue;
      }
    }
    else{
      print("erreur :${response.body}");
    }
  }

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
                new Container(
                  padding: const EdgeInsets.only(left:80.0,top: 10.0),
                  child: new Text(
                    "Mot de passe oublié?",
                    style: TextStyle(color:Colors.red),

                  ),  
                ),
                new Padding(
                padding: const EdgeInsets.only(left:85.0,top: 10.0),

                ),
                new MaterialButton(
                  color: Colors.grey,
                  textColor: Colors.black,
                  child: new Text(
                    "Connexion",
                  ),
                  onPressed:()  {
                   _login();
                  },
                  splashColor: Colors.black,
                  ),
                  Text(msg),

                  new Container(
                  padding: const EdgeInsets.only(top:10.0),
                  child: new Text(
                    "Pas de compte? S'inscrire",
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
}

