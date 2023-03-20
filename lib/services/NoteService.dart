import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/Note.dart';

class NoteService {

  static Future<List<Note>> loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notesJson = prefs.getStringList('notes') ?? [];
    List<Note> notes = [];
    for (String noteJson in notesJson) {
      notes.add(Note.fromJson(json.decode(noteJson)));
    }
    return notes;
  }

  static Future<void> saveNotes(List<Note> notes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notesJson = [];
    for (Note note in notes) {
      notesJson.add(json.encode(note.toJson()));
    }
    await prefs.setStringList('notes', notesJson);
  }

  static void addNote({
    required List<Note> notes,
    required String text,
    required List<String> tags,
  }) {
    Note note = Note(text: text, tags: tags);
    notes.add(note);
    saveNotes(notes);
  }
  static void updateNote({
    required List<Note> notes,
    required String new_text,
    required List<String> new_tags,
    required String text,
    required List<String> tags,
  }) {
    // Note note_1 = Note(text: text, tags: tags);
    for (Note note in notes) {
      if(note.text == text){
        note.text=new_text;
        note.tags=new_tags;
      }
      // notesJson.add(json.encode(note.toJson()));
    }

    // notes.add(note);
    saveNotes(notes);
  }


}
