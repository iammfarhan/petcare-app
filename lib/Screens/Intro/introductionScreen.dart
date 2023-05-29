import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:petcare/Screens/Intro/signUp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    var height1 = MediaQuery.of(context).size.height;
    var width1 = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height1,
        width: width1,
        child: IntroductionScreen(
          done: Text("Next"),
          onDone: (){
            _storeOnboardInfo();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignUp()),(route) => false);
          },
          next: Icon(Icons.arrow_forward),
          skip: Text("Skip"),
          showSkipButton: true,
          pages: [
            PageViewModel(
              decoration: pageDecoration(),
              title: "Find Sitters & Walkers",
              body: "Easily connect with pet lovers and sitters you can trust",
              image: Lottie.asset("assets/dogwalking.json"),
            ),PageViewModel(
              decoration: pageDecoration(),
              title: "Smart Search!",
              body: "Request your desired pet services & receive  response within minutes",
              image: Lottie.asset("assets/request.json"),
            ),PageViewModel(
              decoration: pageDecoration(),
              title: "Veterinary Care",
              body: "Choose from a list of experienced vets & select the appointent tht suits you",
              image: Image.asset("images/Veterinary.jpg"),
            ),
          ],
        ),
      ),
    );
  }
  PageDecoration pageDecoration(){
    return PageDecoration(
      bodyPadding: EdgeInsets.symmetric(horizontal: 10),
      titleTextStyle: TextStyle(fontFamily: "Futura", )
    );
}
  _storeOnboardInfo() async {
    print("Shared pref called");
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    print(prefs.getInt('onBoard'));
  }
}
