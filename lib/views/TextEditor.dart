import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/extensions.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';

import '../models/Note.dart';
import '../models/Post.dart';
import '../services/NoteService.dart';
import '../services/RemoteService.dart';
import '../services/SearchService.dart';


class TextEditor extends StatefulWidget {
  final Note? note;
  final SharedPreferences? preferences;
  const TextEditor({Key? key, this.note, this.preferences}) :super(key: key);




  @override
  _TextEditorState createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor>{

  QuillController _controller = QuillController.basic();

  ScrollController _scrollController = ScrollController();

  FocusNode _focusNode = FocusNode();
  Note? _note;
  Post? posts;
  List<String> myList = [];

  var isLoaded=false;

  TextEditingController _textEditingController = TextEditingController();

  String _getText() {
    return _controller.document.toPlainText();
  }
  @override
  void initState() {
    super.initState();
    if(widget.note!=null){
      String? text = widget.note!.text;
      try {
        _controller = QuillController(

          document: Document()..insert(0, text),
          selection: const TextSelection.collapsed(offset: 0),
        );
      }
      catch(e){
        print(e);
      }
    }


  }
  void  _getdata() async{
    String userInput = _controller.document.toPlainText();
    // print(userInput);
    posts= await RemoteService().getPosts(userInput);
    posts!.data.mainLemmas.removeWhere((element) => element.score<10);
    myList=posts!.data.mainLemmas.map((user) => user.value).toList();
    if (posts != null){
      setState(() {
        isLoaded=true;

      });
    }
  }
  Future<void> _savedata() async {
    String text = _getText();
    // List<String> tags = widget.note!.tags; // add your logic to get tags
    // Note note = Note(
    //   text: text,
    //   tags: tags,
    // );

    SharedPreferences preferences = await SharedPreferences.getInstance();
    SearchService noteService = SearchService(preferences);
    List<Note> notes=noteService.getAllNotes();

    if(widget.note != null && widget.note?.text!=null){
      NoteService.updateNote(notes: notes, text:widget.note!.text , tags: widget.note!.tags, isPinned:widget.note!.isPinned!, new_text: text, new_tags: ['hi'],new_isPinned:widget.note!.isPinned!);
      // Navigator.of().pop();
    }
   else{
      NoteService.addNote(notes: notes, text: text, tags: ['afnan'],isPinned:widget.note!.isPinned!);
    }

  }

  Future<void> _deldata() async {
    String text = _getText();
    List<String> tags = widget.note!.tags; // add your logic to get tags
    Note note = Note(
      text: text,
      tags: tags,
    );

    SharedPreferences preferences = await SharedPreferences.getInstance();
    SearchService noteService = SearchService(preferences);
    List<Note> notes=noteService.getAllNotes();
    NoteService.deleteNote(notes: notes, text: widget.note!.text, tags: widget.note!.tags, isPinned:widget.note!.isPinned!);
    // NoteService.addNote(notes: notes, text: text, tags: ['afnan']);
    // NoteService.addNote(notes: notes, text:widget.note!.text , tags: widget.note!.tags);
    // if (widget.note != null) {
    //   _note!.text = _controller.document.toPlainText();
    //   _note!.tags = widget.note!.tags;
    //   SearchService(widget.preferences!).save(_note!);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Editor'),
        actions: [
          IconButton(
            icon: Icon(Icons.publish),
            onPressed: _getdata,
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed:() {
              _savedata();
              if(widget.note != null && widget.note?.text!=null){
                Navigator.of(context).pop();
              }
              },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _deldata();
              Navigator.of(context).pop();
            },
          )

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