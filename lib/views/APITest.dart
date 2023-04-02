import 'package:flutter/material.dart';
import 'dart:convert';
class APITest extends StatefulWidget {
  const APITest({Key? key}) :super(key: key);

  @override
  _APITestState createState() => _APITestState();
}
class _APITestState extends State<APITest>{

  // String tx='';
  // @override
  void initState(){
    super.initState();
    // getdata();
  }


  @override
  Widget build(BuildContext context){
      return Scaffold(
      appBar: AppBar(
          title:Text('Posts'),

      ),



      );
  }
}