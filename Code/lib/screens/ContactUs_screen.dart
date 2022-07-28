import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionReference _contactus =
        FirebaseFirestore.instance.collection('ContactUs');
    return Scaffold(
        backgroundColor: const Color(0xfff7fffb),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "  Contact Us",
            style: TextStyle(
              color: Color(0xffff66624),
              fontSize: 22,
            ),
          ),
          backgroundColor: Color(0xfff7fffb),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Color(0xff408c5d),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.person,
                color: Color(0xff408c5d),
              ),
            ),
          ],
        ),
        body: StreamBuilder(
            stream: _contactus.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      color: const Color(0xffebebeb),
                      shadowColor: Color(0xffff66624),
                      elevation: 5,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            title: Text(documentSnapshot['email'],
                                style: const TextStyle(
                                  color: Color(0xff408c5d),
                                )),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
