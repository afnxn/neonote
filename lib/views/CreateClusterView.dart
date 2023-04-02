import 'package:flutter/material.dart';
import 'package:neonote/models/Cluster.dart';
import 'package:neonote/models/Note.dart';
import 'package:neonote/services/ClusterService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/ClusterService.dart';
import '../services/SearchService.dart';
import 'ClusterNotesView.dart';
// import 'package:neonote/views/ClusterNotesView.dart';

class CreateClusterView extends StatefulWidget {

  final SharedPreferences preferences;

  const CreateClusterView({required this.preferences});

  @override
  _CreateClusterViewState createState() => _CreateClusterViewState();
}

class _CreateClusterViewState extends State<CreateClusterView> {
  late ClusterService _clusterService;
  late AllClusters getClustersService;
  late List<Cluster> _allclusters;
  List<Cluster> _searchResults = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //
  late String _clusterName;
  late List<String> _reqTags;
  late List<String> _optTags;
  @override
  void initState() {
    super.initState();

    _clusterService=ClusterService();
    // _refresh();
    getClustersService = AllClusters(widget.preferences);
    _allclusters = getClustersService.getAllclusters();
    _searchResults = List.from(_allclusters);
    print(_searchResults.length);

    setState(() { // <-- add this line
      _searchResults = List.from(_allclusters);
      print(_searchResults.length);
    });
    // _allclusters.sort((a, b) =>(a.isPinned == b.isPinned) ? 0 : (b.isPinned ? 1 : -1));
  }


  @override
  void dispose() {
    // _newNoteController.dispose();
    // _searchController.dispose();
    super.dispose();
  }

  void _goto(newClust){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClusterNotesView(
          cluster: newClust,
        ),
      ),
    );
  }
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    AllClusters clustService = AllClusters(preferences);
    List<Cluster> clusters=clustService.getAllclusters();


      SearchService noteService = SearchService(preferences);
      List<Note> notes=noteService.getAllNotes();

    Cluster newClust = ClusterService.addCluster(clusters:clusters , clusterName: _clusterName, reqTags: _reqTags, optTags: _optTags);
      _clusterService.addNotesToMatchingClusters(notes,clusters);
      print(_reqTags);
      // Cluster newCluster = Cluster.createClusterWithUniqueID(_clusterName, _reqTags, _optTags, clusters: []);
      // widget.clusterService.addNotesToMatchingClusters(notes)
      // widget.clusterService.addCluster(newCluster);

      setState(() {
        _allclusters.add(newClust);
        _searchResults = List.from(_allclusters);
        print(_searchResults.length);
      });
      // Navigate to ClusterNotesView passing the new cluster object
     _goto(newClust);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Cluster'),
      ),
      body: Column(children:[SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Cluster Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name for the cluster.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _clusterName = value!;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Required Tags (comma-separated)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter at least one required tag.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _reqTags = value!.split(',').map((tag) => tag.trim()).toList();
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Optional Tags (comma-separated)'),
                onSaved: (value) {
                  if (value == null || value.isEmpty) {
                    _optTags = [];
                  } else {
                    _optTags = value.split(',').map((tag) => tag.trim()).toList();
                  }
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Create Cluster'),
              ),
            ],

          ),
        ),
      ),
      ],),
    );
  }
}



// import 'note.dart';
// import 'cluster.dart';
// import 'cluster_service.dart';
//
// void main() {
//   List<Note> notes = [
//     Note.createNoteWithUniqueID('This is a note with tags tag1 and tag2', ['tag1', 'tag2']),
//     Note.createNoteWithUniqueID('This is a note with tags tag2 and tag3', ['tag2', 'tag3']),
//     Note.createNoteWithUniqueID('This is a note with tags tag3 and tag4', ['tag3', 'tag4']),
//   ];
//
//   List<Cluster> clusters = [
//     Cluster.createClusterWithUniqueID('Cluster 1', ['tag1'], []),
//     Cluster.createClusterWithUniqueID('Cluster 2', ['tag2'], ['tag3']),
//   ];
//
//   ClusterService clusterService = ClusterService(clusters: clusters);
//
//   // Add all notes to matching clusters
//   clusterService.addNotesToMatchingClusters(notes);
//
//   // Print clusters and their notes
//   for (Cluster cluster in clusterService.clusters) {
//     print(cluster.clusterName);
//     for (Note note in cluster.notes) {
//       print('- ' + note.text);
//     }
//
