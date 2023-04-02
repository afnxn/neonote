import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Note.dart';
import '../services/GetTagsService.dart';
import '../services/NoteService.dart';
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


    // _refresh();
    _noteService = SearchService(widget.preferences);
    _allNotes = _noteService.getAllNotes();
    _searchResults = List.from(_allNotes);
    _searchResults.sort((a, b) =>(a.isPinned == b.isPinned) ? 0 : (b.isPinned ? 1 : -1));
  }


  @override
  void dispose() {
    _newNoteController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _saveNewNote() {
    if (_newNoteController.text.isNotEmpty) {
      final newNote = Note.createNoteWithUniqueID(
        _newNoteController.text.trim(),
         [], notes: _allNotes,
      );
      _noteService.save(newNote);
      setState(() {
        _allNotes.add(newNote);
        _searchResults.add(newNote);
      });
      _newNoteController.clear();
    }
  }
  Future<void> _updatePin(Note note, bool new_p) async {
    // String text = _getText();
    // List<String> tags = widget.note!.tags; // add your logic to get tags
    // Note note = Note(
    //   text: text,
    //   tags: tags,
    // );

    // List<String> list = lol.trimLeft().split(',');
    // print(list);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    SearchService noteService = SearchService(preferences);
    List<Note> notes=noteService.getAllNotes();

    // if(note != null && note?.text!=null){
      NoteService.updateNote(notes: notes, text:note!.text , tags: note!.tags, isPinned:note!.isPinned!, new_text:note!.text, new_tags: note!.tags,new_isPinned:new_p);
      // Navigator.of().pop();
  }
  void _searchNotes(String query) {
    // _refresh;
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
        _searchResults.sort((a, b) =>(a.isPinned == b.isPinned) ? 0 : (b.isPinned ? 1 : -1));

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
          //
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
                  trailing:GestureDetector(
                    onTap: () {
                      _updatePin(note, !note.isPinned);
                      setState(() {
                        note.isPinned = !note.isPinned;
                      });
                    },
                    child: note.isPinned
                        ? Icon(Icons.favorite, color: Colors.red)
                        : Icon(Icons.favorite),
                  ),
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
