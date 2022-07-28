import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/OriginalButton.dart';

class UpdateUserProfile_screen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final String UserEmail;
  final String UserName;
  final String UserAddress;
  final String UserPhoneNumber;

  String? _email, _name, _address, _phoneNumber;

  UpdateUserProfile_screen(
      {Key? key,
      required this.UserEmail,
      required this.UserName,
      required this.UserAddress,
      required this.UserPhoneNumber})
      : super(key: key);

  @override
  final TextEditingController controller = new TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7fffb),
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.09,
        title: Text(
          "  Update information",
          style: TextStyle(
            color: Color(0xffff66624),
            fontSize: 22,
          ),
        ),
        backgroundColor: Color(0xfff7fffb),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: UserEmail,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        labelText: 'Email',
                        hintText: 'ex: example@email.com',
                      ),
                      onSaved: (val) {
                        _email = val;
                      },
                      validator: (value) {
                        RegExp regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                        if (value!.isEmpty) {
                          return 'Please enter a valid email';
                        }
                        else
                        {
                          if (!regex.hasMatch(value))
                          {
                            return 'Email is in bad format';
                          } else
                          {
                            return null;
                          }
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                    TextFormField(
                      initialValue: UserName,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.account_circle),
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
                      initialValue: UserAddress,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.add_location_alt_outlined),
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
                      initialValue: UserPhoneNumber,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.phone_in_talk_outlined),
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
                    SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                    OriginalButton(
                      text: "Update",
                      onPressed: () {
                        if (_formKey.currentState!.validate())
                        {
                          _formKey.currentState!.save();
                          var firebaseUser = FirebaseAuth.instance.currentUser;
                          final firestoreInstance = FirebaseFirestore.instance;
                          firestoreInstance.collection("UserData").doc(firebaseUser?.uid).set({
                            "email": _email,
                            "name": _name,
                            "address": _address,
                            "phoneNumber": _phoneNumber,
                          },SetOptions(merge: true)).then((value) => Navigator.of(context).pushNamed('UserProfile'));
                        }
                        },
                      Height: MediaQuery.of(context).size.width * 0.12,
                      Width: MediaQuery.of(context).size.width * 0.75,
                      font: 18,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
