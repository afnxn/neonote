import 'dart:convert';
import 'dart:math';

class Note {
  String noteID;
  String text;
  List<String> tags;
  bool isPinned;

  Note({
    required this.noteID,
    required this.text,
    required this.tags,
    this.isPinned = false,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      noteID: json['noteID'],
      text: json['text'],
      tags: List<String>.from(json['tags']),
      isPinned: json['isPinned'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'noteID': noteID,
      'text': text,
      'tags': tags,
      'isPinned': isPinned,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  // Generate a unique 4-digit number for the noteID field
  static String _generateNoteID(List<Note> notes) {
    int maxAttempts = 1000;
    int attempts = 0;
    String noteID;
    bool isDuplicate;

    // Loop until a unique noteID is generated or maxAttempts is reached
    do {
      int randomInt = Random().nextInt(9000) + 1000; // Generate random 4-digit number
      noteID = randomInt.toString();

      // Check if the generated noteID already exists in the list of notes
      isDuplicate = notes.any((note) => note.noteID == noteID);

      attempts++;
    } while (isDuplicate && attempts < maxAttempts);

    if (isDuplicate) {
      throw Exception('Unable to generate a unique noteID after $maxAttempts attempts.');
    }

    return noteID;
  }

  // Create a new Note object with a unique noteID
  static Note createNoteWithUniqueID(String text, List<String> tags, {bool isPinned = false, required List<Note> notes}) {
    String noteID = _generateNoteID(notes);
    return Note(
      noteID: noteID,
      text: text,
      tags: tags,
      isPinned: isPinned,
    );
  }
}
