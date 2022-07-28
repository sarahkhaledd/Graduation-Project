import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kherwallet/screens/Organization%20Screens/Analysis_screen.dart';
import 'package:kherwallet/screens/Organization%20Screens/OrganizationRequests_screen.dart';
import 'package:readmore/readmore.dart';
import '../../services/Authentication.dart';
import '../../widgets/OriginalButton.dart';
import 'AddEvent_screen.dart';
import 'EditEvent_screen.dart';
import 'Organization_screen.dart';

class OrganizationHome_screen extends StatelessWidget {
  final String OrganizationEmail;
  final String OrganizationName;
  final String CollectionName;

  OrganizationHome_screen(
      {Key? key,
      required this.OrganizationEmail,
      required this.OrganizationName,
      required this.CollectionName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionReference _events =
        FirebaseFirestore.instance.collection('Events');

    return Scaffold(
      backgroundColor: const Color(0xfff7fffb),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xffff66624)),
        title: Text(
          "Home",
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
                  Text(
                    'Kher Wallet',
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrganizationHome_screen(
                          OrganizationName: OrganizationName,
                          CollectionName: CollectionName,
                          OrganizationEmail: OrganizationEmail)),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.receipt, color: Color(0xff408c5d)),
              title: Text('Requests'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrganizationRequests_screen(
                          OrganizationName: OrganizationName,
                          CollectionName: CollectionName,
                          OrganizationEmail: OrganizationEmail)),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle, color: Color(0xff408c5d)),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Organization_screen(
                            OrganizationName: OrganizationName,
                            CollectionName: CollectionName,
                            OrganizationEmail: OrganizationEmail,
                          )),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list_alt_rounded, color: Color(0xff408c5d)),
              title: Text('Analytical Report'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Analysis_screen(OrganizationName: OrganizationName)),
                );
              },
            ),
            ListTile(
              leading:
                  Icon(Icons.help_outline_outlined, color: Color(0xff408c5d)),
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
                AuthenticationHelper().signOut().then((result) {
                  if (result == null) {
                    Navigator.of(context).pushNamed('SignIn');
                  }
                });
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder(
          stream: _events.orderBy("TimePosted", descending: true).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  Timestamp myTimeStamp = Timestamp.fromDate(DateTime.now());
                  DateTime dateTime =
                      DateTime.parse(myTimeStamp.toDate().toString());
                  if (OrganizationName ==
                      documentSnapshot['OrganizationName']) {
                    return Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      child: Material(
                        type: MaterialType.button,
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffebebeb),
                        shadowColor: Color(0xffff66624),
                        elevation: 5,
                        child: Column(
                          children: <Widget>[
                            InkWell(
                              splashColor: Color(0xffebebeb),
                              child: ListTile(
                                leading: ClipRRect(
                                  child: Image.network(documentSnapshot['Logo'],
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ),
                                title:
                                    Text(documentSnapshot['OrganizationName'],
                                        style: const TextStyle(
                                          color: Color(0xff408c5d),
                                        )),
                                subtitle: Flexible(
                                  child: ReadMoreText(
                                    documentSnapshot['EventDescription']
                                        .toString(),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                OriginalButton(
                                    text: "Edit",
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditEvent_screen(
                                                  EventCode: documentSnapshot[
                                                      'Event Code'],
                                                  EventDetails:
                                                      documentSnapshot[
                                                          'EventDescription'],
                                                  CollectionName:
                                                      CollectionName,
                                                  OrganizationName:
                                                      OrganizationName,
                                                  OrganizationEmail:
                                                      OrganizationEmail,
                                                  id: documentSnapshot.id,
                                                )),
                                      );
                                    },
                                    Height: MediaQuery.of(context).size.height *
                                        0.05,
                                    Width: MediaQuery.of(context).size.width *
                                        0.21,
                                    font: 12),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.01),
                                OriginalButton(
                                    text: "Remove",
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection("User Notifications")
                                          .where("Event ID",
                                              isEqualTo: documentSnapshot.id)
                                          .get()
                                          .then((value) {
                                        value.docs.forEach((element) {
                                          FirebaseFirestore.instance
                                              .collection("User Notifications")
                                              .doc(element.id)
                                              .delete()
                                              .then((value) {});
                                        });
                                      });
                                      FirebaseFirestore.instance
                                          .collection("Events")
                                          .doc(documentSnapshot.id)
                                          .delete()
                                          .then((_) {});
                                    },
                                    Height: MediaQuery.of(context).size.height *
                                        0.05,
                                    Width: MediaQuery.of(context).size.width *
                                        0.21,
                                    font: 12),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.01),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                          ],
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddEvent_screen(
                      OrganizationEmail: OrganizationEmail,
                      OrganizationName: OrganizationName,
                      CollectionName: CollectionName)));
        },
        backgroundColor: Color(0xff408c5d),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
