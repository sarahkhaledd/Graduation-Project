import 'package:flutter/material.dart';
import 'package:kherwallet/screens/DontationType_screen.dart';

class DonationCategories extends StatelessWidget {
  const DonationCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DonationType_screen(
                                  DonationType: 'Money Donation',
                                )
                        ),
                      );
                    },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.monetization_on_rounded,
                        color: Color(0xff408c5d),
                        size: MediaQuery.of(context).size.height * 0.15,
                      ),
                      Text("Money",
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DonationType_screen(
                                DonationType: 'Clothes Donation',
                              )
                      ),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.accessibility_new_rounded,
                        color: Color(0xff408c5d),
                        size: MediaQuery.of(context).size.height * 0.15,
                      ),
                      Text("Clothes",
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DonationType_screen(
                                DonationType: 'Devices Donation',
                              )
                      ),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.kitchen_rounded,
                        color: Color(0xff408c5d),
                        size: MediaQuery.of(context).size.height * 0.15,
                      ),
                      Text("Devices",
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DonationType_screen(
                                DonationType: 'Books Donation',
                              )
                      ),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.menu_book_rounded,
                        color: Color(0xff408c5d),
                        size: MediaQuery.of(context).size.height * 0.15,
                      ),
                      Text("Books",
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
      ),
    );
  }
}
