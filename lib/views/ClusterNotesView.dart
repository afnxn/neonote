import 'package:flutter/material.dart';
import 'package:neonote/models/Cluster.dart';

import '../models/Note.dart';

class ClusterNotesView extends StatelessWidget {
  final Cluster cluster;
  const ClusterNotesView({required this.cluster});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes in ${cluster.clusterName}'),
      ),
      body: ListView.builder(
        itemCount: cluster.notes.length,
        itemBuilder: (context, index) {
          final note = cluster.notes[index];
          return ListTile(
            title: Text(note.text),
            subtitle: Text(note.tags.join(', ')),
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
