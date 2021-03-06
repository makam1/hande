
import 'dart:io';
import 'package:Hande/models/login.dart';
import 'package:Hande/widgets/UsersList.dart';
import 'package:Hande/widgets/home.dart';
import 'package:async/async.dart';
import 'package:flutter/services.dart';
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






class Register extends StatefulWidget{
  @override
  State createState()=> new RegisterState();
}

class RegisterState extends State<Register> with SingleTickerProviderStateMixin{
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
    String token = await LoginState().getToken();
    String newStr = token.substring(1, token.length-1);

    int id= await UsersList().getId();

    Map<String, String> headers = { "Authorization": "Bearer $newStr",};

    // string to uri
    var uri = Uri.parse("https://59a94914a712.ngrok.io/inscription");

    // new multipart request
    var request = new http.MultipartRequest("POST", uri);
        request.headers.addAll(headers);
    var multipartFile = new http.MultipartFile.fromBytes(
        'imageFile',
        imageFile.readAsBytesSync(),
        contentType: MediaType('image', 'jpeg'),
        filename: username.text+'.jpg'
      );


    // if you want more data in the request
    request.fields['username'] = username.text;
    request.fields['password'] = password.text;
    request.fields['role'] = 'ROLE_PARENT';
    request.fields['email'] = email.text;
    request.fields['datenaissance'] = formatDate(choix, [yyyy, '-', mm, '-', dd]);
    //add multipart form to request
    request.files.add(multipartFile);

    // send request
    var response = await request.send();
    final respStr = await response.stream.bytesToString();

    if (response.statusCode == "200") {
      print(response);
      Navigator.push(context, MaterialPageRoute(builder: (context){
            return Login();
          }));
    }
    print(respStr);

  }

 double age;
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
                            image: new AssetImage("assets/profil.png")
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
                    // width: 150.0,
                    // height: 150.0,
                    // decoration: new BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     image: new DecorationImage(
                    //         fit: BoxFit.fill,
                    //         image: new AssetImage("assets/calendar.png")
                    //         )
                    //     )
                    children: <Widget>[
                      new Padding(
                padding: const EdgeInsets.only(left:150.0),

                ),
                _decideImageWidget(),
                          new Padding(
                padding: const EdgeInsets.only(top: 70.0),

                ),
                    IconButton (
              padding: const EdgeInsets.only(top: 80.0),
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
                    labelText:age==null?"Date de naissance":age<18?
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

                ),
                // Row(
                //    mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: <Widget>[
                //           _decideImageWidget(),
                //           RaisedButton(onPressed: (){
                //           _imageDialog(context);
                //         },
                //         child:Text('Choisir image')
                //         )
                //   ],)
                                 
                new Padding(
                padding: const EdgeInsets.only(left:85.0,top: 10.0),

                ),
                new MaterialButton(
                  color: Colors.grey,
                  textColor: Colors.black,
                  child: new Text(
                    "Envoyer",
                  ),
                  onPressed:() {
                    if(age<18){
                        _showDialog() ;
                    }
                   _register();
                  },
                  splashColor: Colors.black,
                  ),

                  new Container(
                  padding: const EdgeInsets.only(top:10.0),
                  child: InkWell(
                    child: new Text(
                    "Un compte? Se connecter",
                    style: TextStyle(color:Colors.red),
                  ),
                    onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context){
                        return Login();
                      }));},
                )
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
   void _showDialog() {
    // flutter defined function

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

Future<File> getImageFileFromAssets(String path) async {
    
  final byteData = await rootBundle.load('assets/$path');

  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}
   _openGallerie(BuildContext context) async {

    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    
    this.setState((){
      if(image==null){   
      }
      imageFile = image;
    });
    if(imageFile==null){
     imageFile = await getImageFileFromAssets('/profil.png');
    }
    Navigator.of(context).pop();
  }


   _openCamera(BuildContext context) async{
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    this.setState((){  
      imageFile = image;
    });
    if(imageFile==null){
     imageFile = await getImageFileFromAssets('/profil.png');
    }
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


