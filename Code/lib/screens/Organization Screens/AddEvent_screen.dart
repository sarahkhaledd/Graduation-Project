import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kherwallet/screens/Organization%20Screens/OrganizationHome_screen.dart';
import '../../widgets/OriginalButton.dart';

class AddEvent_screen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final String OrganizationEmail;
  final String OrganizationName;
  final String CollectionName;

  AddEvent_screen({
    Key? key,
    required this.OrganizationEmail,
    required this.OrganizationName,
    required this.CollectionName,
  }) : super(key: key);

  String? _code, _details;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7fffb),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xffff66624)),
        toolbarHeight: MediaQuery.of(context).size.height * 0.09,
        title: Text(
          "  Add Event",
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
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.qr_code_rounded),
                        labelText: 'Event Code',
                        hintText: '#0000',
                      ),
                      onSaved: (val) {
                        _code = val;
                      },
                      validator: (value) {
                        if (value!.isEmpty || value.length > 5 || value.length < 5) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.wrap_text_rounded),
                        labelText: 'Details',
                        hintText: 'Your Event details',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      ),
                      maxLines: 6,
                      onSaved: (val) {
                        _details = val;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter valid details';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                    OriginalButton(
                      text: "Post",
                      onPressed: () {
                        var data;
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          FirebaseFirestore.instance
                              .collection(CollectionName)
                              .where("Name", isEqualTo: OrganizationName)
                              .get()
                              .then((value) {
                            value.docs.forEach((element) {
                              FirebaseFirestore.instance
                                  .collection(CollectionName)
                                  .doc(element.id)
                                  .get()
                                  .then((value) {
                                data = value.data();
                          final firestoreInstance = FirebaseFirestore.instance;
                          firestoreInstance.collection("Events").add({
                            "Event Code": _code,
                            "EventDescription": _details,
                            "Logo": data['Logo'],
                            "OrganizationName": OrganizationName,
                            "TimePosted": DateTime(
                              DateTime.now().year,
                              DateTime.now().month,
                              DateTime.now().day,
                              DateTime.now().hour,
                              DateTime.now().minute,
                              DateTime.now().second,
                            ),
                          }).then((value) => firestoreInstance
                                  .collection("User Notifications")
                                  .add({
                                "Logo": data['Logo'],
                                "Event ID": value.id,
                                "Notification Date": DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day,
                                  DateTime.now().hour,
                                  DateTime.now().minute,
                                  DateTime.now().second,
                                ),
                                "Organization Name": OrganizationName,
                              }).then((value) => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OrganizationHome_screen(
                                                  OrganizationEmail:
                                                      OrganizationEmail,
                                                  OrganizationName:
                                                      OrganizationName,
                                                  CollectionName:
                                                      CollectionName,
                                                )),
                                      )));
                              });
                            });
                          });
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
