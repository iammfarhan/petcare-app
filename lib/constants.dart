import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Color primaryColor = Color(0xff7010FB);
Color secondaryColor = Color(0xff8f24b6).withOpacity(0.5);

String appName = "Pet Care";
String profileName = "Ali";
String petName = "Name";
String petBreed = "Breed";

LinearGradient myGradient = LinearGradient(
    colors: [primaryColor, secondaryColor],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter);

String docName = "Dr. Rami Roy";
String docClinic = "Juno Clinic";
String professionalism = "General Practice";
String timeMF = "9:00-18:00";
String clinicLocation = "10247, WeserStrasse 38, Berlin";
String reviews = "4.1";
String about =
    "Responsible for daily care of all surgical patients, ensuring all clinical staff,members are adhering"
    "proper pre-, peri-, and post-operative care patients.";
String docPrice = "100";

String desc =
    "The new Chocolate Chunkin’ Pumpkin cheesecake is made with brownies and cookies";

List<IconData> servicesIcon = [
  Icons.medical_services,
  FontAwesomeIcons.personWalking
];
List<IconData> requestIcon = [FontAwesomeIcons.personWalking];

List<String> servicesText = ["Veterinary", "Walking"];

List<String> requestText = ["Walking"];

List<String> location = ["Islamabad", "Rawalpindi"];

LinearGradient gradient = LinearGradient(
    colors: [primaryColor, secondaryColor],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter);
