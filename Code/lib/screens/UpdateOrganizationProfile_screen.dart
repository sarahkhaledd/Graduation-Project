import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/OriginalButton.dart';
import 'Organization_screen.dart';

class UpdateOrganizationProfile_screen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final String OrganizationDetails;
  final String OrganizationEmail;
  final String OrganizationAddress;
  final String OrganizationPhoneNumber;
  final String OrganizationName;
  final String CollectionName;

  String? _email, _details, _address, _phoneNumber;

  UpdateOrganizationProfile_screen(
      {Key? key,
      required this.OrganizationDetails,
      required this.OrganizationEmail,
      required this.OrganizationAddress,
      required this.OrganizationPhoneNumber,
      required this.OrganizationName,
      required this.CollectionName})
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
                      initialValue: OrganizationEmail,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        labelText: 'Contact Email',
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
                      keyboardType: TextInputType.emailAddress,
                    ),
                    TextFormField(
                      initialValue: OrganizationDetails,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.account_circle),
                        labelText: 'Details',
                        hintText: 'Your full details',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
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
                    TextFormField(
                      initialValue: OrganizationAddress,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.add_location_alt_outlined),
                        labelText: 'Main Branch',
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
                      initialValue: OrganizationPhoneNumber,
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
                            value.length > 11
                            ) {
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
                                  .set({
                                    "Email": _email,
                                    "Details": _details,
                                    "Main Branch": _address,
                                    "Number": _phoneNumber,
                                  }, SetOptions(merge: true)).then((value) =>
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Organization_screen(
                                            OrganizationName: OrganizationName,
                                            CollectionName: CollectionName)),
                                  ));
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
