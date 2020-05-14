
import 'dart:io';
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
import 'package:Hande/models/login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image/image.dart' as pic;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'package:dropdown_formfield/dropdown_formfield.dart';



class AjoutEnfant extends StatefulWidget{
  @override
  State createState()=> new AjoutEnfantState();
}

class AjoutEnfantState extends State<AjoutEnfant> with SingleTickerProviderStateMixin{

  @override
  void initState(){
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}