import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../widgets/SignInOrganizationCredentials_screen.dart';

class SignInOrganization_screen extends StatelessWidget {
  CollectionReference info = FirebaseFirestore.instance.collection('KherWallet');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff7fffb),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FutureBuilder<DocumentSnapshot>(
                  future: info.doc('info').get(),
                  builder:
                      (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                      return Image.network("${data['logoo']}", height: MediaQuery.of(context).size.width * 0.3);
                    }
                    return const Center(
                      child: null,
                    );
                  }),
              const Text(
                'Kher Wallet',
                style: TextStyle(
                  color: Color(0xff408c5d),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "\nSign In As Organization",
                  style: TextStyle(
                    color: Color(0xffff66624),
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "\nHi there! Nice to see you again.",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              const SignInOrganizationCredentials_screen(),
            ],
          ),
        ),
      ),
    );
  }
}
