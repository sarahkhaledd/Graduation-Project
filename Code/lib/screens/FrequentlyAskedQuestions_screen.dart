import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class FrequentlyAskedQuestions extends StatelessWidget {
  const FrequentlyAskedQuestions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionReference _faq =
        FirebaseFirestore.instance.collection('FAQ');
    return Scaffold(
      backgroundColor: const Color(0xfff7fffb),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xffff66624)),
        title: Text(
          "  Frequently Questions",
          style: TextStyle(
            color: Color(0xffff66624),
            fontSize: 22,
          ),
        ),
        backgroundColor: Color(0xfff7fffb),
      ),
      body: StreamBuilder(
          stream: _faq.snapshots(),
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
                          leading: Icon(
                            Icons.question_answer_rounded,
                            color: Color(0xffff66624),
                            size: 40,
                          ),
                          title: Text(documentSnapshot['Question'],
                              style: const TextStyle(
                                color: Color(0xff408c5d),
                              )),
                          subtitle: Flexible(
                            child: ReadMoreText(
                              documentSnapshot['Answer'].toString(),
                              trimLines: 2,
                              colorClickableText: Color(0xffff66624),
                              trimMode: TrimMode.Line,
                              trimCollapsedText: 'Expand',
                              trimExpandedText: 'Collapse',
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return const Center(
              child: null,
            );
          }),
    );
  }
}
