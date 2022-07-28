import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:flutter/material.dart';
import 'package:kherwallet/screens/UpdateOrganizationProfile_screen.dart';
import '../services/Authentication.dart';

class Organization_screen extends StatelessWidget {
  final String OrganizationName;
  final String CollectionName;

  const Organization_screen(
      {Key? key, required this.OrganizationName, required this.CollectionName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionReference _user =
        FirebaseFirestore.instance.collection(CollectionName);
    return Scaffold(
      backgroundColor: const Color(0xfff7fffb),
      appBar: AppBar(
        title: Text(
          OrganizationName,
          style: TextStyle(
            color: Color(0xffff66624),
            fontSize: 22,
          ),
        ),
        backgroundColor: Color(0xfff7fffb),
      ),
      body: StreamBuilder(
        stream: _user.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                List<String> items =
                    List.from(documentSnapshot['Donation Type']);
                if (documentSnapshot['Name'] == OrganizationName) {
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffebebeb),
                      shadowColor: Color(0xffff66624),
                      elevation: 5,
                      child: InkWell(
                        splashColor: Color(0xffebebeb),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                documentSnapshot['Name'],
                                style: const TextStyle(
                                  color: Color(0xff408c5d),
                                ),
                              ),
                            ),
                            DropCapText(
                              documentSnapshot['Details'],
                              dropCapPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              style: const TextStyle(
                                color: Color(0xff408c5d),
                              ),
                              dropCap: DropCap(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                child: Image.network(documentSnapshot['Logo']),
                              ),
                            ),
                            for (var item in items)
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                width: MediaQuery.of(context).size.width * 0.7,
                                margin: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 0.5),
                                child: Material(
                                  borderRadius: BorderRadius.circular(50),
                                  type: MaterialType.card,
                                  color: Color(0xfff7fffb),
                                  shadowColor: Color(0xffff66624),
                                  elevation: 5,
                                  child: InkWell(
                                    splashColor: Color(0xffebebeb),
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        color: Color(0xffff66624),
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                TextButton(
                                  onPressed: () => showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: Text("Hotline",
                                          style: const TextStyle(
                                              color: Color(0xffff66624))),
                                      content: Text(documentSnapshot['Number'],
                                          style: const TextStyle(
                                            color: Color(0xff408c5d),
                                          ),
                                          textAlign: TextAlign.center),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Ok'),
                                          child: const Text('Ok',
                                              style: const TextStyle(
                                                  color: Color(0xffff66624))),
                                        ),
                                      ],
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.phone_in_talk_rounded,
                                    size: 20.0,
                                    color: Color(0xffff66624),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: Text("Email",
                                          style: const TextStyle(
                                              color: Color(0xffff66624))),
                                      content: Text(documentSnapshot['Email'],
                                          style: const TextStyle(
                                            color: Color(0xff408c5d),
                                          ),
                                          textAlign: TextAlign.center),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Ok'),
                                          child: const Text('Ok',
                                              style: const TextStyle(
                                                  color: Color(0xffff66624))),
                                        ),
                                      ],
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.email_rounded,
                                    size: 20.0,
                                    color: Color(0xffff66624),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: Text("Main Branch",
                                          style: const TextStyle(
                                              color: Color(0xffff66624))),
                                      content:
                                          Text(documentSnapshot['Main Branch'],
                                              style: const TextStyle(
                                                color: Color(0xff408c5d),
                                              ),
                                              textAlign: TextAlign.center),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Ok'),
                                          child: const Text('Ok',
                                              style: const TextStyle(
                                                  color: Color(0xffff66624))),
                                        ),
                                      ],
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.map_rounded,
                                    size: 20.0,
                                    color: Color(0xffff66624),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                FlatButton.icon(
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    minWidth:
                                        MediaQuery.of(context).size.width * 0.2,
                                    color: const Color(0xffff66624),
                                    textColor: Color(0xfff7fffb),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UpdateOrganizationProfile_screen(
                                                  OrganizationName:
                                                      OrganizationName,
                                                  CollectionName:
                                                      CollectionName,
                                                  OrganizationAddress: documentSnapshot['Main Branch'],
                                                  OrganizationDetails: documentSnapshot['Details'],
                                                  OrganizationPhoneNumber: documentSnapshot['Number'],
                                                  OrganizationEmail: documentSnapshot['Email'],
                                                )),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.info_outline_rounded,
                                      size: 20.0,
                                    ),
                                    label: Align(
                                        child:
                                            Text("Update your information"))),
                                FlatButton.icon(
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    minWidth:
                                        MediaQuery.of(context).size.width * 0.2,
                                    color: const Color(0xffff66624),
                                    textColor: Color(0xfff7fffb),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    onPressed: () {
                                      AuthenticationHelper()
                                          .signOut()
                                          .then((result) {
                                        if (result == null) {
                                          Navigator.of(context)
                                              .pushNamed('SignIn');
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      Icons.exit_to_app_rounded,
                                      size: 20.0,
                                    ),
                                    label: Align(child: Text("Sign out"))),
                              ],
                            ),
                          ],
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
        },
      ),
    );
  }
}
