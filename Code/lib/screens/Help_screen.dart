import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference info =
        FirebaseFirestore.instance.collection('KherWallet');
    return Scaffold(
      backgroundColor: const Color(0xfff7fffb),
      body: Center(
        child: Column(
          children: <Widget>[
            AppBar(
              iconTheme: IconThemeData(color: Color(0xffff66624)),
              toolbarHeight: MediaQuery.of(context).size.height * 0.09,
              title: Text(
                "Help Section",
                style: TextStyle(
                  color: Color(0xffff66624),
                  fontSize: 22,
                ),
              ),
              backgroundColor: Color(0xfff7fffb),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
            Material(
              type: MaterialType.button,
              color: const Color(0xffebebeb),
              shadowColor: Color(0xffff66624),
              elevation: 5,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                splashColor: Color(0xffebebeb),
                onTap: () => Navigator.of(context).pushNamed('WriteFeedback'),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.feedback_rounded,
                      color: Color(0xff408c5d),
                      size: MediaQuery.of(context).size.height * 0.15,
                    ),
                    Text("Feedback",
                        style: TextStyle(
                          color: Color(0xff408c5d),
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Material(
              type: MaterialType.button,
              color: const Color(0xffebebeb),
              shadowColor: Color(0xffff66624),
              elevation: 5,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                splashColor: Color(0xffebebeb),
                onTap: () => Navigator.of(context).pushNamed('FAQ'),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.help_outline_rounded,
                      color: Color(0xff408c5d),
                      size: MediaQuery.of(context).size.height * 0.15,
                    ),
                    Text("FAQ",
                        style: TextStyle(
                          color: Color(0xff408c5d),
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Material(
              type: MaterialType.button,
              color: const Color(0xffebebeb),
              shadowColor: Color(0xffff66624),
              elevation: 5,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                splashColor: Color(0xffebebeb),
                onTap: () {
                  launch(
                      'mailto:kherwallet@gmail.com?subject=This is Subject Title&body=This is Body of Email');
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.email_rounded,
                      color: Color(0xff408c5d),
                      size: MediaQuery.of(context).size.height * 0.15,
                    ),
                    Text("Email Us",
                        style: TextStyle(
                          color: Color(0xff408c5d),
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          ],
        ),
      ),
    );
  }
}
