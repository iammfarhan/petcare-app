import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:petcare/Screens/Intro/introductionScreen.dart';
import 'package:petcare/Screens/Intro/logIn.dart';
import 'package:petcare/Screens/Intro/signUp.dart';
import 'package:petcare/Screens/Intro/splash.dart';
import 'package:petcare/Screens/Main/Components/DietComponents/dietDetail.dart';
import 'package:petcare/Screens/Main/Components/DietComponents/makeDiet.dart';
import 'package:petcare/Screens/Main/Components/ServicesComponents/veterinaryService.dart';
import 'package:petcare/Screens/Main/Components/VetComponents/vetAppointment.dart';
import 'package:petcare/Screens/Main/Components/detail.dart';
import 'package:petcare/Screens/Main/Components/requestPage.dart';
import 'package:petcare/Screens/Main/home.dart';
import 'package:petcare/Screens/Main/petprofile.dart';
import 'package:petcare/Screens/Main/request.dart';
import 'package:petcare/Screens/Main/services.dart';

import 'Screens/Main/nav.dart';
import 'Screens/Main/pet.dart';
import 'package:shared_preferences/shared_preferences.dart';
int? isviewed;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDnVqjbitYKlFR0N6k3thtPIr-CxaOGGlA",
      appId: "1:257375579643:android:453cb6afc96363f3e56f5e",
      messagingSenderId: "XXX",
      projectId: "petcare-c7594",
    ),
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed = prefs.getInt('onBoard');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Care',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff7010FB),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Splash(i: isviewed),
    );
  }
}
