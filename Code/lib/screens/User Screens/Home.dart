import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kherwallet/screens/Organization%20Screens/SearchEvent_screen.dart';
import 'package:kherwallet/screens/User%20Screens/Event_screen.dart';
import 'package:readmore/readmore.dart';
import '../../services/Authentication.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> items = ["mark","nada"];
    final CollectionReference _user = FirebaseFirestore.instance.collection('Events');
    return Scaffold(
      backgroundColor: const Color(0xfff7fffb),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xffff66624)),
        title: Text(
          "Home",
          style: TextStyle(
            color: Color(0xffff66624),
            fontSize: 22,
          ),
        ),
        backgroundColor: Color(0xfff7fffb),
        actions: <Widget>[
          PopupMenuButton<Widget>(
            color: Color(0xfff7fffb),
            tooltip: "Filter Events",
            offset: Offset(0, 50),
            icon: Icon(Icons.filter_list_rounded, color: Color(0xff408c5d)),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchEvent_screen(
                                  OrganizationName: "Resala Charity",
                                )),
                          );
                        },
                        child: Text("Resala Charity",style: const TextStyle(
                          color: Colors.black,)))
                  ],
                ),
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchEvent_screen(
                                  OrganizationName: "Food Bank",
                                )),
                          );
                        },
                        child: Text("Food Bank",style: const TextStyle(
                          color: Colors.black,)))
                  ],
                ),
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchEvent_screen(
                                  OrganizationName: "Dar Malaaket El-Orman",
                                )),
                          );
                        },
                        child: Text("Dar Malaaket El-Orman",style: const TextStyle(
                          color: Colors.black,)))
                  ],
                ),
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchEvent_screen(
                                  OrganizationName: "Bawabet El Khair",
                                )),
                          );
                        },
                        child: Text("Bawabet El Khair",style: const TextStyle(
                          color: Colors.black,)))
                  ],
                ),
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchEvent_screen(
                                  OrganizationName: "Misr El Kheir Foundation",
                                )),
                          );
                        },
                        child: Text("Misr El Kheir Foundation",style: const TextStyle(
                          color: Colors.black,)))
                  ],
                ),
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchEvent_screen(
                                  OrganizationName: "Orman Charity",
                                )),
                          );
                        },
                        child: Text("Orman Charity",style: const TextStyle(
                          color: Colors.black,)))
                  ],
                ),
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchEvent_screen(
                                  OrganizationName: "57357 Hospital",
                                )),
                          );
                        },
                        child: Text("57357 Hospital",style: const TextStyle(
                          color: Colors.black,)))
                  ],
                ),
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchEvent_screen(
                                  OrganizationName: "500500 Hospital",
                                )),
                          );
                        },
                        child: Text("500500 Hospital",style: const TextStyle(
                          color: Colors.black,)))
                  ],
                ),
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchEvent_screen(
                                  OrganizationName: "Baheya Hospital",
                                )),
                          );
                        },
                        child: Text("Baheya Hospital",style: const TextStyle(
                          color: Colors.black,)))
                  ],
                ),
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchEvent_screen(
                                  OrganizationName: "Ahl Masr Hospital",
                                )),
                          );
                        },
                        child: Text("Ahl Masr Hospital",style: const TextStyle(
                          color: Colors.black,)))
                  ],
                ),
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchEvent_screen(
                                  OrganizationName: "Magdi Yacoub Hospital",
                                )),
                          );
                        },
                        child: Text("Magdi Yacoub Hospital",style: const TextStyle(
                          color: Colors.black,)))
                  ],
                ),
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchEvent_screen(
                                  OrganizationName: "Dar El Hassan",
                                )),
                          );
                        },
                        child: Text("Dar El Hassan",style: const TextStyle(
                          color: Colors.black,)))
                  ],
                ),
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchEvent_screen(
                                  OrganizationName: "Dar Mohamed Emad Ragheb",
                                )),
                          );
                        },
                        child: Text("Dar Mohamed Emad Ragheb",style: const TextStyle(
                          color: Colors.black,)))
                  ],
                ),
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchEvent_screen(
                                  OrganizationName: "Wataneya Society",
                                )),
                          );
                        },
                        child: Text("Wataneya Society",style: const TextStyle(
                          color: Colors.black,)))
                  ],
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('UserNotifications');
            },
            icon: Icon(
              Icons.notifications_active_outlined,
              color: Color(0xff408c5d),
            ),
          ),
        ],
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
                  Text(
                    'Kher Wallet',
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
              leading:
                  Icon(Icons.help_outline_outlined, color: Color(0xff408c5d)),
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
                AuthenticationHelper().signOut().then((result) {
                  if (result == null) {
                    Navigator.of(context).pushNamed('SignIn');
                  }
                });
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder(
          stream: _user.orderBy("TimePosted", descending: true).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  Timestamp myTimeStamp = Timestamp.fromDate(DateTime.now());
                  DateTime dateTime1 = DateTime.parse(
                      documentSnapshot["TimePosted"].toDate().toString());
                  DateTime dateTime2 =
                      DateTime.parse(myTimeStamp.toDate().toString());
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    child: Material(
                      type: MaterialType.button,
                      borderRadius: BorderRadius.circular(10),
                      color: (dateTime2.difference(dateTime1).inMinutes < 5 &&
                              dateTime2.difference(dateTime1).inHours == 0)
                          ? Color(0xffffA879)
                          : Color(0xffebebeb),
                      shadowColor: Color(0xffff66624),
                      elevation: 5,
                      child: InkWell(
                        splashColor: Color(0xffebebeb),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Event_screen(
                                      OrganizationLogo:
                                          documentSnapshot['Logo'],
                                      EventDescription:
                                          documentSnapshot['EventDescription'],
                                      OrganizationName:
                                          documentSnapshot['OrganizationName'],
                                      EventCode: documentSnapshot['Event Code'],
                                    )),
                          );
                        },
                        child: ListTile(
                          leading: ClipRRect(
                            child: Image.network(documentSnapshot['Logo'],
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width:
                                    MediaQuery.of(context).size.height * 0.1),
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          title: Text(documentSnapshot['OrganizationName'],
                              style: const TextStyle(
                                color: Color(0xff408c5d),
                              )),
                          subtitle: Flexible(
                            child: ReadMoreText(
                              documentSnapshot['EventDescription'].toString(),
                              trimLines: 2,
                              colorClickableText: Color(0xffff66624),
                              trimMode: TrimMode.Line,
                              trimCollapsedText: 'Expand',
                              trimExpandedText: 'Collapse',
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          trailing: Text(
                            documentSnapshot['Event Code'],
                            style: TextStyle(
                              color: Color(0xffff66624),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(
              child: null,
            );
          }),
    );
  }
}
