import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kherwallet/widgets/OriginalButton.dart';

class Requests_screen extends StatefulWidget {
  const Requests_screen({Key? key}) : super(key: key);

  @override
  State<Requests_screen> createState() => _Requests_screenState();
}

class _Requests_screenState extends State<Requests_screen> {
  final CollectionReference _requests =
      FirebaseFirestore.instance.collection('Requests');
  late String? currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7fffb),
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.09,
        automaticallyImplyLeading: false,
        title: Text(
          "  Requests",
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
          stream: _requests.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              FirebaseFirestore.instance
                  .collection("UserData")
                  .doc(FirebaseAuth.instance.currentUser?.uid);
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  if (documentSnapshot["UserID"] == FirebaseAuth.instance.currentUser?.uid) {
                    Timestamp myTimeStamp = Timestamp.fromDate(DateTime.now());
                    DateTime dateTime1 = DateTime.parse(documentSnapshot["Donation Date"].toDate().toString());
                    DateTime dateTime2 = DateTime.parse(myTimeStamp.toDate().toString());
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      color: const Color(0xfff7fffb),
                      shadowColor: Color(0xffff66624),
                      elevation: 5,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(
                              Icons.list_alt_rounded,
                              color: Color(0xffff66624),
                              size: 40,
                            ),
                            title: Text(documentSnapshot['Donation Type'],
                                style: const TextStyle(
                                  color: Color(0xffff66624),
                                )),
                            subtitle: Flexible(
                              child: Text(
                                "To: " +
                                    documentSnapshot['Organization Name'] +
                                    "\n" +
                                    documentSnapshot['Request State'],
                                style: const TextStyle(
                                  color: Color(0xff408c5d),
                                ),
                              ),
                            ),
                          ),
                          if (documentSnapshot['Request State'] != "Completed")
                            Text(
                              "You can only remove your donation within 24 hours.",
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              if(dateTime1.difference(dateTime2).inDays == 0)
                          OriginalButton(
                              text: "Remove",
                              onPressed: (){
                                FirebaseFirestore.instance
                                    .collection("Organization Notifications")
                                    .where("User Request ID", isEqualTo : documentSnapshot.id)
                                    .get().then((value){
                                  value.docs.forEach((element) {
                                    FirebaseFirestore.instance.collection("Organization Notifications").doc(element.id).delete().then((value){
                                    });
                                  });
                                });
                                FirebaseFirestore.instance.collection("Requests").doc(documentSnapshot.id).delete().then((_) {});
                              },
                              Height: MediaQuery.of(context).size.height * 0.05,
                              Width: MediaQuery.of(context).size.width * 0.21,
                              font: 12),
                        ],
                      ),
                          SizedBox(
                              height:
                              MediaQuery.of(context).size.height * 0.02),
                    ],
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
