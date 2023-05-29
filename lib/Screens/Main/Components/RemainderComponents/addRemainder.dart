import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petcare/Model/remainderModel.dart';

import '../../../../constants.dart';
import '../../../../services/notification_api.dart';

class AddRemainder extends StatefulWidget {
  const AddRemainder({Key? key}) : super(key: key);

  @override
  State<AddRemainder> createState() => _AddRemainderState();
}

class _AddRemainderState extends State<AddRemainder> {
  User? user = FirebaseAuth.instance.currentUser;

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  DateTime dateTime = DateTime.now();
  TimeOfDay now =
      TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute + 1);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  
  static int ids = 0;



  @override
  Widget build(BuildContext context) {
    var height1 = MediaQuery.of(context).size.height;
    var width1 = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text(
          "Add Remainder",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Futura",
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 1,
      ),
      body: Container(
        height: height1,
        width: width1,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Title",
              style: TextStyle(
                  color: Colors.black, fontSize: 14, fontFamily: "Futura"),
            ),
            SizedBox(
              height: height1 * 0.01,
            ),
            TextField(
              controller: title,
              decoration: InputDecoration(
                  hintText: "Title of remainder",
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  contentPadding: EdgeInsets.all(10),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade200))),
            ),
            SizedBox(
              height: height1 * 0.03,
            ),
            Text(
              "Description",
              style: TextStyle(
                  color: Colors.black, fontSize: 14, fontFamily: "Futura"),
            ),
            SizedBox(
              height: height1 * 0.01,
            ),
            TextField(
              maxLines: 5,
              controller: description,
              decoration: InputDecoration(
                  hintText: "Description of remainder",
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  contentPadding: EdgeInsets.all(10),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade200))),
            ),
            SizedBox(
              height: height1 * 0.03,
            ),
            InkWell(
                onTap: () async {
                  var selected = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
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
                      'Date',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                      size: 18,
                    ),
                  ],
                )),
            SizedBox(
              height: height1 * 0.03,
            ),
            InkWell(
              onTap: () async {
                TimeOfDay? newTime =
                    await showTimePicker(context: context, initialTime: now);
                if (newTime == null) return;
                setState(() => now = newTime);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Time',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.black,
                    size: 18,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height1 * 0.03,
            ),
            Center(
              child: InkWell(
                onTap: (){
                  addRemainder();
                  notification();
                },
                child: Container(
                  width: width1 / 1.2,
                  height: height1 * 0.05,
                  child: Center(
                    child: Text(
                      'Add Remainder',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: primaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future addRemainder() async {
    try {
      String id = FirebaseFirestore.instance
          .collection("remainder")
          .doc(user?.uid)
          .collection("remainders")
          .doc()
          .id;
      final doc = FirebaseFirestore.instance
          .collection("remainder")
          .doc(user?.uid)
          .collection("remainders")
          .doc(id);
      ids = dateTime.hour.toInt();
      final remainderModel = RemainderModel(
        docId: id,
          title: title.text.trim(),
          dateTime: dateTime.day.toString() +
          '/' +
          dateTime.month.toString() +
          '/' +
          dateTime.year.toString(), time : now.hourOfPeriod.toString() + ":" + now.minute.toString() + now.period.name, body: description.text.trim());
      final json = remainderModel.toJson();
      await doc.set(json, SetOptions(merge: true));
    } catch (e) {
      print(e.toString());
    }
    Navigator.pop(context);
  }

  notification(){
    NotificationApi.showScheduleNotification(
      id: ids,
          title: title.text,
            body: description.text,
            payload: user?.uid,
            scheduledDate: DateTime(dateTime.year,dateTime.month,dateTime.day,now.hour,now.minute)
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
