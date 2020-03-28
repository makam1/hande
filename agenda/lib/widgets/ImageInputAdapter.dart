import 'dart:io';
import 'package:image/image.dart' as image;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ImageInputAdapter extends StatefulWidget{
  @override
  State createState()=> new ImageInputAdapterState();

}

class ImageInputAdapterState extends State<ImageInputAdapter> with SingleTickerProviderStateMixin{


  @override
  void initState(){
    super.initState();
  }
  pp() async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // Step 2: Loading image by using the path that we saved earlier. We can create a file using path 
      //         and can use FileImage provider for loading image from file.
       CircleAvatar(
                backgroundImage: FileImage(File(prefs.getString('test_image')),            
                ));
   }

  @override
  Widget widgetize() {
    pp();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return pp();
  }
}