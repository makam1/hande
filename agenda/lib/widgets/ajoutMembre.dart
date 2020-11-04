
import 'dart:io';

import 'package:Hande/widgets/home.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:date_format/date_format.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:Hande/widgets/home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';


class AjoutMembre extends StatefulWidget{
  @override
  State createState()=> new AjoutMembreState();
}

class AjoutMembreState extends State<AjoutMembre> with SingleTickerProviderStateMixin{

  @override
  void initState(){
    super.initState();
    role = '';

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

  Future<List> ajout() async {
    String token = await LoginState().getToken();
    String newStr = token.substring(1, token.length-1);


    i = await getImageFileFromAssets('calendar.png');

    Map<String, String> headers = { "Authorization": "Bearer $newStr",};

    var uri = Uri.parse("https://5b7a400119b2.ngrok.io/api/ajout");
      var request = new http.MultipartRequest("POST", uri);
        request.headers.addAll(headers);
        if(imageFile==null){
        var multipartFile = new http.MultipartFile.fromBytes(
        'imageFile',
        i.readAsBytesSync(),
        contentType: MediaType('image', 'jpeg'),
        filename: username.text+'.jpg'
      );
       request.files.add(multipartFile);
        }else{
        var multipartFile = new http.MultipartFile.fromBytes(
        'imageFile',
        imageFile.readAsBytesSync(),
        contentType: MediaType('image', 'jpeg'),
        filename: username.text+'.jpg'
      );
      request.files.add(multipartFile);

        }

    request.fields['username'] = username.text;
    request.fields['password'] = password.text;
    request.fields['role'] = role;
    request.fields['email'] = email.text;
    request.fields['datenaissance'] = formatDate(choix, [yyyy, '-', mm, '-', dd]);
    request.fields['etablissement'] = etablissement.text;
    request.fields['niveauscolaire'] = niveauscolaire.text;
    request.fields['couleur'] = color;


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
  File i;
  File imageFile;
  DateTime choix=new DateTime.now();

   Widget _decideImageWidget(){
    if(imageFile==null){
      return Container(
        width: 120.0,
                    height: 120.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new AssetImage("assets/calendar.png")
                            )
                        )
      );
    }else{
      return new CircleAvatar(backgroundImage: new FileImage(imageFile), radius: 75.0,);
    }
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
              new Row(
                    children: <Widget>[
                      new Padding(
                padding: const EdgeInsets.only(left:100.0),

                ),
                          _decideImageWidget(),
                          new Padding(
                padding: const EdgeInsets.only(top: 70.0),

                ),
                    IconButton (
                    icon:new Icon(
                      Icons.add_a_photo,
                    ),
                    onPressed: (()=> _imageDialog(context))
                    
                    ),
                        
                  ],
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
                    labelText:age==null?"Date de naissance":formatDate(choix, [dd, '-', mm, '-', yyyy]), 
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
                  hintText: 'Profil',
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
                      "display": "Parent",
                      "value": "ROLE_PARENT",
                    },
                    {
                      "display": "Enfant",
                      "value": "ROLE_ENFANT",
                    },
                    {
                      "display": "Autre",
                      "value": "ROLE_AUTRE",
                    },
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
                    "Envoyer",
                  ),
                  onPressed:()  {
                    if(role=='ROLE_ENFANT'){
                      _enfantInformations(context);
                    }else{
                      ajout();
                    }
                  },
                  splashColor: Colors.black,
                  ) 
                  ,

                  
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
   void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("HANDE"),
          content: new Text("Demandez à votre tuteur de vous inscrire"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Fermer"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  } 
   _openGallerie(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    this.setState((){
      imageFile = image;
    });
    Navigator.of(context).pop();
  }


   _openCamera(BuildContext context) async{
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    this.setState((){  
      imageFile = image;
    });

    GallerySaver.saveImage(imageFile.path);
    
    Navigator.of(context).pop();

    }  


  Future <void> _imageDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Photo"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector( 
                  child: Text('Gallerie'),
                  onTap: (){
                    _openGallerie(context);
                  },
                ),
                Padding(padding: EdgeInsets.all(5.0)),
                GestureDetector(
                  child: Text('Camera'),
                  onTap: (){
                    _openCamera(context);
                  },
                )
              ],
            ),)

        );
      },
    );
  }
  Future <void> _enfantInformations(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Renseigner les champs suivants"),
          content: SingleChildScrollView(
             child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              new Form(
                child: new Container(
                  padding: const EdgeInsets.only(left:50.0,right: 50.0),
                  child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:<Widget> [
                  new TextFormField(
                  controller: etablissement,
                  decoration: new InputDecoration(
                    labelText:"Etablissement", 
                  ),
                  keyboardType: TextInputType.text,
                  ),
                  new TextFormField(
                    controller: niveauscolaire,
                  decoration: new InputDecoration(
                    labelText:"Niveau scolaire", 
                  ),
                   keyboardType: TextInputType.text,
                  ),
                  new MaterialButton(
                  color: Colors.grey,
                  textColor: Colors.black,
                  child: new Text(
                    "suivant",
                  ),
                  onPressed:()  {
                   _colorPicker(context);
                  },
                  splashColor: Colors.black,
                  
                  ),
                  
                  ])
              )
            )],
          ),
            )
            

        );
      },
    );
  }
  Future <void> _colorPicker(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Renseigner les champs suivants"),
          content: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
            child: Row(
            children: <Widget>[
              Expanded(
                 child: new ColorPicker(
                    color: Colors.blue,
                    onChanged: (value){color=value.toString(); }
                  ),),
                  Expanded(
                  child: new MaterialButton(
                  color: Colors.white,
                  textColor: Colors.black,
                  child: new Text(
                    "Envoyer",
                  ),
                  onPressed:()  {
                   ajout();
                  },
                  splashColor: Colors.black,
                
        ))])));
        }
        );}
}


