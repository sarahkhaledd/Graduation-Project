import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RetriveData extends StatelessWidget {
  String? documentId;

  @override
  Widget build(BuildContext context) {
    final CollectionReference _user =
        FirebaseFirestore.instance.collection('Events');
    return Scaffold(
      body: StreamBuilder(
          stream: _user.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(documentSnapshot['OrganizationName']),
                      subtitle:
                          Text(documentSnapshot['EventDescription'].toString()),
                    ),
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
