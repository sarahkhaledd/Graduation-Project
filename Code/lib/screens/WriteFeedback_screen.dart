import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/OriginalButton.dart';

class WriteFeedback extends StatefulWidget {
  const WriteFeedback({Key? key}) : super(key: key);

  @override
  State<WriteFeedback> createState() => _WriteFeedbackState();
}

class _WriteFeedbackState extends State<WriteFeedback> {
  final _formKey = GlobalKey<FormState>();
  String? _email, _feedback;

  @override
  final TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7fffb),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xffff66624)),
        title: Text(
          "Write Feedback",
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
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    labelText: 'Email',
                    hintText: 'ex: example@email.com',
                  ),
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
                  onSaved: (val) {
                    _email = val;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.feedback_rounded),
                    labelText: 'Feedback',
                    hintText: 'Write your feedback here',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                  ),
                  maxLines: 5,
                  onSaved: (val) {
                    _feedback = val;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your feedback here';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                OriginalButton(
                  text: "Submit",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser?.uid);
                      final firestoreInstance = FirebaseFirestore.instance;
                      firestoreInstance.collection("Feedback").add({
                        "email": _email,
                        "feedback": _feedback,
                        "UserID": FirebaseAuth.instance.currentUser?.uid,
                      }).then((value) => Navigator.of(context).pushNamed('HelpScreen'));
                    }
                  },
                  Height: 50,
                  Width: MediaQuery.of(context).size.width * 0.75,
                  font: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
