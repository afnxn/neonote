import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/Note.dart';

class NoteEditScreen extends StatefulWidget {
  @override
  _NoteEditScreenState createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();

  void _saveNote() {
    String note = _noteController.text;
    List<String> tags = _tagsController.text.split(',');
    Note newNote = Note(
      text: note,
      tags: tags,
    );
    Navigator.of(context).pop(newNote);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Note'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: 'Note',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _tagsController,
              decoration: InputDecoration(
                labelText: 'Tags (comma-separated)',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveNote,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
