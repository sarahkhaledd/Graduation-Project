import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kherwallet/widgets/OriginalButton.dart';
import '../../services/Authentication.dart';

class Requests_screen extends StatefulWidget {
  const Requests_screen({Key? key}) : super(key: key);

  @override
  State<Requests_screen> createState() => _Requests_screenState();
}

class _Requests_screenState extends State<Requests_screen> {
  final CollectionReference _requests =
      FirebaseFirestore.instance.collection('Requests');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7fffb),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xffff66624)),
        toolbarHeight: MediaQuery.of(context).size.height * 0.09,
        title: Text(
          "Requests",
          style: TextStyle(
            color: Color(0xffff66624),
            fontSize: 22,
          ),
        ),
        backgroundColor: Color(0xfff7fffb),
      ),
      drawer: Drawer(
        backgroundColor: Color(0xfff7fffb),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xfff7fffb),
              ),
              child: Column(
                children: <Widget>[
                  Image.asset('assets/images/logoo.png', width: 100),
                  Text('Kher Wallet',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xffff66624),
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Color(0xff408c5d)),
              title: Text('Home'),
              onTap: () {
                Navigator.of(context).pushNamed('Home');
              },
            ),
            ListTile(
              leading: Icon(Icons.list, color: Color(0xff408c5d)),
              title: Text('Category List'),
              onTap: () {
                Navigator.of(context).pushNamed('CategoryList');
              },
            ),
            ListTile(
              leading: Icon(Icons.receipt, color: Color(0xff408c5d)),
              title: Text('Requests'),
              onTap: () {
                Navigator.of(context).pushNamed('RequestScreen');
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle, color: Color(0xff408c5d)),
              title: Text('Profile'),
              onTap: () {
                Navigator.of(context).pushNamed('UserProfile');
              },
            ),
            ListTile(
              leading: Icon(Icons.help_outline_outlined, color: Color(0xff408c5d)),
              title: Text('Help'),
              onTap: () {
                Navigator.of(context).pushNamed('HelpScreen');
              },
            ),
            ListTile(
              leading:
              Icon(Icons.exit_to_app_rounded, color: Color(0xff408c5d)),
              title: Text('Sign out'),
              onTap: () {
                AuthenticationHelper()
                    .signOut()
                    .then((result) {
                  if (result == null) {
                    Navigator.of(context)
                        .pushNamed('SignIn');
                  }
                });
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder(
          stream: _requests.orderBy("Donation Date", descending: true).snapshots(),
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
                              SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.01),
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
