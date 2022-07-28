import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kherwallet/screens/Organization%20Screens/OrganizationHome_screen.dart';
import '../services/Authentication.dart';
import 'OriginalButton.dart';

class SignInOrganizationCredentials_screen extends StatefulWidget {
  const SignInOrganizationCredentials_screen({Key? key}) : super(key: key);

  @override
  State<SignInOrganizationCredentials_screen> createState() =>
      _SignInOrganizationCredentials_screenState();
}

class _SignInOrganizationCredentials_screenState
    extends State<SignInOrganizationCredentials_screen> {
  String? _email, _password;
  bool _obscureText = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'ex: example@email.com',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (val) {
                  _email = val;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
                obscureText: !_obscureText,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a valid password';
                  }
                  return null;
                },
                onSaved: (val) {
                  _password = val;
                },
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                AuthenticationHelper()
                    .resetPassword(email: _email!)
                    .then((result) {
                  if (result == null) {
                    AlertDialog alert = AlertDialog(
                      title: Text("Forget password",
                          style: const TextStyle(color: Color(0xffff66624))),
                      content: Text(
                        "Email will be send to " + _email!,
                        style: TextStyle(
                          color: Color(0xff408c5d),
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () =>
                              Navigator.of(context).pushNamed('SignIn'),
                          child: const Text('Ok',
                              style:
                                  const TextStyle(color: Color(0xffff66624))),
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
                  "Forget password?",
                  style: TextStyle(
                    color: Color(0xff408c5d),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        OriginalButton(
          text: "Sign In",
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              var data;
              FirebaseFirestore.instance
                  .collection("OrganizationsData")
                  .where("Organization Email", isEqualTo: _email)
                  .get()
                  .then((value) {
                value.docs.forEach((element) {
                  FirebaseFirestore.instance
                      .collection("OrganizationsData")
                      .doc(element.id)
                      .get()
                      .then((value) {
                    data = value.data();

                    AuthenticationHelper()
                        .signIn(email: _email!, password: _password!)
                        .then((result) {
                      if (result == null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrganizationHome_screen(
                                    OrganizationEmail: _email!,
                                    CollectionName:
                                        data['Organization Category'],
                                    OrganizationName: data['Organization Name'],
                                  )),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            result,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ));
                      }
                    });
                  });
                });
              });
            }
          },
          Height: MediaQuery.of(context).size.width * 0.12,
          Width: MediaQuery.of(context).size.width * 0.75,
          font: 18,
        ),
        TextButton(
          onPressed: () =>
              Navigator.of(context).pushNamed('SignIn'),
          child: const Align(
            alignment: Alignment.center,
            child: Text(
              "Sign in as Donator!",
              style: TextStyle(
                color: Color(0xff408c5d),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
