import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/OriginalButton.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference info = FirebaseFirestore.instance.collection('KherWallet');
    return Scaffold(
      backgroundColor: const Color(0xfff7fffb),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const SizedBox(),
              FutureBuilder<DocumentSnapshot>(
                  future: info.doc('info').get(),
                  builder:
                      (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                      return Image.network("${data['logo']}");
                    }
                    return const Center(
                      child: null,
                    );
                  }),
              OriginalButton(
                text: "Get Started",
                onPressed: () => Navigator.of(context).pushNamed('SignIn'),
                Height: MediaQuery.of(context).size.width * 0.12,
                Width: MediaQuery.of(context).size.width * 0.75, font: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}