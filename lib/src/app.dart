import 'package:flutter/material.dart';
import 'package:contact_service/src/pages/contact_page.dart';
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blue
      ),
      home: ContactPage(),
    );

  }
}