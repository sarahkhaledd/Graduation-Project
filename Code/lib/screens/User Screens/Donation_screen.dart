import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../services/Authentication.dart';

class Donataion_screen extends StatelessWidget {
  final String DonationType;
  final String OrganizationName;
  final String OrganizationLogo;
  final List<String> BankNumbers;

  const Donataion_screen(
      {Key? key,
      required this.DonationType,
      required this.OrganizationName,
      required this.OrganizationLogo,
      required this.BankNumbers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data;
    FirebaseFirestore.instance
        .collection("UserData")
        .doc(FirebaseAuth
        .instance.currentUser?.uid).get().then((value) {
      data = value.data();
    });
    CollectionReference info = FirebaseFirestore.instance.collection('KherWallet');
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
      body: Container(
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Card(
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      ListTile(
                        leading: ClipRRect(
                          child: Image.network(OrganizationLogo,
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.height * 0.1),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        title: Text(OrganizationName,
                            style: const TextStyle(
                              color: Color(0xff408c5d),
                            )),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                    ],
                  ),
                ),
              ),
            ),
            if (DonationType == "Money Donation")
              Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xfff7fffb),
                  shadowColor: Color(0xffff66624),
                  elevation: 5,
                  child: InkWell(
                      splashColor: Color(0xffebebeb),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.credit_card,
                                color: Color(0xffff66624), size: 35),
                            title: Text("Donate Using Bank Numbers",
                                style: const TextStyle(
                                  color: Color(0xffff66624),
                                )),
                          ),
                          for (var banknumber in BankNumbers)
                            Text(banknumber,
                                style: const TextStyle(
                                  color: Color(0xff408c5d),
                                )),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                        ],
                      )),
                ),
              ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xfff7fffb),
                shadowColor: Color(0xffff66624),
                elevation: 5,
                child: InkWell(
                    splashColor: Color(0xffebebeb),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.accessibility_new_outlined,
                              color: Color(0xffff66624), size: 35),
                          title: Text("Request Representative",
                              style: const TextStyle(
                                color: Color(0xffff66624),
                              )),
                        ),
                        FutureBuilder<DocumentSnapshot>(
                            future: info.doc('info').get(),
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                Map<String, dynamic> data = snapshot.data!
                                    .data() as Map<String, dynamic>;
                                return Text("${data['Representative info']}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Color(0xff408c5d),
                                    ));
                              }
                              return const Center(
                                child: null,
                              );
                            }),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        TextButton(
                          onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text(
                                  'Would you like to request representative?',
                                  style: const TextStyle(
                                    color: Color(0xff408c5d),
                                  )),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel',
                                      style: const TextStyle(
                                        color: Color(0xffff66624),
                                      )),
                                ),
                                TextButton(
                                  onPressed: () {
                                    final firestoreInstance = FirebaseFirestore.instance;
                                    firestoreInstance
                                        .collection("Requests")
                                        .add({
                                      "Organization Name": OrganizationName,
                                      "Donation Type": DonationType,
                                      "Request State": "In Progress",
                                      "UserID": FirebaseAuth.instance.currentUser?.uid,
                                      "UserName": data['name'],
                                      "PhoneNumber": data['phoneNumber'],
                                      "Address": data['address'],
                                      "Donation Date": DateTime(
                                          DateTime.now().year,
                                          DateTime.now().month,
                                          DateTime.now().day,
                                          DateTime.now().hour,
                                          DateTime.now().minute,
                                          DateTime.now().second,
                                      ),
                                    }).then((value) => firestoreInstance
                                        .collection("Organization Notifications")
                                        .add({
                                          "User Request ID": value.id,
                                    }).then((value) => Navigator.of(context).pushNamed('RequestScreen')));
                                  },
                                  child: const Text('Ok',
                                      style: const TextStyle(
                                          color: Color(0xffff66624))),
                                ),
                              ],
                            ),
                          ),
                          child: const Text('Request',
                              style: const TextStyle(
                                color: Color(0xffff66624),
                              )),
                        ),
                      ],
                    )),
              ),
            )
          ],
        )),
      ),
    );
  }
}
