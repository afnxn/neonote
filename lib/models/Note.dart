import 'dart:convert';

class Note {
  String text;
  List<String> tags;

  Note({required this.text, required this.tags});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      text: json['text'],
      tags: List<String>.from(json['tags']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'tags': tags,
    };
  }
  String toJsonString() {
    return jsonEncode(toJson());
  }
}
