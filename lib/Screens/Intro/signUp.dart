import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petcare/Screens/Intro/emailVerification.dart';
import 'package:petcare/constants.dart';

import 'logIn.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool terms = false,newsletter = false,loading = false;
  var height1;
  var width1;

  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    height1 = MediaQuery.of(context).size.height;
    width1 = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
        height: height1,
        width: width1,
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height1*0.1,),
              Text("Sign Up",style: TextStyle(fontFamily: "Futura",color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
              sizedH(0.03),
              TextFormField(
                validator: validateName,
                controller: name,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  label: Text("Name"),
                ),
              ),
              sizedH(0.02),
              TextFormField(
                validator: validateEmail,
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                  label: Text("Email"),
                ),
              ),
              sizedH(0.02),
              TextFormField(
                validator: validatePass,
                controller: pass,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Type your password here",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                  label: Text("Password"),
                ),
              ),
              sizedH(0.02),
              loading ? CircularProgressIndicator(color: primaryColor,) : SizedBox(
                height: height1*0.06,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: primaryColor,shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    )),
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      await signup();
                      setState(() {
                        loading = false;
                      });
                    }, child: Center(
                  child: Text("Continue"),
                )),
              ),
              sizedH(0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Already have an account? "),
                  InkWell(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
                    },
                      child: Text("Log In",style: TextStyle(color: primaryColor),)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget sizedH(double height){
    return SizedBox(height: height1*height,);
  }
  Widget sizedW(double width){
    return SizedBox(width: width1*width,);
  }

  Future signup() async {
    try{
      if(_key.currentState!.validate()){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text.trim(), password: pass.text.trim()).whenComplete(() => {
          FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser?.uid).set(
              {
                "name" : name.text.trim(),
                "email" : email.text.trim(),
              })
        }).then((value) => ScaffoldMessenger.of(context).showSnackBar(customSnackBar(content: "Signed up successfully!"))).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => Login())));
      }
      } on FirebaseAuthException catch (e){
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(customSnackBar(content: "An account already exists on this email."));
      }else if(e.message == 'The email address is badly formatted.'){
        ScaffoldMessenger.of(context).showSnackBar(customSnackBar(content: "Invalid e-mail address."));
      }
      print(e.toString());
    }
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

  String? validateEmail(String? formEmail){
    if(formEmail == null || formEmail.isEmpty)
      return "E-mail address is required";

    String pattern = r'\w+@\w+\.\w+';
    RegExp regExp = RegExp(pattern);
    if(!regExp.hasMatch(formEmail))
      return "Invalid Format";

    return null;
  }

  String? validatePass(String? formPass){
    if(formPass == null || formPass.isEmpty)
      return "Password cannot be empty";

    if(formPass.length < 6)
      return "Password must be atleast 6 characters";

    return null;
  }

  String? validateName(String? formName){
    if(formName == null || formName.isEmpty)
      return "Name cannot be empty";

    String pattern = r'^[a-z A-Z]+$';
    RegExp regExp = RegExp(pattern);
    if(!regExp.hasMatch(formName))
      return "Invalid Format";
}
}
