// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:demo_firebase_1/screens/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPassword> {
  TextEditingController Fpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forget Password Screen"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,

          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Container(
              margin: EdgeInsets.only(left: 30, right: 30),
              child: TextField(
                controller: Fpassword,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  hintText: "E-mail",
                  prefixIcon: Icon(
                    Icons.mail,
                    color: Colors.black26,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: (() async {
                  var fp = Fpassword.text.trim();
                  try {
                    FirebaseAuth.instance
                        .sendPasswordResetEmail(email: fp)
                        .then((value) =>{
                              print("Email Sent"),
                              Get.off(() => LoginScreen())
                            });
                  } on FirebaseAuthException catch (e) {
                    print("Error : $e");
                  }
                }),
                child: Text("Forget Password :( ")),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
