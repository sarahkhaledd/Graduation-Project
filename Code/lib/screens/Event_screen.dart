import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Event_screen extends StatelessWidget {
  final String OrganizationName;
  final String OrganizationLogo;
  final String EventDescription;
  final String EventCode;

  const Event_screen(
      {Key? key,
      required this.OrganizationName,
      required this.OrganizationLogo,
      required this.EventDescription,
      required this.EventCode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Uri _url = Uri.parse(
        'https://docs.google.com/forms/d/e/1FAIpQLSfNDBweDSzfRibYtlAURCUSYfqXrRd__Xn8CgCKfa3rMhPexw/viewform?usp=sf_link');
    void _launchUrl() async {
      if (!await launchUrl(_url)) throw 'Could not launch $_url';
    }

    return Scaffold(
      backgroundColor: const Color(0xfff7fffb),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "  Event",
          style: TextStyle(
            color: Color(0xffff66624),
            fontSize: 22,
          ),
        ),
        backgroundColor: Color(0xfff7fffb),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('SearchScreen');
            },
            icon: Icon(
              Icons.search,
              color: Color(0xff408c5d),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('UserProfile');
            },
            icon: Icon(
              Icons.person,
              color: Color(0xff408c5d),
            ),
          ),
        ],
      ),
      body: Card(
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Material(
          type: MaterialType.button,
          borderRadius: BorderRadius.circular(10),
          color: Color(0xffebebeb),
          shadowColor: Color(0xffff66624),
          elevation: 5,
          child: InkWell(
            splashColor: Color(0xffebebeb),
            child: Column(
              children: <Widget>[
                ClipRRect(
                  child: Image.network(OrganizationLogo,
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.height * 0.15),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                Text(OrganizationName,
                    style: TextStyle(
                      color: Color(0xff408c5d),
                      fontSize: 16,
                    )),
                Text(
                  EventCode,
                  style: TextStyle(
                    color: Color(0xffff66624),
                    fontSize: 16,
                  ),
                ),
                Text(
                  EventDescription,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Text("You can apply to this event using the Google form here:",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff408c5d),
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: _launchUrl,
                  child: const Text(
                    "Google form",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color(0xffff66624),
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
