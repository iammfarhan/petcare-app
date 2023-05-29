import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petcare/Screens/Intro/logIn.dart';
import 'package:petcare/Screens/Main/Components/seeAll.dart';
import 'package:petcare/Screens/Main/Components/VetComponents/veterinaryAll.dart';
import 'package:petcare/Screens/Main/Components/VetComponents/veterinaryList.dart';
import 'package:petcare/Screens/Main/Components/WalkingComponents/walkingList.dart';
import 'package:petcare/Screens/Main/nav.dart';
import 'package:petcare/Screens/Main/petprofile.dart';
import 'package:petcare/Screens/Main/remainderScreen.dart';
import 'package:petcare/Screens/Main/services.dart';
import 'package:petcare/Screens/Main/showServices.dart';
import 'package:petcare/Screens/home_screen.dart';
import '../../Model/remainderModel.dart';
import '../../constants.dart';
import '../../services/notification_api.dart';
import '../../Model/userModel.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var height1;
  var width1;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  String services = "Veterinary";
  int servicesIndex = 0;
  User? user = FirebaseAuth.instance.currentUser;

  Future<DocumentSnapshot> doc = FirebaseFirestore.instance.collection("diet").doc(FirebaseAuth.instance.currentUser?.uid).collection("diets").doc("KNpM3cXT1ROwgC5UWkW4").get();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationApi.init(initScheduled: true);
    listenNotifications();
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotification);
  void onClickedNotification(String? payload) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Nav()));


  @override
  Widget build(BuildContext context) {
    height1 = MediaQuery.of(context).size.height;
    width1 = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _key,
        drawer: openDrawer(),
        backgroundColor: Colors.grey.withOpacity(0.05),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PetProfile()));
          },
          child: SvgPicture.asset(
            "images/pet.svg",
            color: Colors.white,
            height: height1 * 0.03,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: height1,
              width: width1,
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: height1 * 0.1,
                    width: width1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => _key.currentState!.openDrawer(),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage("images/profile.jpg"),
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "images/logo.png",
                              height: height1 * 0.05,
                            ),
                            SizedBox(
                              height: height1 * 0.02,
                            ),
                            Text(
                              appName,
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Futura"),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => RemainderScreen()));
                            },
                            icon: Icon(
                              CupertinoIcons.bell_fill,
                              color: primaryColor,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: PhysicalModel(
                      elevation: 5,
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                      child: InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(screen: "home"))),
                        child: Container(
                          height: height1 * 0.3,
                          width: width1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage("images/petcare.jpg",),
                              fit: BoxFit.cover,
                              opacity: 0.8
                            )
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                  bottom: 30,
                                  left: 10,
                                  child: Text(
                                    "Watch Videos for Pet Care",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Futura',
                                        fontSize: 20,
                                        letterSpacing: 1),
                                  )),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  getText("Services", ""),
                  SizedBox(
                    height: height1 * 0.01,
                  ),
                  Container(
                    height: height1 * 0.18,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: servicesText.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                setState(() {
                                  servicesIndex = index;
                                  if (index == 0) services = "Veterinary";
                                  if (index == 1) services = "Walking";
                                });
                              },
                              child: getServices(servicesIcon[index],
                                  servicesText[index], index));
                        }),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SeeAll(
                                      service: services,
                                    )));
                      },
                      child: getText(
                          "Nearby ${servicesText[servicesIndex]}", "See All")),
                  SizedBox(
                    height: height1 * 0.01,
                  ),
                  if (services == "Veterinary") VeterinaryList(),
                  if (services == "Walking") WalkingList()
                ],
              ),
            ),
          ),
        ));
  }

  Widget getServices(IconData icon, String text, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            elevation: 5,
            color: Colors.black.withOpacity(0.3),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              height: height1 * 0.09,
              width: height1 * 0.09,
              decoration: BoxDecoration(
                  color: servicesIndex != index ? Colors.white : null,
                  gradient: servicesIndex == index
                      ? LinearGradient(
                          colors: [primaryColor, secondaryColor],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)
                      : null,
                  borderRadius: BorderRadius.circular(15)),
              child: Center(
                  child: Icon(icon,
                      size: 30,
                      color: servicesIndex == index
                          ? Colors.white
                          : Colors.black)),
            ),
          ),
        ),
        Text(
          text,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
        )
      ],
    );
  }

  Widget getText(String text, String subText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Text(
          subText,
          style: TextStyle(color: Colors.grey.shade500, fontSize: 15),
        )
      ],
    );
  }

  Widget openDrawer() {
    return Drawer(
        elevation: 2,
        backgroundColor: Colors.white,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height1*0.04,),
              CircleAvatar(
                backgroundImage: AssetImage("images/profile.jpg"),
                radius: height1 * 0.06,
              ),
              SizedBox(
                height: height1 * 0.01,
              ),
              SizedBox(
                height: height1 * 0.02,
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: height1 * 0.02,
              ),
              TextButton(
                onPressed: () async {
                  if (await checkIfVetExists()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShowServices(role: "vet")));
                  } else if (await checkIfWalkExists()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShowServices(role: "walk")));
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Services()));
                  }
                },
                child: Text(
                  "My Service",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                height: height1 * 0.01,
              ),
              TextButton(
                onPressed: signOut,
                child: Text(
                  "Log Out",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ));
  }

  Future signOut()async{
    await FirebaseAuth.instance.signOut().then((value) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login()), (route) => false));
  }

  Future<bool> checkIfVetExists() async {
    try {
      var collectionRef = FirebaseFirestore.instance.collection('vetService');

      var doc = await collectionRef.doc(user?.uid).get();
      return doc.exists;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> checkIfWalkExists() async {
    try {
      var collectionRef = FirebaseFirestore.instance.collection('walkService');

      var doc = await collectionRef.doc(user?.uid).get();
      return doc.exists;
    } catch (e) {
      throw e;
    }
  }

  Stream<List<RemainderModel>> readUsers() => FirebaseFirestore.instance
      .collection("remainder")
      .doc(user?.uid).collection("remainders")
      .snapshots()
      .map((snapshot) => snapshot.docs
      .map((doc) => RemainderModel.fromJson(doc.data()))
      .toList());
}
