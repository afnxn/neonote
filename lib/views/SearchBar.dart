import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Note.dart';
import '../services/SearchService.dart';
import 'TextEditor.dart';

class SearchBar extends StatefulWidget {
  final SharedPreferences preferences;

  SearchBar({required this.preferences});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late SearchService _noteService;
  late List<Note> _allNotes;
  List<Note> _searchResults = [];

  final _newNoteController = TextEditingController();
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _noteService = SearchService(widget.preferences);
    _allNotes = _noteService.getAllNotes();
    _searchResults = List.from(_allNotes);
  }

  @override
  void dispose() {
    _newNoteController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _saveNewNote() {
    if (_newNoteController.text.isNotEmpty) {
      final newNote = Note(
        text: _newNoteController.text.trim(),
        tags: [],
      );
      _noteService.save(newNote);
      setState(() {
        _allNotes.add(newNote);
        _searchResults.add(newNote);
      });
      _newNoteController.clear();
    }
  }

  void _searchNotes(String query) {
    if (query.isNotEmpty) {
      setState(() {
        _searchResults = _allNotes
            .where((note) =>
            note.text.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {

        _searchResults = List.from(_allNotes);

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _newNoteController,
              decoration: InputDecoration(
                hintText: 'Add a new note',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _saveNewNote,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search notes',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => _searchNotes(_searchController.text),
                ),
              ),
              onChanged: _searchNotes,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final note = _searchResults[index];

                return ListTile(
                  title: Text(note.text),

                  subtitle: Text(note.tags.join(', ')),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TextEditor(note: note),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
