
import 'package:brew/mapping.dart';
import 'package:brew/scratchcard.dart';
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
      theme: new ThemeData.light(),
       home: MappingPage(auth:Auth(),),
      
    );
  }
}