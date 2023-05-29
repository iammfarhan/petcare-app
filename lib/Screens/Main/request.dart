import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petcare/Model/requestModel.dart';

import '../../constants.dart';
import 'Components/requestPage.dart';

class Request extends StatefulWidget {
  const Request({Key? key}) : super(key: key);

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  User? user = FirebaseAuth.instance.currentUser;
  bool a = true;
  var height1;
  var width1;
  @override
  Widget build(BuildContext context) {
    height1 = MediaQuery.of(context).size.height;
    width1 = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Requests",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontFamily: "Futura"),
          ),
          centerTitle: true,
          backgroundColor: primaryColor,
          elevation: 0,
          leading: SizedBox(),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: primaryColor,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RequestPage()));
            },
            child: Icon(
              Icons.add,
              size: 20,
            )),
        body: SingleChildScrollView(
          child: Container(
            height: height1,
            width: width1,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Your Requests"),
                StreamBuilder<List<RequestModel>>(
                  stream: readUsers(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return noRequest();
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else if (snapshot.hasData) {
                      final users = snapshot.data!;
                      return Container(
                          height: height1 * 0.4,
                          width: width1,
                          child: ListView(
                              children: users.map(yourRequests).toList()));
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                Text("Others Requests"),
                StreamBuilder<List<RequestModel>>(
                  stream: readAllUsers(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text("No requests to show");
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else if (snapshot.hasData) {
                      final users = snapshot.data!;
                      return SizedBox(
                        height: height1/2.2,
                          child: ListView(
                              children: users.map(allRequests).toList()));
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }

  Widget allRequests(RequestModel request) => Container(
    width: width1,
    padding: EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PhysicalModel(
          elevation: 3,
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)),
            height: height1 * 0.2,
            width: width1 / 1.5,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.medical_services,
                      color: Colors.green,
                      size: height1 * 0.07,
                    ),
                    SizedBox(
                      width: width1 * 0.02,
                    ),
                    Text(
                      request.service,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Futura"),
                    ),
                  ],
                ),
                Text(request.message),
              ],
            ),
          ),
        ),
        PhysicalModel(
          elevation: 3,
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
          child: InkWell(
            onTap: (){
              acceptRequest(request);
              deleteAllRequest(request);
            },
            child: Container(
              height: height1 * 0.07,
              width: height1 * 0.07,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(15)),
              child: Center(
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: height1 * 0.04,
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );

  Widget yourRequests(RequestModel request) => Container(
        width: width1,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PhysicalModel(
              elevation: 3,
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                height: height1 * 0.15,
                width: width1 / 1.5,
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          request.service == "Veterinary" ? Icons.medical_services : FontAwesomeIcons.personWalking,
                          color: Colors.green,
                          size: height1 * 0.07,
                        ),
                        SizedBox(
                          width: width1 * 0.02,
                        ),
                        Text(
                          request.service,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Futura"),
                        ),
                      ],
                    ),
                    Text(request.message,overflow: TextOverflow.ellipsis,),
                  ],
                ),
              ),
            ),
            PhysicalModel(
              elevation: 3,
              color: Colors.black,
              borderRadius: BorderRadius.circular(15),
              child: InkWell(
                onTap: (){
                  deleteRequest(request);
                },
                child: Container(
                  height: height1 * 0.07,
                  width: height1 * 0.07,
                  decoration: BoxDecoration(
                      color: Colors.red, borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: height1 * 0.04,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );

  Widget noRequest() => Container(
        padding: EdgeInsets.symmetric(horizontal: height1 * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height1 * 0.04,
            ),
            Text(
              "No Requests yet!",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            SizedBox(
              height: height1 * 0.04,
            ),
          ],
        ),
      );

  Stream<List<RequestModel>> readUsers() => FirebaseFirestore.instance
      .collection("request")
      .doc(user?.uid)
      .collection("requests")
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => RequestModel.fromJson(doc.data()))
          .toList());

  Stream<List<RequestModel>> readAllUsers() => FirebaseFirestore.instance
      .collection("allRequest").where("id",isNotEqualTo: user?.uid)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => RequestModel.fromJson(doc.data()))
          .toList());

  acceptRequest(RequestModel request){
    FirebaseFirestore.instance.collection("request").doc(request.id).collection("requests").doc(request.docId).update({"respond" : user?.uid});
  }

  deleteRequest(RequestModel request){
    FirebaseFirestore.instance.collection("request").doc(request.id).collection("requests").doc(request.docId).delete();
    FirebaseFirestore.instance.collection("allRequest").doc(request.docId).delete();
  }

  deleteAllRequest(RequestModel request){
    FirebaseFirestore.instance.collection("allRequest").doc(request.docId).delete();
  }
}
