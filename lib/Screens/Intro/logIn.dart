import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petcare/Screens/Intro/signUp.dart';
import 'package:petcare/Screens/Main/nav.dart';

import '../../constants.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  var height1;
  var width1;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    height1 = MediaQuery.of(context).size.height;
    width1 = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        height: height1,
        width: width1,
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height1*0.1,),
              Text("Log in",style: TextStyle(fontFamily: "Futura",color: Colors.black,fontSize: 18, fontWeight: FontWeight.bold),),
              sizedH(0.03),
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
                      await signin();
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
                  Text("No account? "),
                  InkWell(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUp()));
                      },
                      child: Text("Register here",style: TextStyle(color: primaryColor),)),
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
  Future signin() async {
    try{
      if(_key.currentState!.validate())
      {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text.trim(), password: pass.text.trim()).then((value) => ScaffoldMessenger.of(context).showSnackBar(customSnackBar(content: "Logged in successfully!"))).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => Nav())));
      }
    } on FirebaseAuthException catch (e){
      if(e.message == 'There is no user record corresponding to this identifier. The user may have been deleted.'){
        ScaffoldMessenger.of(context).showSnackBar(customSnackBar(content: "Invalid e-mail address."));
      }else if(e.message == 'The password is invalid or the user does not have a password.'){
        ScaffoldMessenger.of(context).showSnackBar(customSnackBar(content: "Invalid password."));
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

    if(formPass == "Invalid Password")
      return "Invalid Password";
    return null;
  }
}
