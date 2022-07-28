import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import '../User Screens/Event_screen.dart';

class SearchEvent_screen extends StatelessWidget {
  final String OrganizationName;

  SearchEvent_screen({Key? key, required this.OrganizationName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionReference _user = FirebaseFirestore.instance.collection('Events');

    return Scaffold(
      backgroundColor: const Color(0xfff7fffb),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xffff66624)),
        title: Text(
          OrganizationName + " Posts",
          style: TextStyle(
            color: Color(0xffff66624),
            fontSize: 22,
          ),
        ),
        backgroundColor: Color(0xfff7fffb),
      ),
      body: StreamBuilder(
          stream: _user.orderBy("TimePosted", descending: true).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];
                  Timestamp myTimeStamp = Timestamp.fromDate(DateTime.now());
                  DateTime dateTime1 = DateTime.parse(
                      documentSnapshot["TimePosted"].toDate().toString());
                  DateTime dateTime2 =
                  DateTime.parse(myTimeStamp.toDate().toString());
                  if(OrganizationName == documentSnapshot['OrganizationName']) {
                    return Card(
                    margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    child: Material(
                      type: MaterialType.button,
                      borderRadius: BorderRadius.circular(10),
                      color: (dateTime2.difference(dateTime1).inMinutes < 5 &&
                          dateTime2.difference(dateTime1).inHours == 0)
                          ? Color(0xffffA879)
                          : Color(0xffebebeb),
                      shadowColor: Color(0xffff66624),
                      elevation: 5,
                      child: InkWell(
                        splashColor: Color(0xffebebeb),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Event_screen(
                                  OrganizationLogo:
                                  documentSnapshot['Logo'],
                                  EventDescription:
                                  documentSnapshot['EventDescription'],
                                  OrganizationName:
                                  documentSnapshot['OrganizationName'],
                                  EventCode: documentSnapshot['Event Code'],
                                )),
                          );
                        },
                        child: ListTile(
                          leading: ClipRRect(
                            child: Image.network(documentSnapshot['Logo'],
                                height:
                                MediaQuery.of(context).size.height * 0.1,
                                width:
                                MediaQuery.of(context).size.height * 0.1),
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          title: Text(documentSnapshot['OrganizationName'],
                              style: const TextStyle(
                                color: Color(0xff408c5d),
                              )),
                          subtitle: Flexible(
                            child: ReadMoreText(
                              documentSnapshot['EventDescription'].toString(),
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
                          trailing: Text(
                            documentSnapshot['Event Code'],
                            style: TextStyle(
                              color: Color(0xffff66624),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                  }
                  return const Center(
                    child: null,
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
