import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petcare/Screens/Intro/signUp.dart';
import 'package:petcare/Screens/Main/nav.dart';
import 'package:petcare/constants.dart';

import 'logIn.dart';


class EmailVerification extends StatefulWidget {
  EmailVerification({Key? key}) : super(key: key);

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  bool isEmailVerified = false, canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if(!isEmailVerified){
      sendVerificationEmail();
      timer = Timer.periodic(Duration(seconds: 10), (_) => checkEmailVerified());
      }
  }

  @override
  void dispose(){
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if(isEmailVerified){
      timer?.cancel();
    }
  }

  Future sendVerificationEmail()async{
    try{
      final user = FirebaseAuth.instance.currentUser!;
      user.sendEmailVerification();

      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(Duration(seconds: 5));
      setState(() {
        canResendEmail = true;
      });
    } catch (e){
      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(content: e.toString()));
    }
  }
  @override
  Widget build(BuildContext context) {
    var height1 = MediaQuery.of(context).size.height;
    var width1 = MediaQuery.of(context).size.width;
    return isEmailVerified ? Login() : Scaffold(
      appBar: AppBar(
        title: Text("Email Verification",style: TextStyle(color: Colors.white, fontFamily: 'Futura'),),
        backgroundColor: primaryColor,
        elevation: 1,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text("A verification email has been sent to your email."),
            SizedBox(
              height: height1*0.06,
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(primary: primaryColor,shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                  )),
                  icon: Icon(Icons.email,size: 32,color: Colors.white,),
                  onPressed: canResendEmail ? sendVerificationEmail : null,
                label: Text("Resend Email",style: TextStyle(color: Colors.white),),
              ),
            ),
            FlatButton(
              onPressed: () => FirebaseAuth.instance.signOut().then((value) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login()), (route) => false)),
              child: Text("Cancel"),
            ),
          ],
        ),
      ),
    );
  }

  static SnackBar customSnackBar({@required String? content}) {
    return SnackBar(
      backgroundColor: Colors.white,
      content: Text(
        content!,
        style: const TextStyle(color: Colors.black, letterSpacing: 0.3),
      ),
      margin: const EdgeInsets.all(25.0),
      behavior: SnackBarBehavior.floating,
    );
  }
}
