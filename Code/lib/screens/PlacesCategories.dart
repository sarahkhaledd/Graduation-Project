import 'package:flutter/material.dart';
import 'Organization_Categories.dart';

class PlacesCategories extends StatelessWidget {
  const PlacesCategories({Key? key}) : super(key: key);

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
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Organization_Categories(PlaceCategory: 'Charities'),
                      ),
                    ),
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.apartment_rounded,
                        color: Color(0xff408c5d),
                        size: MediaQuery.of(context).size.height * 0.15,
                      ),
                      Text("Charities",
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
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Organization_Categories(PlaceCategory: 'FoodBanks'),
                      ),
                    ),
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.food_bank_rounded,
                        color: Color(0xff408c5d),
                        size: MediaQuery.of(context).size.height * 0.15,
                      ),
                      Text("Food Banks",
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
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Organization_Categories(PlaceCategory: 'Orphanges'),
                      ),
                    ),
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.baby_changing_station_rounded,
                        color: Color(0xff408c5d),
                        size: MediaQuery.of(context).size.height * 0.15,
                      ),
                      Text("Orphanges",
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
