import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:drop_cap_text/drop_cap_text.dart';
import 'Donation_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class OrganizationProfile_screen extends StatelessWidget {
  final String OrganizationName;
  final String CollectionName;

  const OrganizationProfile_screen(
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
                              FlatButton.icon(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  minWidth:
                                      MediaQuery.of(context).size.width * 0.9,
                                  color: const Color(0xfff7fffb),
                                  textColor: Color(0xffff66624),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Donataion_screen(
                                                DonationType: item,
                                                OrganizationName:
                                                    documentSnapshot['Name'],
                                                OrganizationLogo:
                                                    documentSnapshot['Logo'],
                                                BankNumbers: List.from(
                                                    documentSnapshot[
                                                        'Bank Numbers']),
                                              )),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 20.0,
                                  ),
                                  label: Align(
                                      child: Text(item,
                                          style: TextStyle(fontSize: 18.0)))),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    launch('tel:'+documentSnapshot['Number']);
                                  },
                                  child: const Icon(
                                    Icons.phone_in_talk_rounded,
                                    size: 20.0,
                                    color: Color(0xffff66624),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    launch('mailto:'+documentSnapshot['Email']+'?subject=This is Subject Title&body=This is Body of Email');
                                  },
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
                                          content: Text(
                                              documentSnapshot['Main Branch'],
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
