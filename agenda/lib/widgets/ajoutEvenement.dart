
import 'dart:io';
import 'package:Hande/widgets/home.dart';
import 'package:async/async.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:date_format/date_format.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:Hande/models/login.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';


class AjoutEvenement extends StatefulWidget{
  @override
  State createState()=> new AjoutEvenementState();
  
}

class AjoutEvenementState extends State<AjoutEvenement>{
 

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
  TextEditingController etablissement= new TextEditingController();
  TextEditingController niveauscolaire= new TextEditingController();
  String role;
  String color; 
  int enfant; 

  Future<List> ajout() async {
    String token = await LoginState().getToken();
    String newStr = token.substring(1, token.length-1);
    Map<String, String> headers = { "Authorization": "Bearer $newStr",};

    var uri = Uri.parse("https://feff372b.ngrok.io/api/evenement");
      var request = new http.MultipartRequest("POST", uri);
        request.headers.addAll(headers);

    request.fields['libelle'] = username.text;
    request.fields['descriptif'] = password.text;
    request.fields['datedebut'] = role;
    request.fields['heuredebut'] = email.text;
    request.fields['heurefin'] = formatDate(choix, [yyyy, '-', mm, '-', dd]);
    request.fields['statut'] = etablissement.text;
    request.fields['enfant'] = niveauscolaire.text;
    request.fields['frequence'] = color;
    var response = await request.send();
    final respStr = await response.stream.bytesToString();

    if (response.statusCode == "200") {
      print(response);
    }
    Navigator.push(context, MaterialPageRoute(builder: (context){
                    return Home();
                    }));
    print(respStr);

  }
Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('assets/$path');

  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
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
          Container(
            color: Colors.white,
            child: CustomPaint(
              painter: CurvePainter(),
            )),
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
                  DropDownFormField(
                  hintText: 'Repetion',
                  value: role,
                  onSaved: (value) {
                    setState(() {
                      role = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      role = value;
                    });
                  },
                  dataSource: [
                    {
                      "display": "Jamais",
                      "value": "jamais",
                    },
                    {
                      "display": "Journalier",
                      "value": "journalier",
                    },
                    {
                      "display": "Hebdomadaire",
                      "value": "hebdomadaire",
                    },
                    {
                      "display": "Mensuel",
                      "value": "mensuel",
                    },
                    {
                      "display": "Annuel",
                      "value": "annuel",
                    }
                  ],
                  textField: 'display',
                  valueField: 'value',
                ),
                new Padding(
                padding: const EdgeInsets.only(left:85.0,top: 10.0),

                ),       
                new Padding(
                padding: const EdgeInsets.only(left:85.0,top: 10.0),

                ),
                
                new MaterialButton(
                  color: Colors.grey,
                  textColor: Colors.black,
                  child: new Text(
                    "Ajouter",
                  ),
                  onPressed:()  {
                      ajout();
                  },
                  splashColor: Colors.black,
                  ) 
                  ])
              )
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