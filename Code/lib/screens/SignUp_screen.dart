import 'package:flutter/material.dart';
import 'package:kherwallet/widgets/SignUpCredentials_screen.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7fffb),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            children: const <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "\nSign Up",
                  style: TextStyle(
                    color: Color(0xffff66624),
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              SignUpCredentials(),
            ],
          ),
        ),
      ),
    );
  }
}
