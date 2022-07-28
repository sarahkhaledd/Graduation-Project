import 'package:flutter/material.dart';
import 'package:kherwallet/screens/PlacesCategories.dart';
import 'DonationCategories.dart';
import 'UserProfile_screen.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            '  Category Lists',
            style: TextStyle(
              color: Color(0xffff66624),
              fontSize: 22,
            ),
          ),
          backgroundColor: Color(0xfff7fffb),
          actions: <Widget>[
            IconButton(
              onPressed: () {Navigator.of(context)
                  .pushNamed('SearchScreen');},
              icon: Icon(
                Icons.search,
                color: Color(0xff408c5d),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed('UserProfile');
              },
              icon: Icon(
                Icons.person,
                color: Color(0xff408c5d),
              ),
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.black,
            tabs: <Widget>[
              Tab(
                text: 'Donation Categories',
              ),
              Tab(
                text: 'Places Categories',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
           DonationCategories(),
          PlacesCategories(),
          ],
        ),
      ),
    );
  }
}
