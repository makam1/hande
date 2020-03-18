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
import 'package:Hande/widgets/ImageInputAdapter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}): super(key:key);
  final String title;

  @override
  _HomeState createState()=> new _HomeState();
}

class _HomeState extends State<Home>{
  File imageFile;
 File newImage ;


  @override
  void initState() {
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
        child: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('image'),
              _decideImageWidget(),
              RaisedButton(onPressed: (){
                _showDialog(context);
              },
              child:Text('Choisir image')
              )
            ],)
        ),
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

  pp() async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // Step 2: Loading image by using the path that we saved earlier. We can create a file using path 
      //         and can use FileImage provider for loading image from file.
      CircleAvatar(
                backgroundImage: FileImage(File(prefs.getString('test_image')),            
                ));
   }

  Widget _decideImageWidget(){
    if(imageFile==null){
      return Text('photo');
    }else{
      return pp();
    }
  }

  _openGallerie(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    
    final directory = await getApplicationDocumentsDirectory();
     final path=directory.path;
      // SharedPreferences prefs = await SharedPreferences.getInstance();

      // prefs.setString('test_image', newImage.path);


    // var bytes = await rootBundle.load("assets/user_profil");

    // final img = pic.decodeImage(imageFile.readAsBytesSync());
    // //final thumbnail = pic.copyResize(img);
    
    // File('assets/user_profil/${DateTime.now().toUtc().toIso8601String()}.png')
    //   ..writeAsBytesSync(pic.encodePng(img));

    this.setState((){
          imageFile = image;
    });
        Navigator.of(context).pop();
    newImage = await image.copy('assets/');

  }



   _openCamera(BuildContext context) async{
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    this.setState((){  
      imageFile = image;
    });
    GallerySaver.saveImage(imageFile.path);
    Navigator.of(context).pop();

    }  


  Future <void> _showDialog(BuildContext context) {
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


