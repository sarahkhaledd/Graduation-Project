import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kherwallet/screens/UpdateUserProfile_screen.dart';
import '../services/Authentication.dart';

class UserProfile_screen extends StatelessWidget {
  const UserProfile_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionReference _userData =
    FirebaseFirestore.instance.collection('UserData');
    return Scaffold(
      backgroundColor: const Color(0xfff7fffb),
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.09,
        title: Text(
          "  Profile",
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
        ],
      ),
      body: StreamBuilder(
          stream: _userData.snapshots(),
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
                  if (documentSnapshot.id ==
                      FirebaseAuth.instance.currentUser?.uid) {
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      color: const Color(0xfff7fffb),
                      shadowColor: Color(0xffff66624),
                      elevation: 5,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.person,
                            color: Color(0xff408c5d),
                            size: 40,
                          ),
                          Text(
                            documentSnapshot["name"],
                            style: TextStyle(
                              color: Color(0xff408c5d),
                            ),
                          ),
                          Text(
                            documentSnapshot["email"],
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                              height:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.05),
                          FlatButton.icon(
                              height: MediaQuery.of(context).size.height * 0.05,
                              minWidth: MediaQuery.of(context).size.width * 0.7,
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
                                UpdateUserProfile_screen(UserName: documentSnapshot["name"],
                                  UserPhoneNumber: documentSnapshot["phoneNumber"],
                                  UserAddress:  documentSnapshot["address"],
                                  UserEmail: documentSnapshot["email"])));
                              },
                              icon: Icon(
                                Icons.info_outline_rounded,
                                size: 20.0,
                              ),
                              label: Align(
                                  child: Text(
                                    "Update your information",
                                  ))),
                          FlatButton.icon(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.05,
                              minWidth: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.5,
                              color: const Color(0xffff66624),
                              textColor: Color(0xfff7fffb),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onPressed: () {
                                AuthenticationHelper().resetPassword(email: documentSnapshot["email"]).then((result) {
                                  if (result == null) {
                                    AlertDialog alert =  AlertDialog(
                                      title: Text("Change password",style: const TextStyle(
                                          color: Color(0xffff66624))),
                                      content: Text("Email will be send to: " + documentSnapshot["email"],
                                        style: TextStyle(
                                          color: Color(0xff408c5d),
                                        ),),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => Navigator.of(context).pushNamed('UserProfile'),
                                          child: const Text('Ok',style: const TextStyle(
                                              color: Color(0xffff66624))),
                                        ),
                                      ],);
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return alert;
                                      },
                                    );
                                  }
                                });
                              },
                              icon: Icon(
                                Icons.lock_open_rounded,
                                size: 20.0,
                              ),
                              label: Align(child: Text("Change password"))),
                          FlatButton.icon(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.05,
                              minWidth: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.2,
                              color: const Color(0xffff66624),
                              textColor: Color(0xfff7fffb),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onPressed: () {
                                AuthenticationHelper().signOut().then((result) {
                                  if (result == null) {
                                    Navigator.of(context).pushNamed('SignIn');
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
