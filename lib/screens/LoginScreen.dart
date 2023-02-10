// ignore_for_file: prefer_const_constructors
import 'package:demo_firebase_1/screens/ForgetPassword.dart';
import 'package:demo_firebase_1/screens/HomePage.dart';
import 'package:demo_firebase_1/screens/Signup.dart';
import 'package:demo_firebase_1/screens/googleauth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import 'DisplayUsers.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String spass = "",strr="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Container(
                height: 300,
                width: 400,
                child: Lottie.asset("assets/hello.json"),
              ),
              GestureDetector(
                onTap: () async {
                  await AuthService().signInWithGoogle();
                  Get.to(DisplayUsers());
                },
                child: Image.network(
                  "https://pngimg.com/uploads/google/google_PNG19635.png",
                  height: 65,
                  width: 65,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                child: TextField(
                  controller: emailController,
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
              Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    hintText: "Password",
                    prefixIcon: Icon(
                      Icons.password,
                      color: Colors.black26,
                    ),
                  ),
                ),
              ),
              Text(spass,style: TextStyle(color: Colors.red),),
              Text(strr,style: TextStyle(color: Colors.red),),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: (() async {
                    var Loginemail = emailController.text.trim();
                    var Loginpassword = passwordController.text.trim();
                    try {
                      if (Loginpassword.length < 8) {
                        setState(() {
                          spass = "Enter correct password";
                        });
                      }
                      final User? firebaseuser = (await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: Loginemail, password: Loginpassword))
                          .user;
                      // print("user $firebaseuser");
                      if (firebaseuser != null) {
                        Get.to(() => DisplayUsers());
                      } else {
                        setState(() {
                          strr="Check ur Credentials";
                        });
                      }
                    } on FirebaseAuthException catch (e) {
                      print("Exception is $e");
                    }
                  }),
                  child: Text("Login My Account ")),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => ForgetPassword())));
                },
                child: Container(
                  child: Card(
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("Forget Password ? ")),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => SignUpScreen())));
                },
                child: Container(
                  child: Card(
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(" Dont Have an Account ! SignUp now... ")),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
