import 'dart:convert';

class Note {
  String text;
  List<String> tags;
   bool isPinned;

  Note({required this.text, required this.tags,this.isPinned = false});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      text: json['text'],
      tags: List<String>.from(json['tags']),
      isPinned: json['isPinned'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'tags': tags,
      'isPinned': isPinned,
    };
  }
  String toJsonString() {
    return jsonEncode(toJson());
  }
}
