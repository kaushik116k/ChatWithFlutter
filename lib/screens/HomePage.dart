import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_firebase_1/screens/LoginScreen.dart';
import 'package:demo_firebase_1/screens/googleauth.dart';
import 'package:demo_firebase_1/screens/notespage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page "),
        actions: [
          GestureDetector(
              onTap: (() {
                if(FirebaseAuth.instance!=null) {
                  FirebaseAuth.instance.signOut();
                  AuthService().signOut();
                  Get.off(() => const LoginScreen());
                }else{
                  const CircularProgressIndicator();
                }
              }),
              child: const Icon(Icons.logout))
        ],
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("notes")
              .where("UserId", isEqualTo: userId?.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text("..."));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("Empty"));
            }
            if (snapshot != null && snapshot.data != null) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: ((context, index) {
                  var texts = snapshot.data!.docs[index]['Text'];
                  return Card(
                    child: ListTile(
                      title: Text( texts ),

                    ),
                  );
                }),
              );
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Get.to(() => const Notespage());
        }),
        child: const Icon(Icons.note_add_rounded),
      ),
    );
  }
}
