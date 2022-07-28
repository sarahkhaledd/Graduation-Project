import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kherwallet/screens/Organization%20Screens/EditRequest_screen.dart';
import 'package:kherwallet/widgets/OriginalButton.dart';
import '../../services/Authentication.dart';
import 'Analysis_screen.dart';
import 'OrganizationHome_screen.dart';
import 'Organization_screen.dart';

class OrganizationRequests_screen extends StatelessWidget {
  final String OrganizationName;
  final String OrganizationEmail;
  final String CollectionName;

  OrganizationRequests_screen(
      {Key? key,
      required this.OrganizationName,
      required this.OrganizationEmail,
      required this.CollectionName})
      : super(key: key);

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
                          OrganizationEmail: OrganizationEmail,
                          OrganizationName: OrganizationName,
                          CollectionName: CollectionName)),
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
          stream:
              _requests.orderBy("Donation Date", descending: true).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  if (documentSnapshot["Organization Name"] ==
                      OrganizationName) {
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
                                "From: " +
                                    documentSnapshot['UserName'] +
                                    "\n" +
                                    "Phone Number: " +
                                    documentSnapshot['PhoneNumber'] +
                                    "\n" +
                                    "Address: " +
                                    documentSnapshot['Address'] +
                                    "\n" +
                                    documentSnapshot['Request State'],
                                style: const TextStyle(
                                  color: Color(0xff408c5d),
                                ),
                              ),
                            ),
                          ),
                          if (documentSnapshot['Request State']
                                  .toString()
                                  .toLowerCase() !=
                              "completed")
                            Column(
                              children: <Widget>[
                                Text(
                                  "You can edit the request's state.",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02),
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
                                                    EditRequest_screen(
                                                      RequestState:
                                                          documentSnapshot[
                                                              'Request State'],
                                                      id: documentSnapshot.id,
                                                      OrganizationName:
                                                          OrganizationName,
                                                      CollectionName:
                                                          CollectionName,
                                                      OrganizationEmail:
                                                          OrganizationEmail,
                                                    )),
                                          );
                                        },
                                        Height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        Width:
                                            MediaQuery.of(context).size.width *
                                                0.21,
                                        font: 12),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.01),
                                  ],
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02),
                              ],
                            ),
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
