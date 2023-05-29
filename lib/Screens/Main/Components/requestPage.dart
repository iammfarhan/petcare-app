import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petcare/Model/requestModel.dart';
import 'package:petcare/constants.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  TextEditingController message = TextEditingController();

  String dropdownvalue = 'Veterinary';
  String locationValue = 'Islamabad';
  int walks = 1;
  bool pet = false;

  DateTime dateTime = DateTime.now();

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var height1 = MediaQuery.of(context).size.height;
    var width1 = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Make a Request",
          style: TextStyle(color: Colors.black87, fontFamily: "Futura"),
        ),
        actions: [
          Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                  child: TextButton(onPressed: writeData,child: Text(
                    "Save",
                    style: TextStyle(
                        color: primaryColor, fontSize: 15, fontFamily: "Futura"),
                  ),)
              ))
        ],
        elevation: 1,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        height: height1,
        width: width1,
        color: Colors.grey.withOpacity(0.05),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getText("Type of Service"),
                  Container(
                    color: Colors.white,
                    width: width1,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(
                          servicesIcon[servicesText.indexOf(dropdownvalue)],
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: width1 * 0.03,
                        ),
                        SizedBox(
                          width: width1 / 1.2,
                          child: DropdownButton(
                            underline: SizedBox(),
                            isExpanded: true,
                            value: dropdownvalue,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: servicesText.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  getText("Service Dates"),
                  Container(
                    width: width1,
                    color: Colors.white,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            var selected = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1960),
                              lastDate: DateTime(2030),
                            );
                            if (selected != null && selected != dateTime)
                              setState(() {
                                dateTime = selected;
                              });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                dateTime != null
                                    ? (dateTime.day.toString() +
                                        '/' +
                                        dateTime.month.toString() +
                                        '/' +
                                        dateTime.year.toString())
                                    : "Dates",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14,
                                    fontFamily: "Futura"),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.black87,
                                size: 12,
                              )
                            ],
                          ),
                        ),
                        if (servicesText[servicesText.indexOf(dropdownvalue)] ==
                            "Walking")
                          Column(
                            children: [
                              SizedBox(
                                height: height1 * 0.03,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Walks per day",
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 14,
                                        fontFamily: "Futura"),
                                  ),
                                  Container(
                                    height: height1 * 0.03,
                                    width: width1 * 0.2,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade400),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (walks > 1) {
                                                walks--;
                                              }
                                            });
                                          },
                                          child: Text(
                                            "-",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: "Futura",
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          walks.toString(),
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: "Futura",
                                            fontSize: 12,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              walks++;
                                            });
                                          },
                                          child: Text(
                                            "+",
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: "Futura",
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                      ],
                    ),
                  ),
                  getText("Address"),
                  Container(
                    color: Colors.white,
                    width: width1,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: width1 * 0.03,
                        ),
                        SizedBox(
                          width: width1 / 1.2,
                          child: DropdownButton(
                            underline: SizedBox(),
                            isExpanded: true,
                            value: locationValue,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: location.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                locationValue = newValue!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  getText("Message"),
                  Container(
                    color: Colors.white,
                    width: width1,
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: message,
                      maxLines: 6,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                          hintText: "Write your message...",
                          hintStyle: TextStyle(
                              color: Colors.grey, fontFamily: "Futura"),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: height1 * 0.1,
                  )
                ],
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
      child: Text(
        s,
        style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontFamily: "Futura",
            fontSize: 15,
            letterSpacing: 0.5),
      ),
    );
  }

  Future writeData() async {
    try {
      String id = FirebaseFirestore.instance.collection("request").doc(user?.uid).collection("requests").doc().id;
      final doc = FirebaseFirestore.instance.collection("request").doc(user?.uid).collection("requests").doc(id);
      final allDoc = FirebaseFirestore.instance.collection("allRequest").doc(id);
      final requestModel = RequestModel(
        respond: "",
        docId : id,
        id: user?.uid,
        date: dateTime.day.toString() +
            '/' +
            dateTime.month.toString() +
            '/' +
            dateTime.year.toString(),
        address: locationValue,
        message: message.text,
        pet: "Alice",
        service: dropdownvalue,
        walk: dropdownvalue == "Walking" ? walks.toString() : "0",
      );
      final json = requestModel.toJson();
      await doc.set(json, SetOptions(merge: true));
      await allDoc.set(json, SetOptions(merge: true));
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
