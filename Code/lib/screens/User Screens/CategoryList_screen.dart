import 'package:flutter/material.dart';
import 'package:kherwallet/screens/User%20Screens/PlacesCategories.dart';
import '../../services/Authentication.dart';
import 'DonationCategories.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(0xffff66624)),
          title: const Text(
            'Category Lists',
            style: TextStyle(
              color: Color(0xffff66624),
              fontSize: 22,
            ),
          ),
          backgroundColor: Color(0xfff7fffb),
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
        drawer: Drawer(
          backgroundColor: Color(0xfff7fffb),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xfff7fffb),
                ),
                child: Column(
                  children: <Widget>[
                    Image.asset('assets/images/logoo.png', width: 100),
                    Text('Kher Wallet',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xffff66624),
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.home, color: Color(0xff408c5d)),
                title: Text('Home'),
                onTap: () {
                  Navigator.of(context).pushNamed('Home');
                },
              ),
              ListTile(
                leading: Icon(Icons.list, color: Color(0xff408c5d)),
                title: Text('Category List'),
                onTap: () {
                  Navigator.of(context).pushNamed('CategoryList');
                },
              ),
              ListTile(
                leading: Icon(Icons.receipt, color: Color(0xff408c5d)),
                title: Text('Requests'),
                onTap: () {
                  Navigator.of(context).pushNamed('RequestScreen');
                },
              ),
              ListTile(
                leading: Icon(Icons.account_circle, color: Color(0xff408c5d)),
                title: Text('Profile'),
                onTap: () {
                  Navigator.of(context).pushNamed('UserProfile');
                },
              ),
              ListTile(
                leading: Icon(Icons.help_outline_outlined, color: Color(0xff408c5d)),
                title: Text('Help'),
                onTap: () {
                  Navigator.of(context).pushNamed('HelpScreen');
                },
              ),
              ListTile(
                leading:
                Icon(Icons.exit_to_app_rounded, color: Color(0xff408c5d)),
                title: Text('Sign out'),
                onTap: () {
                  AuthenticationHelper()
                      .signOut()
                      .then((result) {
                    if (result == null) {
                      Navigator.of(context)
                          .pushNamed('SignIn');
                    }
                  });
                },
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
