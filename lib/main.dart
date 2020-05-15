
import 'package:brew/mapping.dart';
import 'package:flutter/material.dart';


import 'authentication.dart';
void main()
{
  runApp(new MyApp());

}

class MyApp extends StatelessWidget
 {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title:'blog App',
      theme: new ThemeData(primarySwatch: Colors.pink),
      home: MappingPage(auth:Auth(),),
    );
  }
}