import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kherwallet/screens/Organization%20Screens/OrganizationRequests_screen.dart';

import '../../widgets/OriginalButton.dart';

class EditRequest_screen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final String RequestState;
  final String OrganizationEmail;
  final String OrganizationName;
  final String CollectionName;
  final String id;

  EditRequest_screen(
      {Key? key,
      required this.RequestState,
      required this.id,
      required this.OrganizationEmail,
      required this.OrganizationName,
      required this.CollectionName})
      : super(key: key);
  String? _state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7fffb),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xffff66624)),
        toolbarHeight: MediaQuery.of(context).size.height * 0.09,
        title: Text(
          "Edit Request",
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
                        initialValue: RequestState,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.wrap_text_rounded),
                          labelText: 'Request State',
                          hintText: 'Your Request State',
                        ),
                        onSaved: (val) {
                          _state = val;
                        },
                        validator: (value) {
                          if (value!.isEmpty ||
                              value.toLowerCase() != "completed") {
                            return 'Please enter valid state (Hint: Completed)';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                      SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                      OriginalButton(
                        text: "Update",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            FirebaseFirestore.instance
                                .collection("Requests")
                                .doc(id)
                                .set({
                              "Request State": _state,
                            }, SetOptions(merge: true)).then((value) =>
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              OrganizationRequests_screen(
                                                OrganizationEmail:
                                                    OrganizationEmail,
                                                OrganizationName:
                                                    OrganizationName,
                                                CollectionName: CollectionName,
                                              )),
                                    ));
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
          )),
    );
  }
}
