import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petcare/Screens/Main/petprofile.dart';
import 'package:petcare/Screens/Main/request.dart';
import 'package:petcare/Screens/Main/video.dart';
import 'package:petcare/Screens/home_screen.dart';
import '../../Model/userModel.dart';
import '../../constants.dart';
import 'dietplan.dart';
import 'home.dart';
import 'location.dart';

class Nav extends StatefulWidget {
  const Nav({Key? key}) : super(key: key);

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  User? user = FirebaseAuth.instance.currentUser;
  int _selectedIndex = 0;
  List<Widget> screens = [
    Home(),
    Location(),
    Request(),
    DietPlan(),
    HomeScreen(screen: "nav"),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  getUser()async{
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection("users").doc(user?.uid).get();
    UserModel((doc.data() as Map)["name"],(doc.data() as Map)["imageUrl"],"");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
      canvasColor: Colors.grey.shade200,),
          child: BottomNavigationBar(
            selectedLabelStyle: TextStyle(fontFamily: "Futura",fontSize: 15),
            elevation: 1,
            unselectedItemColor: Colors.black87,
            selectedItemColor: primaryColor,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            items: [
              BottomNavigationBarItem(
                  label: "Home",
                  icon: Icon(Icons.home_rounded,size: 20,)),
              BottomNavigationBarItem(
                  label: "Location",
                  icon: Icon(Icons.location_on_rounded,size: 20,)),
              BottomNavigationBarItem(label: "Request",icon: Icon(Icons.add_circle_rounded,size: 20)),
              BottomNavigationBarItem(label: "Diet",icon: Icon(FontAwesomeIcons.breadSlice,size: 20,)),
              BottomNavigationBarItem(label: "Video",icon: Icon(CupertinoIcons.video_camera_solid,size: 20,)),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
        body: screens[_selectedIndex]
    );
  }
}
