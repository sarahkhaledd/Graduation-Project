import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kherwallet/screens/OrganizationProfile_screen.dart';

class FoodBank_screen extends StatelessWidget {
  const FoodBank_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionReference _user =
    FirebaseFirestore.instance.collection('FoodBanks');
    return Scaffold(
      backgroundColor: const Color(0xfff7fffb),
      appBar: AppBar(
        title: Text(
          "Food Banks",
          style: TextStyle(
            color: Color(0xffff66624),
            fontSize: 22,
          ),
        ),
        backgroundColor: Color(0xfff7fffb),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Color(0xff408c5d),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.person,
              color: Color(0xff408c5d),
            ),
          ),
        ],
      ),body: StreamBuilder(
        stream: _user.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                streamSnapshot.data!.docs[index];
                return Container(
                  height: 100,
                  width: 20,
                  margin: EdgeInsets.symmetric(
                      vertical: 10, horizontal:120),
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
                              builder: (context) => OrganizationProfile_screen(OrganizationName: documentSnapshot['Name'], CollectionName: 'FoodBanks',)
                          ),
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ClipRRect(
                            child: Image.network(documentSnapshot['Logo'],
                                height: 70, width: 70),
                            borderRadius: BorderRadius.all(Radius.circular(50)),
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
            child: CircularProgressIndicator(),
          );
        }),
    );
  }
}
