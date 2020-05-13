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
import 'package:Hande/widgets/UsersList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' ;


class Home extends StatefulWidget {
  Home({Key key, this.title}): super(key:key);
  final String title;

  @override
  _HomeState createState()=> new _HomeState();
}

class _HomeState extends State<Home>{
  File imageFile;
  File newImage ; 

 static getday(int j,int m,int a)  {
    int day;
    int codejour= j;
    int codemois;
    if(m==1 || m==10){
      codemois=0;
    }else if(m==2 || m==3 || m==11){
      codemois=3;
    }else if(m==4 || m==7){
      codemois=6;
    }else if(m==5){
      codemois=1;
    }else if(m==6){
      codemois=4;
    }else if(m==8){
      codemois=2;
    }else{
      codemois=5;
    } 
    double bis=a/4;    
    int biss=bis.toInt();
    int codeannee=(a+biss);
    int somme=codejour+codemois+codeannee+6;
    day=somme%7;
    print(day);
    return day;
  }

String en='green';
static Color col= Colors.green;
int day=getday(12,3,20);

// static int tes=0xff443a49;
// static Color pickerColor = new Color(tes);
String testingColorString = col.toString();
Color newColor = new Color(col.value);

String color=col.toString();

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
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
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(padding: const EdgeInsets.only(top:20.0)),
              Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left:30.0)),
                  Text("Lun",style:TextStyle(
                    fontSize:15,
                    fontWeight: FontWeight.bold
                  )),
                  Padding(padding: const EdgeInsets.only(left:50.0)),
                  Text('Matin',style:TextStyle(
                    fontSize:10)),
                  Padding(padding: const EdgeInsets.only(left:50.0)),
                  Text('Après-midi',style:TextStyle(
                    fontSize:10)),
                  Padding(padding: const EdgeInsets.only(left:50.0)),
                  Text('Soir',style:TextStyle(
                    fontSize:10)),                 
                ]
              ),
              Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left:100.0)),
                  Container(
                    color: Colors.pink,
                    child: Text('-------',style:TextStyle(color:Colors.pink))
                  )              
                ]
              ),
              Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left:100.0)),
                  Container(
                    color: Colors.yellow,
                    child: Text('-------',style:TextStyle(color:Colors.yellow))
                  )               
                ]
              ),
               Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left:30.0)),
                  Text("Mar",style:TextStyle(
                    fontSize:15,
                    fontWeight: FontWeight.bold
                  )),   
                ]
              ),
              Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left:300.0)),
                  Container(
                    width: 30,
                    height: 15,
                    color: newColor
                    //child: Text('-------',style:TextStyle(color:Colors.red))
                  )              
                ]
              ),
              Padding(padding: const EdgeInsets.only(top:10.0)),
               Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left:30.0)),
                  Text("Mer",style:TextStyle(
                    fontSize:15,
                    fontWeight: FontWeight.bold
                  )),
                  
                ]
              ),
              Padding(padding: const EdgeInsets.only(top:40.0)),
               Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left:30.0)),
                  Text("Jeu",style:TextStyle(
                    fontSize:15,
                    fontWeight: FontWeight.bold
                  )),
                  
                ]
              ),
              Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left:200.0)),
                  Container(
                    color: Colors.pink,
                    child: Text('-------',style:TextStyle(color:Colors.pink))
                  )              
                ]
              ),
               Padding(padding: const EdgeInsets.only(top:10.0)),
               Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left:30.0)),
                  Text("Ven",style:TextStyle(
                    fontSize:15,
                    fontWeight: FontWeight.bold
                  )), 
                ]
              ),
              Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left:100.0)),
                  Container(
                    color: Colors.yellow,
                    child: Text('-------',style:TextStyle(color:Colors.yellow))
                  )              
                ]
              ),
              Padding(padding: const EdgeInsets.only(top:10.0)),
               Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left:30.0)),
                  Text("Sam",style:TextStyle(
                    fontSize:15,
                    fontWeight: FontWeight.bold
                  )),
                  
                ]
              ),
              Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left:200.0)),
                  Container(
                    color: Colors.red,
                    child: Text('-------',style:TextStyle(color:Colors.red))
                  )              
                ]
              ),
              Padding(padding: const EdgeInsets.only(top:10.0)),
               Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left:30.0)),
                  Text("Dim",style:TextStyle(
                    fontSize:15,
                    fontWeight: FontWeight.bold
                  )),
                ]
              ), 
               Padding(padding: const EdgeInsets.only(top:40.0)),
               Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left:70.0)),
                  Text("Tâches du jour",style:TextStyle(
                    fontSize:25,
                    fontWeight: FontWeight.bold,
                    color:Colors.pink
                  )),
                ]
              ), 
               Padding(padding: const EdgeInsets.only(top:10.0)),
               Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left:30.0)),
                  Text("$day",style:TextStyle(
                    fontSize:15,
                    fontWeight: FontWeight.bold
                  )),
                ]
              ),       
            ],)
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


  // Widget _decideImageWidget(){
  //   if(imageFile==null){
  //     return Text('photo');
  //   }else{
  //     return Image.file(imageFile,width: 100,height: 100);
  //   }
  // }

  // _openGallerie(BuildContext context) async {
  //   var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  //    this.setState((){
  //         imageFile = image;
  //   });
 
    
  //   Navigator.of(context).pop();
  //   final directory = await getApplicationDocumentsDirectory();
  //   final path="assets/xml";
  //   String xmlString =  await rootBundle.loadString('assets');
    
  //   final fileName = basename(image.path);
    
  //   // final File localImage = await image.copy('$path/$fileName');
  //   // SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // prefs.setString('test_image', localImage.path);
  //   final img = pic.decodeImage(image.readAsBytesSync());
  //   print('chemin: $xmlString');
    
  //   //final thumbnail = pic.copyResize(img);
  //   File('$path/$fileName')
  //       ..writeAsBytesSync(pic.encodePng(img));
   
  //   //newImage = await image.copy('assets/');
    
  // }




  //  _openCamera(BuildContext context) async{
  //   var image = await ImagePicker.pickImage(source: ImageSource.camera);

  //   this.setState((){  
  //     imageFile = image;
  //   });
  //   GallerySaver.saveImage(imageFile.path);
  //   Navigator.of(context).pop();

  //   }  


  // Future <void> _showDialog(BuildContext context) {
  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: new Text("Photo"),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               GestureDetector( 
  //                 child: Text('Gallerie'),
  //                 onTap: (){
  //                   _openGallerie(context);
  //                 },
  //               ),
  //               Padding(padding: EdgeInsets.all(5.0)),
  //               GestureDetector(
  //                 child: Text('Camera'),
  //                 onTap: (){
  //                   _openCamera(context);
  //                 },
  //               )
  //             ],
  //           ),)

  //       );
  //     },
  //   );
  // }
}


