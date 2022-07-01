import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:meetmefit_assignment/net/flutterfire.dart';
import 'package:path/path.dart';

class ShowProfile extends StatefulWidget {
  ShowProfile({Key? key}) : super(key: key);
  @override
  State<ShowProfile> createState() => _ShowProfileState();
}

class _ShowProfileState extends State<ShowProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Center(
          child: Text(
            "MeetMeFit",
            style: TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.w800,
              fontSize: 30,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('info')
                  .doc('url')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                String pic = snapshot.data!.get("Url");
                return CircleAvatar(
                  backgroundImage: NetworkImage(pic),
                  radius: 75,
                  backgroundColor: Colors.white,
                  
                );
              },
            ),
            Center(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('info')
                    .doc("Values")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  String Nv = snapshot.data!.get("Name");
                  String Av = snapshot.data!.get("About");
                  return Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        Nv,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      Container(
                        height: 150,
                        width: 300,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 3,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            Av,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for ( var i = 0 ; i < 7 ; i++ ) (i!=3) ? (Row( mainAxisAlignment: MainAxisAlignment.center, children: [ for ( var j = 0 ; j < 13 ; j++ ) (j==0 || j==12)?  Text("*") :  Text("  ") ],)) : (Row( mainAxisAlignment: MainAxisAlignment.center, children: [ for ( var j = 0 ; j < 13 ; j++) Text("*")],))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
