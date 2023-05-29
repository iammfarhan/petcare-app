import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petcare/Model/serviceModel.dart';

import '../../../../constants.dart';

class VeterinaryService extends StatefulWidget {
  @override
  State<VeterinaryService> createState() => _VeterinaryServiceState();
}

class _VeterinaryServiceState extends State<VeterinaryService> {
  User? user = FirebaseAuth.instance.currentUser;

  TextEditingController fullName = TextEditingController();
  TextEditingController profession = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController clinicName = TextEditingController();
  TextEditingController clinicLocation = TextEditingController();
  TextEditingController about = TextEditingController();

  TimeOfDay from =
      TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute);
  TimeOfDay to =
      TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute);
  int tempF = 0, tempT = 0;

  @override
  Widget build(BuildContext context) {
    var height1 = MediaQuery.of(context).size.height;
    var width1 = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: fullName,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            label: Text("Full Name"),
          ),
        ),
        SizedBox(
          height: height1 * 0.02,
        ),
        TextFormField(
          controller: profession,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            label: Text("Field of Profession"),
          ),
        ),
        SizedBox(
          height: height1 * 0.02,
        ),
        TextFormField(
          controller: price,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            label: Text("Price per appointment"),
          ),
        ),
        SizedBox(
          height: height1 * 0.02,
        ),
        TextFormField(
          controller: clinicName,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            label: Text("Clinic Name"),
          ),
        ),
        SizedBox(
          height: height1 * 0.02,
        ),
        TextFormField(
          controller: clinicLocation,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            label: Text("Clinic Location"),
          ),
        ),
        SizedBox(
          height: height1 * 0.02,
        ),
        TextFormField(
          controller: about,
          maxLines: 5,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            label: Align(alignment: Alignment.topLeft, child: Text("About")),
          ),
        ),
        SizedBox(
          height: height1 * 0.02,
        ),
        Container(
          height: height1 * 0.06,
          width: width1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              displayText("Available"),
              Row(
                children: [
                  InkWell(
                      onTap: () async {
                        TimeOfDay? newTime = await showTimePicker(
                            context: context, initialTime: from);
                        if (newTime == null) return;
                        setState(() => from = newTime);
                        tempF = 1;
                      },
                      child: PhysicalModel(
                        elevation: 3,
                        color: Colors.grey.withOpacity(0.1),
                        child: Container(
                            height: height1 * 0.04,
                            width: width1 * 0.15,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 3.0, vertical: 1),
                              child: Center(
                                  child: FittedBox(
                                child: Text(
                                  tempF == 0
                                      ? "From"
                                      : from.hour.toString() +
                                          " : " +
                                          from.minute.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Futura",
                                      fontSize: 14),
                                ),
                              )),
                            )),
                      )),
                  Text(
                    " - ",
                    style: TextStyle(fontSize: 18),
                  ),
                  InkWell(
                      onTap: () async {
                        TimeOfDay? newTime = await showTimePicker(
                            context: context, initialTime: to);
                        if (newTime == null) return;
                        setState(() => to = newTime);
                        tempT = 1;
                      },
                      child: PhysicalModel(
                        elevation: 3,
                        color: Colors.grey.withOpacity(0.1),
                        child: Container(
                            height: height1 * 0.04,
                            width: width1 * 0.15,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 3.0, vertical: 1),
                              child: Center(
                                  child: FittedBox(
                                child: Text(
                                  tempT == 0
                                      ? "To"
                                      : to.hour.toString() +
                                          " : " +
                                          to.minute.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Futura",
                                      fontSize: 14),
                                ),
                              )),
                            )),
                      )),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: height1 * 0.01,
        ),
        SizedBox(
          height: height1 * 0.06,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              onPressed: writeData,
              child: Center(
                child: Text("Save"),
              )),
        ),
      ],
    );
  }

  displayText(String text) {
    return Text(
      text,
      style: TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.bold,
          fontFamily: "Futura",
          fontSize: 15,
          letterSpacing: 0.5),
    );
  }

  Future writeData() async {
    try {
      getData();
      final doc =
          FirebaseFirestore.instance.collection("vetService").doc(user?.uid);
      final requestModel = ServiceModel(
        id: user?.uid,
          profession: profession.text.trim(),
          clinicLocation: clinicLocation.text.trim(),
          clinicName: clinicName.text.trim(),
          about: about.text,
          fromTime: from.hour.toString() + from.period.name,
          toTime: to.hour.toString() + to.period.name,
          price: price.text.trim(),
          fullName: fullName.text.trim());
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

  getData() async {
    DocumentSnapshot data = await FirebaseFirestore.instance.collection("request").doc(user?.uid).get();
    ServiceModel.index = ((data.data() as Map<String, dynamic>).keys.toList().length.toInt());
    ServiceModel.index++;
  }
}
