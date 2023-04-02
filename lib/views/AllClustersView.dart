// ListView.builder(
// itemCount: _searchResults.length,
// itemBuilder: (context, index) {
// final note = _searchResults[index];
// return ListTile(
// title: Text(note.clusterName),
// subtitle: Text(note.reqTags.join(', ')),
// onTap: () {
// _goto(note);
// // Handle tapping on a note in the list
// // For example, navigate to a view where the user can edit the note
// },
// );
// },
// ),

import 'package:flutter/material.dart';
import 'package:neonote/models/Cluster.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Note.dart';
import '../services/ClusterService.dart';

class AllClustersView extends StatefulWidget {
  final SharedPreferences preferences;

  const AllClustersView({required this.preferences});

  @override
  _AllClustersViewState createState() => _AllClustersViewState();
}
class _AllClustersViewState extends State<AllClustersView>{
  late AllClusters getClustersService;
  late List<Cluster> _allclusters;
  List<Cluster> _searchResults = [];

  @override
  void initState() {
    super.initState();

    // _clusterService=ClusterService();
    // _refresh();
    getClustersService = AllClusters(widget.preferences);
    _allclusters = getClustersService.getAllclusters();
    // print(_allclusters);
    _searchResults = List.from(_allclusters);
    print(_searchResults.length);
    // _allclusters.sort((a, b) =>(a.isPinned == b.isPinned) ? 0 : (b.isPinned ? 1 : -1));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clusters'),
      ),
      body: ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          final note = _searchResults[index];
          return ListTile(
            title: Text(note.clusterName),
            subtitle: Text(note.reqTags.join(', ')),
            onTap: () {
              // Handle tapping on a note in the list
              // For example, navigate to a view where the user can edit the note
            },
          );
        },
      ),
    );
  }
}
