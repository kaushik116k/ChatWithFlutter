// ignore_for_file: prefer_const_constructors, avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'dart:developer';
import 'package:demo_firebase_1/screens/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../userservices/signupservice.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController useremailController = TextEditingController();
  TextEditingController userpasswordController = TextEditingController();
  String str = "", pass = "", uname = "",uemail="";
  User? currentuser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignUp Screen"),
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
                controller: usernameController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  hintText: "User Name",
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.black26,
                  ),
                ),
              ),
            ),
            Text(
              uname,
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30),
              child: TextField(
                controller: userPhoneController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  hintText: "Phone Number",
                  prefixIcon: Icon(
                    Icons.call,
                    color: Colors.black26,
                  ),
                ),
              ),
            ),
            Text(
              str,
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30),
              child: TextField(
                controller: useremailController,
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
            Text(uemail,style: TextStyle(color: Colors.red),),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30),
              child: TextField(
                controller: userpasswordController,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    hintText: "Password",
                    prefixIcon: Icon(
                      Icons.password,
                      color: Colors.black26,
                    )),
              ),
            ),
            Text(
              pass,
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: (() async {
                  var username = usernameController.text.trim();
                  if (username.isEmpty) {
                    setState(() {
                      uname = "Enter a username";
                    });
                  }
                  var userphone = userPhoneController.text.trim();
                  if (userphone.toString().length != 10) {
                    setState(() {
                      str = "Enter Phone number of exact 10 digits..";
                    });
                  }
                  var useremail = useremailController.text.trim();
                  if (useremail.isEmpty) {
                    setState(() {
                      uemail = "Enter a valid gmail...";
                    });
                  }
                  var userpassword = userpasswordController.text.trim();
                  if (userpassword.isEmpty || userpassword.length < 8) {
                    setState(() {
                      pass = "Enter a good password";
                    });
                  }
                  await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: useremail, password: userpassword)
                      .then(
                        (value) => {
                          SignUpuser(
                              username, userphone, useremail, userpassword),
                          log("User created"),
                        },
                      );
                }),
                child: Text("Submit Details")),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => LoginScreen())));
              },
              child: Container(
                child: Card(
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(" Already Have an Account ! SignIn now... ")),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
