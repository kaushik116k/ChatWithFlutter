import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseAuth auth = FirebaseAuth.instance;
class DisplayUsers extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users"),),
      body: getAllUsers(),
    );
  }
}

class getAllUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> usersnapshot) {
          if (usersnapshot.connectionState == ConnectionState.waiting) {
            return Container(
                child: Center(child: CircularProgressIndicator()));
          }
          else {
            return ListView.separated(
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = usersnapshot.data!.docs[index];
                    print(document.data()!);
                    if (document.id == auth.currentUser!.uid) {
                      return Container(height: 0);
                    }
                    return Container(

                      child: Text(document['username'].toString()),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: usersnapshot.data!.docs.length,
                );

          }
        }
    );
  }
}

