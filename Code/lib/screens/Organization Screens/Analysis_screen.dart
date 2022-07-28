import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../widgets/OriginalButton.dart';
import 'Graph_screen.dart';

class Analysis_screen extends StatelessWidget {
  final String OrganizationName;

  Analysis_screen({Key? key, required this.OrganizationName}) : super(key: key);

  final CollectionReference _requests =
      FirebaseFirestore.instance.collection('Requests');

  @override
  Widget build(BuildContext context) {
    int _moneyCounter = 0;
    int _devicesCounter = 0;
    int _booksCounter = 0;
    int _clothesCounter = 0;
    int _numberOfRequests = 0;
    var data;
    FirebaseFirestore.instance
        .collection("Requests")
        .where("Organization Name", isEqualTo: OrganizationName)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection("Requests")
            .doc(element.id)
            .get()
            .then((value) {
          data = value.data();
          if (data["Organization Name"] == OrganizationName) {
            ++_numberOfRequests;
            if (data["Donation Type"] == "Money Donation") {
              ++_moneyCounter;
            } else if (data["Donation Type"] == "Devices Donation") {
              ++_devicesCounter;
            } else if (data["Donation Type"] == "Books Donation") {
              ++_booksCounter;
            } else if (data["Donation Type"] == "Clothes Donation") {
              ++_clothesCounter;
            }
          }
        });
      });
    });
    return Scaffold(
      backgroundColor: const Color(0xfff7fffb),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xffff66624)),
        toolbarHeight: MediaQuery.of(context).size.height * 0.09,
        title: Text(
          "Analytical Report",
          style: TextStyle(
            color: Color(0xffff66624),
            fontSize: 22,
          ),
        ),
        backgroundColor: Color(0xfff7fffb),
      ),
      body: Column(
        children: <Widget>[
          Card(
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
                      child: Icon(
                        Icons.pie_chart,
                        color: Color(0xffff66624),
                        size: 40,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    Text("Pie Chart",
                        style: TextStyle(
                          color: Color(0xff408c5d),
                          fontSize: 16,
                        )),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    Text(
                      "Here you can find a pie chart that track the requests of users for different donation types as well as the total number of requests made.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    OriginalButton(
                        text: "Generate data",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Graph_screen(
                                  ClothesRequests: _clothesCounter,
                                  DevicesRequests: _devicesCounter,
                                  NumberOfRequests: _numberOfRequests,
                                  MoneyRequests: _moneyCounter,
                                  BooksRequests: _booksCounter,
                                )),
                          );
                        },
                        Height: MediaQuery.of(context).size.height * 0.05,
                        Width: MediaQuery.of(context).size.width * 0.4,
                        font: 16),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
