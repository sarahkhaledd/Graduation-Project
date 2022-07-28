import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kherwallet/widgets/OriginalButton.dart';
import '../services/Authentication.dart';

class SignUpCredentials extends StatefulWidget {
  const SignUpCredentials({Key? key}) : super(key: key);

  @override
  State<SignUpCredentials> createState() => _SignUpCredentialsState();
}

class _SignUpCredentialsState extends State<SignUpCredentials> {
  final _formKey = GlobalKey<FormState>();

  String? _email, _name, _password, _address, _phoneNumber;
  bool _obscureText = false;
  bool _agree = false;
  CollectionReference info = FirebaseFirestore.instance.collection('KherWallet');

  @override
  final TextEditingController controller = new TextEditingController();

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
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
                controller: controller,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline),
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
                onSaved: (val) {
                  _password = val;
                },
                obscureText: !_obscureText,
                validator: (value) {
                  RegExp regex =
                  RegExp(
                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
                  if (value!.isEmpty)
                  {
                    return 'Please enter a valid password';
                  } else
                  {
                    if (!regex.hasMatch(value))
                    {
                      return '8 charcters, 1 upper case, 1 lower case and a digit';
                    } else
                    {
                      return null;
                    }
                  }
                }
    ),
              TextFormField(
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
                  if (value!.isEmpty || value.length < 11 || value.length > 11) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.06),
              Row(
                children: <Widget>[
                  Checkbox(
                    onChanged: (_) {
                      setState(() {
                        _agree = !_agree;
                      });
                    },
                    value: _agree,
                  ),
                  Flexible(
                    child: FlatButton(
                      onPressed: () {
                        AlertDialog alert = AlertDialog(
                          title: Text("Terms and Privacy Policy"),
                          content: FutureBuilder<DocumentSnapshot>(
                              future: info.doc('info').get(),
                              builder:
                                  (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.connectionState == ConnectionState.done) {
                                  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                                  return Text("${data['terms']}",
                                      style: TextStyle(
                                        color: Color(0xff408c5d),
                                      ),
                                  );
                                }
                                return const Center(
                                  child: null,
                                );
                              }),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Ok'),
                              child: const Text('Ok'),
                            ),
                          ],);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                        },
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "I agree to the Terms of Services and Privacy Policy.",
                          style: TextStyle(
                            color: Color(0xff408c5d),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.06),
              OriginalButton(
                text: "Continue",
                onPressed: () {
                  if (_formKey.currentState!.validate() && _agree == true) {
                    _formKey.currentState!.save();
                    //Analysis().signup();
                    AuthenticationHelper()
                        .signUp(email: _email!, password: _password!)
                        .then((result) {
                      if (result == null) {
                        var firebaseUser =  FirebaseAuth.instance.currentUser;
                        final firestoreInstance = FirebaseFirestore.instance;
                        firestoreInstance.collection("UserData").doc(firebaseUser?.uid).set(
                            {
                              "email": _email,
                              "name": _name,
                              "address": _address,
                              "phoneNumber": _phoneNumber,
                            }
                        ).then((value) => Navigator.of(context).pushNamed('Home')
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            result,
                            style: TextStyle(fontSize: 16),
                          ),
                        ));
                      }
                    });
                  }
                  else if(_agree == false)
                    {
                      AlertDialog alert = AlertDialog(
                          content: Text("Please read our Terms and Privacy Policy"),
                          actions: <Widget>[
                          TextButton(
                          onPressed: () => Navigator.pop(context, 'Ok'),
                          child: const Text('Ok'),
                          ),
                          ],);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    }
                },
                Height: MediaQuery.of(context).size.width * 0.12,
                Width: MediaQuery.of(context).size.width * 0.75, font: 18,
              ),
              FlatButton(
                onPressed: () => Navigator.of(context).pushNamed('SignIn'),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Have an account? Sign In",
                    style: TextStyle(
                      color: Color(0xff408c5d),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
