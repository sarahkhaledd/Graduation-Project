import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../services/Authentication.dart';
import 'OrganizationProfile_screen.dart';

class DonationType_screen extends StatelessWidget {
  final String DonationType;

  const DonationType_screen({Key? key, required this.DonationType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> OrganizationInfo = [];
    final CollectionReference _user = FirebaseFirestore.instance.collection("Donation");
    return Scaffold(
      backgroundColor: const Color(0xfff7fffb),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xffff66624)),
        title: Text(
          DonationType,
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
          stream: _user.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  if (documentSnapshot.id == DonationType) {
                    List<String> infos =
                        List.from(documentSnapshot['Organization Info']);
                    for (var info in infos) {
                      List<String> arr = info.split(",");
                      OrganizationInfo.add(arr[0]);
                      OrganizationInfo.add(arr[1]);
                      OrganizationInfo.add(arr[2]);
                    }
                    return SizedBox(
                      height: MediaQuery.of(context).size.longestSide,
                      child: SingleChildScrollView(
                        child: Material(
                          color: const Color(0xfff7fffb),
                          child: Column(
                            children: <Widget>[
                              for (var i = 0; i < OrganizationInfo.length; i++)
                                if (i % 3 == 0)
                                  Container(
                                    height: MediaQuery.of(context).size.height * 0.19,
                                    width:
                                        MediaQuery.of(context).size.width * 0.52,
                                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 90),
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
                                            ClipRRect(
                                              child: Image.network(
                                                  OrganizationInfo[i],
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.12,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.12),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50)),
                                            ),
                                            Text(
                                              OrganizationInfo[++i],
                                              style: const TextStyle(
                                                color: Color(0xff408c5d),
                                              ),
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OrganizationProfile_screen(
                                                      OrganizationName:
                                                          OrganizationInfo[i],
                                                      CollectionName:
                                                          OrganizationInfo[++i],
                                                    )),
                                          );
                                        },
                                      ),
                                    ),
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
          }),
    );
  }
}
