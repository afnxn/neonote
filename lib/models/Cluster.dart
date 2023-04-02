import 'dart:convert';
import 'dart:math';
import 'Note.dart';

class Cluster {
  String clusterID;
  String clusterName;
  List<String> reqTags;
  List<String> optTags;
  List<Note> notes;

  Cluster({
    required this.clusterID,
    required this.clusterName,
    required this.reqTags,
    required this.optTags,
    required this.notes,
  });

  factory Cluster.fromJson(Map<String, dynamic> json) {
    return Cluster(
      clusterID: json['clusterID'],
      clusterName: json['clusterName'],
      reqTags: List<String>.from(json['reqTags']),
      optTags: List<String>.from(json['optTags']),
      notes: List<Note>.from(json['notes'].map((note) => Note.fromJson(note))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clusterID': clusterID,
      'clusterName': clusterName,
      'reqTags': reqTags,
      'optTags': optTags,
      'notes': notes.map((note) => note.toJson()).toList(),
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  // Generate a unique 3-digit number for the clusterID field
  static String _generateClusterID(List<Cluster> clusters) {
    int maxAttempts = 1000;
    int attempts = 0;
    String clusterID;
    bool isDuplicate;

    // Loop until a unique clusterID is generated or maxAttempts is reached
    do {
      int randomInt = Random().nextInt(900) + 100; // Generate random 3-digit number
      clusterID = randomInt.toString();

      // Check if the generated clusterID already exists in the list of clusters
      isDuplicate = clusters.any((cluster) => cluster.clusterID == clusterID);

      attempts++;
    } while (isDuplicate && attempts < maxAttempts);

    if (isDuplicate) {
      throw Exception('Unable to generate a unique clusterID after $maxAttempts attempts.');
    }

    return clusterID;
  }

  // Create a new Cluster object with a unique clusterID
  static Cluster createClusterWithUniqueID(String clusterName, List<String> reqTags, List<String> optTags, {required List<Cluster> clusters}) {
    String clusterID = _generateClusterID(clusters);
    return Cluster(
      clusterID: clusterID,
      clusterName: clusterName,
      reqTags: reqTags,
      optTags: optTags,
      notes: [],
    );
  }
}
