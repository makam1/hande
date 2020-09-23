
import 'dart:io';
import 'package:Hande/widgets/home.dart';
import 'package:Hande/widgets/listeEnfants.dart';
import 'package:async/async.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:date_format/date_format.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:Hande/widgets/home.dart';
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
 TextEditingController libelle = new TextEditingController();
  TextEditingController descriptif= new TextEditingController();
  TextEditingController statut= new TextEditingController();
  
  String frequence;
  String color; 
  int enfant; 

  Future<List> ajout() async {
    String token = await LoginState().getToken();
    String newStr = token.substring(1, token.length-1);
    Map<String, String> headers = { "Authorization": "Bearer $newStr",};

    var uri = Uri.parse("https://08e727baf2f9.ngrok.io/api/evenement");
      var request = new http.MultipartRequest("POST", uri);
        request.headers.addAll(headers);

    request.fields['libelle'] = libelle.text;
    request.fields['descriptif'] = descriptif.text;
    request.fields['datedebut'] = formatDate(datedebut, [yyyy, '-', mm, '-', dd]);
    request.fields['heuredebut'] = heuredebut.toString().substring(10,heuredebut.toString().length-1);
    request.fields['heurefin'] = heurefin.toString().substring(10,heuredebut.toString().length-1);
    request.fields['statut'] = statut.text;
    request.fields['enfant'] = enfant.toString();
    request.fields['frequence'] = frequence;
    var response = await request.send();
    final respStr = await response.stream.bytesToString();

    if (response.statusCode == "200") {
      print(response);
    }
    Navigator.push(context, MaterialPageRoute(builder: (context){
                    return Login();
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
    DateTime datedebut=new DateTime.now();
  DateTime datefin=new DateTime.now();
    TimeOfDay heuredebut=TimeOfDay.now();
      TimeOfDay heurefin=TimeOfDay.now();



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
              padding: const EdgeInsets.only(left:50.0,right: 50.0,top:30.0),
              child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
                  children:<Widget> [
                  new TextFormField(
                    controller: libelle,
                  decoration: new InputDecoration(
                    labelText:"Libellé", 
                  ),
                  keyboardType: TextInputType.text,
                  ),
                  new TextFormField(
                    controller: descriptif,
                  decoration: new InputDecoration(
                    labelText:"Description", 
                  ),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                ),
                  new DateTimeField(
                  decoration: new InputDecoration(
                    labelText:datedebut==DateTime.now()?"Date":formatDate(datedebut, [dd, '-', mm, '-', yyyy]), 
                  icon:IconButton (
                    icon:new Icon(
                      Icons.date_range,
                    ),
                    onPressed: (()=> montrerPicker())
                    ),
                  ),
                  initialValue: datedebut,
                  ),
                  new DateTimeField(
                  decoration: new InputDecoration(
                    labelText:heuredebut==TimeOfDay.now()?"De":"${heuredebut.toString().substring(10,heuredebut.toString().length-1)}", 
                  icon:IconButton (
                    icon:new Icon(
                      Icons.date_range,
                    ),
                    onPressed: (()=> heured())
                    ),
                  ),
                  initialValue: choix,
                  ),
                  new DateTimeField(
                  decoration: new InputDecoration(
                    labelText:heurefin==TimeOfDay.now()?"A":"${heuredebut.toString().substring(10,heuredebut.toString().length-1)}", 
                  icon:IconButton (
                    icon:new Icon(
                      Icons.watch,
                    ),
                    onPressed: (()=> heuref())
                    ),
                  ),
                  ),
                  DropDownFormField(
                  hintText: 'Repetion',
                  value: frequence,
                  onSaved: (value) {
                    setState(() {
                      frequence = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      frequence = value;
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
                        new Row(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 50.0,
                        child: new ListeEnfantsScreen(),   
                      )),
                    ]),
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
      firstDate:new DateTime.now() , 
      initialDate: new DateTime.now(), 
      lastDate: new DateTime(2025),
      initialDatePickerMode: DatePickerMode.year,  
       );
      
        setState((){
          choix=date;
        });
  } 
  Future<Null> heured() async{
    TimeOfDay heure=await showTimePicker(
      context: context, initialTime: heuredebut, 
       );
        setState((){
          heuredebut=heure;
        });
  }
  Future<Null> heuref() async{
    TimeOfDay heure=await showTimePicker(
      context: context, initialTime: heuredebut, 
       );
        setState((){
          heurefin=heure;
        });
  }
}