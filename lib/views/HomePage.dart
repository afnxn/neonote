import 'package:flutter/material.dart';
import 'package:neonote/models/Post.dart';
import 'package:neonote/services/RemoteService.dart';
import 'dart:convert';

import 'package:neonote/views/APITest.dart';
import 'package:neonote/views/SearchBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'TextEditor.dart';
class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage>{
  int index=0;
  final screens=[APITest(),FutureBuilder<SharedPreferences>(
    future: SharedPreferences.getInstance(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return SearchBar(preferences: snapshot.data!);
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
  ),TextEditor()];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBar(
        height: 60,
        selectedIndex: index,
        onDestinationSelected: (index)=>setState(() {
          this.index=index;
        }),
        destinations: const<Widget>[
          NavigationDestination(icon: Icon(Icons.email), label: ''),
          NavigationDestination(icon: Icon(Icons.search), label: ''),
          NavigationDestination(icon: Icon(Icons.library_add), label: '')
        ]
      ),

    );
  }
}