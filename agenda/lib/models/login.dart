
import 'dart:convert';
import 'package:Hande/widgets/WeekEvent.dart';
import 'package:Hande/widgets/ajoutEvenement.dart';
import 'package:Hande/widgets/ajoutMembre.dart';
import 'package:Hande/widgets/listeEnfants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/painting.dart';





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

  var token;

  String msg='';
  Future<List> _login() async {
    final response= await http.post("https://1b561e214a05.ngrok.io/api/login",headers:{
      'Accept': 'application/json',
    }, body: {
      "username":username.text,
      "password":password.text,
    });
    if(response.statusCode==200){
      var datauser= json.decode(response.body);
      token=datauser.values.toString();
      String decoded;
      print(token);
      final parts = token.split('.');
      final payload = parts[1];
      decoded = B64urlEncRfc7515.decodeUtf8(payload);
      print(decoded);
      setToken(token);
      getToken();
      int test=11%7;
      print(test);

      Navigator.push(context, MaterialPageRoute(builder: (context){
            return ListeEnfantsScreen();
          }));
            }
    else{
      print("erreur :${response.body}");
    }
  }
  Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', value);
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  Widget build(BuildContext context){
    
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
        color: Colors.white,
        child: CustomPaint(
          painter: CurvePainter(),
        )),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              
              //Home().createState().pp(),
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
            ),],
          )],
       ),
    );
  }
}
class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    
    var gradient = RadialGradient(
    center: const Alignment(0.7, -0.6), // near the top right
    radius: 0.2,
    colors: [
      const Color(0xFFFFFF00), // yellow sun
      const Color(0xFF0099FF), // blue sky
    ],
    stops: [0.4, 1.0],
  );
  // rect is the area we are painting over
  var paint = Paint();
    paint.color = Colors.orange[400];
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.875,
        size.width * 0.5, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9584,
        size.width * 1.0, size.height * 0.9167);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);


    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

