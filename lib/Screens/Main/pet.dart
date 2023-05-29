import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petcare/Model/constants.dart';
import 'package:petcare/Model/petModel.dart';
import 'package:petcare/Screens/Main/petprofile.dart';
import 'package:petcare/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class Pet extends StatefulWidget {
  Pet({Key? key}) : super(key: key);
  int index = 0;
  @override
  State<Pet> createState() => _PetState();
}

class _PetState extends State<Pet> {

  User? user = FirebaseAuth.instance.currentUser;
  getData() async {
    DocumentSnapshot data = await FirebaseFirestore.instance.collection("Pet").doc(user?.uid).get();
    var index = ((data.data() as Map<String, dynamic>).keys.toList().length.toInt());
    widget.index = index;
  }

  int feedingSchedule = -1, alone = -1, medication = -1;
  String pet = "";

  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController breed = TextEditingController();
  TextEditingController vetInfo = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,color: Colors.black,),
        ),
        title: Text("Add a Pet",style: TextStyle(color: Colors.black,fontFamily: "Futura",fontWeight: FontWeight.w200),),
        centerTitle: true,
        actions: [
          TextButton(onPressed: (){
            writeData();
            Navigator.pop(context);
          }, child: Text("Save",style: TextStyle(color: primaryColor,fontSize: 17,fontWeight: FontWeight.bold),))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              displayText('About your Pet', 18.0, FontWeight.bold),
              SizedBox(
                height: height * 0.07,
              ),
              displayText('Name of Pet', 16.0, FontWeight.normal),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey.shade200))),
                child: TextField(
                  controller: name,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                      hintText: "Write Name Here",
                      hintStyle:
                      TextStyle(color: Colors.grey, fontSize: 14.0),
                      border: InputBorder.none),
                ),
              ),
              displayText('Age', 16.0, FontWeight.normal),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey.shade200))),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: age,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                      hintText: "Months",
                      hintStyle:
                      TextStyle(color: Colors.grey, fontSize: 14.0),
                      border: InputBorder.none),
                ),
              ),
              SizedBox(height: height*0.01,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width * 0.35,
                    height: height * 0.09,
                    child: RaisedButton(
                        color: Colors.white,
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          setState(() {
                            pet = "cat";
                          });
                        },
                        child: Ink(
                            decoration: BoxDecoration(
                              color: pet != "cat" ? Colors.white : null,
                              gradient: pet == "cat"? LinearGradient(
                                  colors: [
                                    primaryColor,
                                    secondaryColor
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter
                              ):null,
                              borderRadius: BorderRadius.circular(width * 0.01),),
                          child: Container(
                            width: width * 0.35,
                            height: height * 0.09,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset("images/cat.svg",color: pet != "cat" ? primaryColor : Colors.white,height: height*0.04,),
                                Text('Cat',style: TextStyle(color: pet != "cat" ? Colors.black : Colors.white),),
                              ],
                            ),
                          ),
                        )),
                  ),
                  SizedBox(width: width * 0.01),
                  SizedBox(
                    width: width * 0.35,
                    height: height * 0.09,
                    child: RaisedButton(
                        color: Colors.white,
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          setState(() {
                            pet = "dog";
                          });
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                            color: pet != "dog" ? Colors.white : null,
                            gradient: pet == "dog"? LinearGradient(
                                colors: [
                                  primaryColor,
                                  secondaryColor
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter
                            ):null,
                            borderRadius: BorderRadius.circular(width * 0.01),),
                          child: Container(
                            width: width * 0.35,
                            height: height * 0.09,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset("images/dog.svg",color: pet != "dog" ? primaryColor : Colors.white,height: height*0.04,),
                                Text('Dog',style: TextStyle(color: pet != "dog" ? Colors.black : Colors.white),),
                              ],
                            ),
                          ),
                        )),
                  ),
                ],
              ),
              SizedBox(height: height * 0.03),
              displayText('Breed', 16.0, FontWeight.normal),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey.shade200))),
                child: TextField(
                  controller: breed,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                      hintText: "Enter breed here",
                      hintStyle:
                      TextStyle(fontSize: 14.0, color: Colors.grey),
                      border: InputBorder.none),
                ),
              ),
              SizedBox(height: height * 0.03),
              Row(
                children: [
                  Icon(
                    Icons.monitor_heart,
                    color: primaryColor,
                    size: 18,
                  ),
                  displayText('Care Info', 16.0, FontWeight.bold),
                ],
              ),
              SizedBox(
                height: height * 0.03,
              ),
              displayText('Feeding Schedule', 16.0, FontWeight.normal),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                children: [
                  SizedBox(
                    height: height*0.04,
                    width: width*0.25,
                    child: RaisedButton(
                      color: Colors.white,
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        setState(() {
                          feedingSchedule = 0;
                        });
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0),
                          color: feedingSchedule != 0 ? Colors.white : null,
                          gradient: feedingSchedule == 0 ? LinearGradient(
                              colors: [
                                primaryColor,
                                secondaryColor
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter
                          ):null,
                        ),
                        child: Container(
                          height: height*0.04,
                          width: width*0.25,
                          child: Center(
                              child: Text("Morning",style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: feedingSchedule == 0 ? Colors.white : primaryColor),)),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  SizedBox(
                    height: height*0.04,
                    width: width*0.25,
                    child: RaisedButton(
                      color: Colors.white,
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        setState(() {
                          feedingSchedule = 1;
                        });
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0),
                          color: feedingSchedule != 1 ? Colors.white : null,
                          gradient: feedingSchedule == 1 ? LinearGradient(
                              colors: [
                                primaryColor,
                                secondaryColor
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter
                          ):null,
                        ),
                        child: Container(
                          height: height*0.04,
                          width: width*0.25,
                          child: Center(
                              child: FittedBox(child: Text("Twice a Day",style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: feedingSchedule == 1 ? Colors.white : primaryColor),))),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  SizedBox(
                    height: height*0.04,
                    width: width*0.25,
                    child: RaisedButton(
                      color: Colors.white,
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        setState(() {
                          feedingSchedule = 2;
                        });
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0),
                          color: feedingSchedule != 2 ? Colors.white : null,
                          gradient: feedingSchedule == 2 ? LinearGradient(
                              colors: [
                                primaryColor,
                                secondaryColor
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter
                          ):null,
                        ),
                        child: Container(
                          height: height*0.04,
                          width: width*0.25,
                          child: Center(
                              child: FittedBox(child: Text("More than 3",style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: feedingSchedule == 2 ? Colors.white : primaryColor),)))
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.03,
              ),
              displayText('Can be left alone', 16.0, FontWeight.normal),
              SizedBox(
                height: height * 0.03,
              ),
              Row(
                children: [
                  SizedBox(
                    height: height*0.04,
                    width: width*0.25,
                    child: RaisedButton(
                      color: Colors.white,
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        setState(() {
                          alone = 0;
                        });
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0),
                          color: alone != 0 ? Colors.white : null,
                          gradient: alone == 0 ? LinearGradient(
                              colors: [
                                primaryColor,
                                secondaryColor
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter
                          ):null,
                        ),
                        child: Container(
                            height: height*0.04,
                            width: width*0.25,
                            child: Center(
                                child: Text("< 1 Hour",style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: alone == 0 ? Colors.white : primaryColor),))
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  SizedBox(
                    height: height*0.04,
                    width: width*0.25,
                    child: RaisedButton(
                      color: Colors.white,
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        setState(() {
                          alone = 1;
                        });
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0),
                          color: alone != 1 ? Colors.white : null,
                          gradient: alone == 1 ? LinearGradient(
                              colors: [
                                primaryColor,
                                secondaryColor
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter
                          ):null,
                        ),
                        child: Container(
                            height: height*0.04,
                            width: width*0.25,
                            child: Center(
                                child: Text("1.5 Hour",style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: alone == 1 ? Colors.white : primaryColor),))
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  SizedBox(
                    height: height*0.04,
                    width: width*0.25,
                    child: RaisedButton(
                      color: Colors.white,
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        setState(() {
                          alone = 2;
                        });
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0),
                          color: alone != 2 ? Colors.white : null,
                          gradient: alone == 2 ? LinearGradient(
                              colors: [
                                primaryColor,
                                secondaryColor
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter
                          ):null,
                        ),
                        child: Container(
                            height: height*0.04,
                            width: width*0.25,
                            child: Center(
                                child: Text(">1.5",style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: alone == 2 ? Colors.white : primaryColor),))
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.03,
              ),
              displayText('Medication', 16.0, FontWeight.normal),
              SizedBox(
                height: height * 0.03,
              ),
              Row(
                children: [
                  SizedBox(
                    height: height*0.04,
                    width: width*0.25,
                    child: RaisedButton(
                      color: Colors.white,
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        setState(() {
                          medication = 0;
                        });
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0),
                          color: medication != 0 ? Colors.white : null,
                          gradient: medication == 0 ? LinearGradient(
                              colors: [
                                primaryColor,
                                secondaryColor
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter
                          ):null,
                        ),
                        child: Container(
                            height: height*0.04,
                            width: width*0.25,
                            child: Center(
                                child: Text("Pill",style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: medication == 0 ? Colors.white : primaryColor),))
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  SizedBox(
                    height: height*0.04,
                    width: width*0.25,
                    child: RaisedButton(
                      color: Colors.white,
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        setState(() {
                          medication = 1;
                        });
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0),
                          color: medication != 1 ? Colors.white : null,
                          gradient: medication == 1 ? LinearGradient(
                              colors: [
                                primaryColor,
                                secondaryColor
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter
                          ):null,
                        ),
                        child: Container(
                            height: height*0.04,
                            width: width*0.25,
                            child: Center(
                                child: Text("Topical",style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: medication == 1 ? Colors.white : primaryColor),))
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  SizedBox(
                    height: height*0.04,
                    width: width*0.25,
                    child: RaisedButton(
                      color: Colors.white,
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        setState(() {
                          medication = 2;
                        });
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0),
                          color: medication != 2 ? Colors.white : null,
                          gradient: medication == 2 ? LinearGradient(
                              colors: [
                                primaryColor,
                                secondaryColor
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter
                          ):null,
                        ),
                        child: Container(
                            height: height*0.04,
                            width: width*0.25,
                            child: Center(
                                child: Text("Injection",style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: medication == 2 ? Colors.white : primaryColor),))
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.1,
              ),
              Row(
                children: [
                  Icon(
                    Icons.monitor_heart,
                    color: primaryColor,
                    size: 18,
                  ),
                  displayText('Veterinary Info', 16.0, FontWeight.bold),
                ],
              ),
              Container(
                width: width * 0.8,
                height: height * 0.3,
                child: TextField(
                  controller: vetInfo,
                  maxLines: 6,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                      hintText: "Provide Veterinary Info",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget displayText(String text, double size, FontWeight weight) {
    return Text(
      text,
      style:
      TextStyle(color: primaryColor, fontWeight: weight, fontSize: size),
    );
  }

  Future writeData() async {
    try{
      String id = FirebaseFirestore.instance.collection("Pet").doc(user?.uid).collection("Pets").doc().id;
      final doc = FirebaseFirestore.instance.collection("Pet").doc(user?.uid).collection("Pets").doc(id);
      final pet1 = PetData(
          pet: pet,
          name: name.text.toString().trim(),
          age: age.text.toString().trim(),
          breed: breed.text.toString().trim(),
          feeding: feedingScheduleL[feedingSchedule],
          alone: aloneL[alone],
          medication: medicationL[medication],
          vetInfo: vetInfo.text.toString().trim());
      final json = pet1.toJson();
      await doc.set(json);
    }catch (e){
      print("hello"+e.toString());
    }

  }


}
