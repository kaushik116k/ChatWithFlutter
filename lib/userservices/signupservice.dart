import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_firebase_1/screens/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

SignUpuser(String username, String userphone, String useremail,
    String userpassword) async {
  User? userid = FirebaseAuth.instance.currentUser;
  try {
    await FirebaseFirestore.instance.collection('users').doc(userid!.uid).set({
      'username': username,
      'userphone': userphone,
      'useremail': useremail,
      'userpassword': userpassword,
      'Createdat': DateTime.now(),
      'userId': userid.uid,
    }).then((value) =>
        {FirebaseAuth.instance.signOut(), Get.to(() => LoginScreen())});
  } on FirebaseAuthException catch (e) {
    print("This Error is : $e");
  }
}
