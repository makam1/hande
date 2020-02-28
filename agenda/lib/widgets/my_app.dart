import 'package:Hande/widgets/home.dart';
import 'package:flutter/material.dart';


class MyApp extends StatelessWidget{
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hande',
      home:new Home(title:'Hande'),
      theme:new  ThemeData(
        primaryColor: Colors.pink[100]
      )
    );
  }
}