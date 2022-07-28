import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kherwallet/screens/OrganizationProfile_screen.dart';

class Organization_Categories extends StatelessWidget {
  final String PlaceCategory;
  const Organization_Categories({Key? key, required this.PlaceCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionReference _user =
        FirebaseFirestore.instance.collection(PlaceCategory);
    return Scaffold(
      backgroundColor: const Color(0xfff7fffb),
      appBar: AppBar(
        title: Text(PlaceCategory,
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
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.16,
                    width: MediaQuery.of(context).size.width * 0.1,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 110),
                    child: Material(
                      type: MaterialType.button,
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffebebeb),
                      shadowColor: Color(0xffff66624),
                      elevation: 5,
                      child: InkWell(
                        splashColor: Color(0xffebebeb),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    OrganizationProfile_screen(
                                      OrganizationName:
                                          documentSnapshot['Name'],
                                      CollectionName: PlaceCategory,
                                    )
                            ),
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ClipRRect(
                              child: Image.network(documentSnapshot['Logo'],
                                  height: MediaQuery.of(context).size.height * 0.12, width: MediaQuery.of(context).size.width * 0.12),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            Text(
                              documentSnapshot['Name'],
                              style: const TextStyle(
                                color: Color(0xff408c5d),
                              ),
                            ),
                          ],
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
