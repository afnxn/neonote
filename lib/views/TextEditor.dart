import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/extensions.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:path/path.dart';
import 'package:tuple/tuple.dart';

import '../models/Post.dart';
import '../services/RemoteService.dart';


class TextEditor extends StatefulWidget {
  const TextEditor({Key? key}) :super(key: key);

  @override
  _TextEditorState createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor>{

  QuillController _controller = QuillController.basic();
  ScrollController _scrollController = ScrollController();
  FocusNode _focusNode = FocusNode();
  Post? posts;
  List<String> myList = [];
  var isLoaded=false;
  TextEditingController _textEditingController = TextEditingController();
  String _getText() {
    return _controller.document.toPlainText();
  }
  void  _getdata() async{
    String userInput = _controller.document.toPlainText();
    print(userInput);
    posts= await RemoteService().getPosts(userInput);
    posts!.data.mainLemmas.removeWhere((element) => element.score<10);
    myList=posts!.data.mainLemmas.map((user) => user.value).toList();
    if (posts != null){
      setState(() {
        isLoaded=true;

      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Editor'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _getdata,
          ),
        ],
      ),
      body: Column(
        children:[

          if(isLoaded!=false)
          SizedBox(
            height: 56, // adjust this value as needed
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:posts!.data.mainLemmas.length,
                itemBuilder: (context,index){

                  return Container(
                    // width: 100,
                    child: Card(
                      child: Center(
                        child: Text(myList[index]),
                      ),
                    )
                  );
                },
              ),

          ),

          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Container(
                padding: EdgeInsets.all(16),
                child: QuillEditor(
                  controller: _controller,
                  focusNode: _focusNode,
                  scrollController: _scrollController,
                  expands: false,
                  padding: EdgeInsets.zero, scrollable: false, autoFocus: true, readOnly: false,
                 
                ),
              ),
            ),
          ),
          SizedBox(
            height: 110, // adjust this value as needed
            child: QuillToolbar.basic(controller: _controller),
          ),
        ],
      ),
    );
      
  }

}