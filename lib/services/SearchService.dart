import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/Note.dart';

class SearchService {
  final SharedPreferences _preferences;

  SearchService(this._preferences);

  List<Note> getAllNotes() {
    // [{"text":"hi my name is afnan","tags":["afnan"]}, {"text":"hello hi hi","tags":["hi","hi"]}
    List<String> noteStrings = _preferences.getStringList('notes') ?? [];
    print(noteStrings);
    List<Note> notes = [];
    for (String noteJson in noteStrings) {
      notes.add(Note.fromJson(json.decode(noteJson)));
    }
    return notes;
  }

  void save(Note note) {
    List<String> noteStrings = _preferences.getStringList('notes') ?? [];
    String noteString = '{"text":"${note.text}","tags":"${note.tags.join(',')}';
    noteStrings.add(noteString);
    _preferences.setStringList('notes', noteStrings);
  }
  //
  // void update(Note note) {
  //   List<String> noteStrings = _preferences.getStringList('notes') ?? [];
  //   int noteIndex = noteStrings.indexWhere((noteString) {
  //     return Note.fromJson(json.decode(noteString)).id == note.id;
  //   });
  //   if (noteIndex != -1) {
  //     noteStrings[noteIndex] = json.encode(note.toJson());
  //     _preferences.setStringList('notes', noteStrings);
  //   }
  // }

  List<Note> search(String query) {
    List<Note> allNotes = getAllNotes();
    List<Note> matchingNotes = [];

    for (Note note in allNotes) {
      if (note.text.toLowerCase().contains(query.toLowerCase())) {
        matchingNotes.add(note);
      }
    }

    return matchingNotes;
  }
}