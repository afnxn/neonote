import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/Cluster.dart';
import '../models/Note.dart';
class ClusterService {


  static Future<List<Cluster>> loadClustrers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> clustersJson = prefs.getStringList('clusters') ?? [];
    List<Cluster> clusters = [];
    for (String clusterJson in clustersJson) {
      clusters.add(Cluster.fromJson(json.decode(clusterJson)));
    }
    return clusters;
  }

  static Future<void> saveClustrers(List<Cluster> clusters) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> clustersJson = [];
    for (Cluster cluster in clusters) {
      clustersJson.add(json.encode(cluster.toJson()));
    }
    await prefs.setStringList('clusters', clustersJson);
  }

  void addNoteToMatchingClusters(Note note, List<Cluster> clusters) {
    for (Cluster cluster in clusters) {
      if (_noteMatchesCluster(note, cluster)) {
        cluster.notes.add(note);
      }
    }
  }

  void addNotesToMatchingClusters(List<Note> notes, List<Cluster> clusters) {
    for (Note note in notes) {
      addNoteToMatchingClusters(note,clusters);
    }
  }

  bool _noteMatchesCluster(Note note, Cluster cluster) {
    // Check if the note contains all the required tags of the cluster
    if (!note.tags.toSet().containsAll(cluster.reqTags.toSet())) {
      print('y');
      if (cluster.optTags.isNotEmpty && !note.tags.toSet().intersection(cluster.optTags.toSet()).isNotEmpty) {
        print('x');
        return false;
      }
      if(!cluster.optTags.isNotEmpty){
        return false;
      }
      // else{return false;}
      // else{return true;}
    }

    // Check if the note contains any of the optional tags of the cluster

    print('z');
    return true;
  }
  static Cluster addCluster({
    required List<Cluster> clusters,
    required String clusterName,
    required List<String> reqTags,
    required List<String> optTags,
  }) {
    Cluster cluster = Cluster.createClusterWithUniqueID(clusterName, reqTags,  optTags, clusters: clusters);
    // print(note.noteID);
    clusters.add(cluster);
    saveClustrers(clusters);
    return cluster;
  }

  // Cluster getCLuster({required List<Cluster> clusters,
  //   required String clusterName}){
  //   for (Cluster cluster in clusters){
  //     if (cluster.clusterName==clusterName){
  //       return cluster;
  //     }
  //   }
  // }
  List<Note> getNotesInCluster(Cluster cluster,List<Cluster> clusters ) {
    List<Note> notes = [];
    for (Cluster clu in clusters) {
      if(clu==cluster){
        notes=cluster.notes;
      }
    }
    return notes;
  }
}

class AllClusters{
  final SharedPreferences _preferences;
  AllClusters(this._preferences);
  List<Cluster> getAllclusters() {
    // [{"text":"hi my name is afnan","tags":["afnan"]}, {"text":"hello hi hi","tags":["hi","hi"]}
    // _preferences.clear();
    List<String> clustersStrings = _preferences.getStringList('clusters') ?? [];
    // print(noteStrings);
    List<Cluster> clusters = [];
    for (String clustersJson in clustersStrings) {
      clusters.add(Cluster.fromJson(json.decode(clustersJson)));
    }
    return clusters;
  }


}
