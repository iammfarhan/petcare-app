import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petcare/Screens/Intro/emailVerification.dart';
import 'package:petcare/Screens/Intro/logIn.dart';
import 'package:petcare/constants.dart';
import 'emailVerification.dart';

import '../Main/nav.dart';
import 'introductionScreen.dart';

class Splash extends StatefulWidget {
  int? i;
  Splash({Key? key, required this.i}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget.i  != 0 ? OnBoardingScreen() : MainPage())));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var height1 = MediaQuery.of(context).size.height;
    var width1 = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height1,
        width: width1,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff8f24b6).withOpacity(0.5),
              primaryColor.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("images/logo.png",height: height1*0.4,width: height1*0.4,),
            SizedBox(height: height1*0.02,),
            Text(appName,style: TextStyle(fontSize: 28,color: Colors.white,fontFamily: "Futura",fontWeight: FontWeight.bold),),
            SizedBox(height: height1*0.01,),
            Text("Trusted care for your Pets\nAnytime,Anywhere!",textAlign: TextAlign.center,style: TextStyle(fontFamily: "Futura",color: Colors.white,fontSize: 14))
          ],
        ),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?> (
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return Nav();
            }else {
              return Login();
            }
          },
        )
    );
  }
}
