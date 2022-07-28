import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Notifications_screen extends StatelessWidget {
  const Notifications_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionReference _notifications = FirebaseFirestore.instance.collection('User Notifications');
    return Scaffold(
        backgroundColor: const Color(0xfff7fffb),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "  Notifications",
          style: TextStyle(
            color: Color(0xffff66624),
            fontSize: 22,
          ),
        ),
        backgroundColor: Color(0xfff7fffb),
        actions: <Widget>[
          IconButton(
            onPressed: () {Navigator.of(context)
                .pushNamed('SearchScreen');},
            icon: Icon(
              Icons.search,
              color: Color(0xff408c5d),
            ),
          ),
          IconButton(
            onPressed: () {Navigator.of(context)
                .pushNamed('UserProfile');},
            icon: Icon(
              Icons.person,
              color: Color(0xff408c5d),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: _notifications.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                  Timestamp myTimeStamp = Timestamp.fromDate(DateTime.now());
                  DateTime dateTime1 = DateTime.parse(documentSnapshot["Notification Date"].toDate().toString());
                  DateTime dateTime2 = DateTime.parse(myTimeStamp.toDate().toString());
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.12,
                    width: MediaQuery.of(context).size.width * 0.5,
                    margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    child: Material(
                      type: MaterialType.button,
                      borderRadius: BorderRadius.circular(50),
                      color: (dateTime2.difference(dateTime1).inMinutes < 5 && dateTime2.difference(dateTime1).inHours == 0)? Color(0xffffA879) : Color(0xffebebeb),
                      shadowColor: Color(0xffff66624),
                      elevation: 5,
                      child: InkWell(
                        splashColor: Color(0xffebebeb),
                        onTap: () {
                          Navigator.of(context).pushNamed('Home');
                        },
                            child: ListTile(
                              leading: ClipRRect(
                                child: Image.network(documentSnapshot['Logo'],
                                    height: MediaQuery.of(context).size.height * 0.1, width: MediaQuery.of(context).size.height * 0.1),
                                borderRadius: BorderRadius.all(Radius.circular(50)),
                              ),
                              title: Text(documentSnapshot['Organization Name'],
                                  style: const TextStyle(
                                    color: Color(0xff408c5d),
                                  )),
                              subtitle: Text(documentSnapshot['Organization Name'] + " has added new event!",
                                style: TextStyle(
                                color: Colors.black,
                              ),),
                            ),
                        ),
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
