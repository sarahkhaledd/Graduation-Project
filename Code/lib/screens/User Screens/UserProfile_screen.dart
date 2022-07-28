import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../services/Authentication.dart';
import '../../widgets/OriginalButton.dart';

class UserProfile_screen extends StatelessWidget {
  UserProfile_screen({Key? key}) : super(key: key);
  String? _email, _name, _address, _phoneNumber;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final CollectionReference _userData =
        FirebaseFirestore.instance.collection('UserData');
    return Scaffold(
      backgroundColor: const Color(0xfff7fffb),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xffff66624)),
        toolbarHeight: MediaQuery.of(context).size.height * 0.09,
        title: Text(
          "Profile",
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
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 30),
                            child: Column(
                              children: <Widget>[
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: <Widget>[
                                      TextFormField(
                                        initialValue: documentSnapshot["email"],
                                        decoration: const InputDecoration(
                                          prefixIcon:
                                              Icon(Icons.email_outlined),
                                          labelText: 'Email',
                                          hintText: 'ex: example@email.com',
                                        ),
                                        onSaved: (val) {
                                          _email = val;
                                        },
                                        validator: (value) {
                                          RegExp regex = RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                                          if (value!.isEmpty) {
                                            return 'Please enter a valid email';
                                          } else {
                                            if (!regex.hasMatch(value)) {
                                              return 'Email is in bad format';
                                            } else {
                                              return null;
                                            }
                                          }
                                        },
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      ),
                                      TextFormField(
                                        initialValue: documentSnapshot["name"],
                                        decoration: const InputDecoration(
                                          prefixIcon:
                                              Icon(Icons.account_circle),
                                          labelText: 'Name',
                                          hintText: 'Your full name',
                                        ),
                                        onSaved: (val) {
                                          _name = val;
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter a valid name';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        initialValue:
                                            documentSnapshot["address"],
                                        decoration: const InputDecoration(
                                          prefixIcon: Icon(
                                              Icons.add_location_alt_outlined),
                                          labelText: 'Address',
                                          hintText: 'Your full address',
                                        ),
                                        onSaved: (val) {
                                          _address = val;
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter a valid address';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        initialValue:
                                            documentSnapshot["phoneNumber"],
                                        decoration: const InputDecoration(
                                          prefixIcon: Icon(
                                              Icons.phone_in_talk_outlined),
                                          labelText: 'Phone number',
                                          hintText: 'Your phone number',
                                        ),
                                        onSaved: (val) {
                                          _phoneNumber = val;
                                        },
                                        keyboardType: TextInputType.phone,
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              value.length < 11 ||
                                              value.length > 11) {
                                            return 'Please enter a valid number';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.06),
                                      OriginalButton(
                                        text: "Update",
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _formKey.currentState!.save();
                                            var firebaseUser = FirebaseAuth
                                                .instance.currentUser;
                                            final firestoreInstance =
                                                FirebaseFirestore.instance;
                                            firestoreInstance
                                                .collection("UserData")
                                                .doc(firebaseUser?.uid)
                                                .set({
                                              "email": _email,
                                              "name": _name,
                                              "address": _address,
                                              "phoneNumber": _phoneNumber,
                                            }, SetOptions(merge: true)).then(
                                                    (value) =>
                                                        Navigator.of(context)
                                                            .pushNamed(
                                                                'UserProfile'));
                                          }
                                        },
                                        Height:
                                            MediaQuery.of(context).size.height * 0.09,
                                        Width:
                                            MediaQuery.of(context).size.width * 0.7,
                                        font: 18,
                                      ),
                                    ],
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    AuthenticationHelper()
                                        .resetPassword(
                                        email: documentSnapshot["email"])
                                        .then((result) {
                                      if (result == null) {
                                        AlertDialog alert = AlertDialog(
                                          title: Text("Change password",
                                              style: const TextStyle(
                                                  color: Color(0xffff66624))),
                                          content: Text(
                                            "Email will be send to: " +
                                                documentSnapshot["email"],
                                            style: TextStyle(
                                              color: Color(0xff408c5d),
                                            ),
                                          ),
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
                                              onPressed: () => Navigator.of(
                                                  context)
                                                  .pushNamed('UserProfile'),
                                              child: const Text('Ok',
                                                  style: const TextStyle(
                                                      color: Color(
                                                          0xffff66624))),
                                            ),
                                          ],
                                        );
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return alert;
                                          },
                                        );
                                      }
                                    });
                                  },
                                  child: const Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Change password?",
                                      style: TextStyle(
                                        color: Color(0xff408c5d),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
