import 'package:flutter/material.dart';



class Home extends StatefulWidget {
  Home({Key key, this.title}): super(key:key);
  final String title;

  @override
  _HomeState createState()=> new _HomeState();
}

class _HomeState extends State<Home>{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
     appBar: new AppBar(
       title: new Text(widget.title)
     ),
     body: new Center(),    
    );
  }
}
