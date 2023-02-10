// ignore_for_file: unnecessary_null_comparison
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_firebase_1/screens/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notespage extends StatefulWidget {
  const Notespage({Key? key}) : super(key: key);

  @override
  State<Notespage> createState() => _NotespageState();
}

class _NotespageState extends State<Notespage> {
  TextEditingController things = TextEditingController();
  User? userId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add IMP things..."),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            Container(
              child: TextFormField(
                controller: things,
                decoration: const InputDecoration(
                  hintText: "Add Text",
                  errorMaxLines: null,
                ),
              ),
            ),
            ElevatedButton(
                onPressed: (() async{
                  var note = things.text.trim();
                  if (note != "") {
                    try {
                      await FirebaseFirestore.instance.collection("notes").doc().set({
                        "createdAt": DateTime.now(),
                        "Text": note,
                        "UserId": userId?.uid,
                      }).then((value) => {
                        Get.to(()=> const HomePage())
                      });
                    } on FirebaseFirestore catch (e) {
                      print("Error $e");
                    }
                  } else {
                    print("No Text");
                  }
                }),
                child: const Text("Add Text"))
          ],
        ),
      ),
    );
  }
}
