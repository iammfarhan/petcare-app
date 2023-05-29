import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petcare/Model/dietModel.dart';
import 'package:petcare/Screens/Main/Components/requestPage.dart';
import 'package:petcare/constants.dart';

class MakeDiet extends StatefulWidget {
  const MakeDiet({Key? key}) : super(key: key);

  @override
  State<MakeDiet> createState() => _MakeDietState();
}

class _MakeDietState extends State<MakeDiet> {

  User? user = FirebaseAuth.instance.currentUser;

  TextEditingController nameDiet = TextEditingController();
  TextEditingController description = TextEditingController();

  bool dog =  false;
  bool cat = false;
  int dogCount = 0, catCount = 0;

  @override
  Widget build(BuildContext context) {
    var height1 = MediaQuery.of(context).size.height;
    var width1 = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(onPressed: () => Navigator.pop(context),icon: Icon(Icons.arrow_back_ios,color: Colors.white,),),
        title: Text("Make Diet",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily: "Futura"),),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 1,
        actions: [
          Padding(padding: EdgeInsets.all(10),
            child: TextButton(onPressed: writeData,child: Text("Save",style: TextStyle(color: Colors.white,fontFamily: "Futura",),),),
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height1*0.05,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width1 * 0.35,
                  height: height1 * 0.09,
                  child: RaisedButton(
                      color: Colors.white,
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        setState(() {
                          catCount++;
                          if(catCount % 2 != 0){
                            cat = true;
                          }else{
                            cat = false;
                          }
                        });
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          color: !cat ? Colors.white : null,
                          gradient: cat ? LinearGradient(
                              colors: [
                                primaryColor,
                                secondaryColor
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter
                          ):null,
                          borderRadius: BorderRadius.circular(width1 * 0.01),),
                        child: Container(
                          width: width1 * 0.35,
                          height: height1 * 0.09,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset("images/cat.svg",color: !cat ? primaryColor : Colors.white,height: height1*0.04,),
                              Text('Cat',style: TextStyle(color: !cat ? Colors.black : Colors.white),),
                            ],
                          ),
                        ),
                      )),
                ),
                SizedBox(width: width1 * 0.01),
                SizedBox(
                  width: width1 * 0.35,
                  height: height1 * 0.09,
                  child: RaisedButton(
                      color: Colors.white,
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        setState(() {
                          dogCount++;
                          if(dogCount % 2 != 0){
                            dog = true;
                          }else{
                            dog = false;
                          }
                        });
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          color: !dog ? Colors.white : null,
                          gradient: dog ? LinearGradient(
                              colors: [
                                primaryColor,
                                secondaryColor
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter
                          ):null,
                          borderRadius: BorderRadius.circular(width1 * 0.01),),
                        child: Container(
                          width: width1 * 0.35,
                          height: height1 * 0.09,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset("images/dog.svg",color: !dog ? primaryColor : Colors.white,height: height1*0.04,),
                              Text('Dog',style: TextStyle(color: !dog ? Colors.black : Colors.white),),
                            ],
                          ),
                        ),
                      )),
                ),
              ],
            ),
            SizedBox(height: height1*0.02,),
            getText("Name"),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                  border: Border(
                      bottom: BorderSide(color: Colors.grey.shade200))),
              child: TextField(
                controller: nameDiet,
                onChanged: (value) {},
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    hintText: "Name of Diet",
                    hintStyle:
                    TextStyle(color: Colors.grey, fontSize: 14.0),
                    border: InputBorder.none),
              ),
            ),
            getText("Description"),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                  border: Border(
                      bottom: BorderSide(color: Colors.grey.shade200))),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: description,
                  onChanged: (value) {},
                  maxLines: 6,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      hintText: "Write description of the diet...",
                      hintStyle:
                      TextStyle(color: Colors.grey, fontSize: 14.0),
                      border: InputBorder.none),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  getText(String s) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(s,style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold,fontFamily: "Futura",fontSize: 15,letterSpacing: 0.5),),
    );
  }

  Future writeData() async {
    try {
      String id = FirebaseFirestore.instance.collection("diet").doc(user?.uid).collection("diets").doc().id;
      final doc = FirebaseFirestore.instance.collection("diet").doc(user?.uid).collection("diets").doc(id);
      final requestModel = DietModel(dog: dog.toString(), cat: cat.toString(), dietName: nameDiet.text.trim(), description: description.text.trim());
      final json = requestModel.toJson();
      await doc.set(json, SetOptions(merge: true));
    } catch (e) {
      print(e.toString());
    }
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
