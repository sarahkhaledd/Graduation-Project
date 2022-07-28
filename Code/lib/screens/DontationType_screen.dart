import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'OrganizationProfile_screen.dart';

class DonationType_screen extends StatelessWidget {
  final String DonationType;

  const DonationType_screen({Key? key, required this.DonationType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> OrganizationInfo = [];
    final CollectionReference _user =
        FirebaseFirestore.instance.collection("Donation");
    return Scaffold(
      backgroundColor: const Color(0xfff7fffb),
      appBar: AppBar(
        title: Text(
          DonationType,
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
            icon: const Icon(
              Icons.search,
              color: Color(0xff408c5d),
            ),
          ),
          IconButton(
            onPressed: () {Navigator.of(context)
                .pushNamed('UserProfile');},
            icon: const Icon(
              Icons.person,
              color: Color(0xff408c5d),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: _user.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  if (documentSnapshot.id == DonationType) {
                    List<String> infos =
                        List.from(documentSnapshot['Organization Info']);
                    for (var info in infos) {
                      List<String> arr = info.split(",");
                      OrganizationInfo.add(arr[0]);
                      OrganizationInfo.add(arr[1]);
                      OrganizationInfo.add(arr[2]);
                    }
                    return Container(
                      height: MediaQuery.of(context).size.longestSide,
                      child: SingleChildScrollView(
                        child: Material(
                          color: const Color(0xfff7fffb),
                          child: Column(
                            children: <Widget>[
                              for (var i = 0; i < OrganizationInfo.length; i++)
                                if (i % 3 == 0)
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.16,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 110),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xffebebeb),
                                      shadowColor: Color(0xffff66624),
                                      elevation: 5,
                                      child: InkWell(
                                        splashColor: Color(0xffebebeb),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            ClipRRect(
                                              child: Image.network(
                                                  OrganizationInfo[i],
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.12,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.12),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50)),
                                            ),
                                            Text(
                                              OrganizationInfo[++i],
                                              style: const TextStyle(
                                                color: Color(0xff408c5d),
                                              ),
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OrganizationProfile_screen(
                                                      OrganizationName:
                                                          OrganizationInfo[i],
                                                      CollectionName:
                                                          OrganizationInfo[++i],
                                                    )),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return const Center(
                    child: null,
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
