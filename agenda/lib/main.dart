
import 'dart:convert';
import 'dart:html';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:flutter/material.dart';
//import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hande',
      home:new Login(),
      theme:new  ThemeData(
        primaryColor: Colors.teal
      )
    );
  }
}

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
    final response= await http.post("https://cacc4532.ngrok.io/api/login/inscription",headers:{
      'Accept': 'application/json',
    }, body: {
      "username":username.text,
      "password":password.text,
    });
    
    var datauser= json.decode(response.body);
    var token=datauser.values.toString();
        print(token);
    final parts = token.split('.');
    final payload = parts[1];
    final String decoded = B64urlEncRfc7515.decodeUtf8(payload);
            print(decoded);
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

                new TextFormField(
                    controller: nom,
                  decoration: new InputDecoration(
                    labelText:"nom", 
                  ),
                  keyboardType: TextInputType.text,
                  ),

                  new TextFormField(
                    controller: prenom,
                  decoration: new InputDecoration(
                    labelText:"prenom", 
                  ),
                  keyboardType: TextInputType.text,
                  ),

                  new TextFormField(
                    controller: email,
                  decoration: new InputDecoration(
                    labelText:"email", 
                  ),
                  keyboardType: TextInputType.emailAddress,
                  ),

                  new TextFormField(
                    controller: datenaissance,
                  decoration: new InputDecoration(
                    labelText:"Date de naissance", 
                  ),
                   keyboardType: TextInputType.text,
                  ),

                  new TextFormField(
                    controller: telephone,
                  decoration: new InputDecoration(
                    labelText:"Telephone", 
                  ),
                  keyboardType: TextInputType.text,
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


/**class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('HANDE'),
    ),
    body: _buildSuggestions(),
  );
}
  Widget _buildSuggestions() {
  return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: /*1*/ (context, i) {
        if (i.isOdd) return Divider(); /*2*/

        final index = i ~/ 2; /*3*/
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10)); /*4*/
        }
        return _buildRow(_suggestions[index]);
      });
  }
  Widget _buildRow(WordPair pair) {
  return ListTile(
    title: Text(
      pair.asPascalCase,
      style: _biggerFont,
    ),
  );
  }
}
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}**/
