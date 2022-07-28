import 'package:flutter/material.dart';
import 'package:kherwallet/services/Authentication.dart';
import 'package:kherwallet/widgets/OriginalButton.dart';

class SignInCredentials extends StatefulWidget {
  const SignInCredentials({Key? key}) : super(key: key);

  @override
  State<SignInCredentials> createState() => _SignInCredentialsState();
}

class _SignInCredentialsState extends State<SignInCredentials> {
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
                              Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel',
                              style: const TextStyle(
                                color: Color(0xffff66624),
                              )),
                        ),
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
            SizedBox(width: MediaQuery.of(context).size.width * 0.2),
            TextButton(
              onPressed: () => Navigator.of(context).pushNamed('SignUp'),
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  "New? Sign Up",
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

              AuthenticationHelper()
                  .signIn(email: _email!, password: _password!)
                  .then((result) {
                if (result == null) {
                  Navigator.of(context).pushNamed('Home');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      result,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ));
                }
              });
            }
          },
          Height: MediaQuery.of(context).size.width * 0.12,
          Width: MediaQuery.of(context).size.width * 0.75,
          font: 18,
        ),
        TextButton(
          onPressed: () =>
              Navigator.of(context).pushNamed('SignInAsOrganization'),
          child: const Align(
            alignment: Alignment.center,
            child: Text(
              "Sign in as an Organization!",
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
