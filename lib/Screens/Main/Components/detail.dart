import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petcare/Model/appointmentModel.dart';
import 'package:petcare/Model/walkingServiceModel.dart';
import 'package:petcare/Screens/Main/home.dart';
import 'package:petcare/Screens/Main/nav.dart';
import 'package:petcare/constants.dart';

import '../../../Model/serviceModel.dart';
import '../../../Model/walkingModel.dart';
import 'VetComponents/vetAppointment.dart';
import 'WalkingComponents/bookWalking.dart';

class Detail extends StatefulWidget {
  final String role;
  ServiceModel user;
  final String screen;
  Detail(
      {Key? key, required this.user, required this.role, required this.screen})
      : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  User? user = FirebaseAuth.instance.currentUser;
  var height1;
  var width1;

  TextEditingController fees = TextEditingController();
  String feeVar = "";
  @override
  Widget build(BuildContext context) {
    print(widget.user.id);
    height1 = MediaQuery.of(context).size.height;
    width1 = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Nav())),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 18,
          ),
        ),
        title: Text(
          widget.user.fullName,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: height1,
        width: width1,
        padding: EdgeInsets.all(15),
        child: Stack(
          children: [
            Hero(
              tag: "image",
              child: Container(
                height: height1 / 2,
                width: width1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage("images/profile.jpg"),
                        fit: BoxFit.fill)),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: height1 / 1.9,
                width: width1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white),
                child: Stack(
                  children: [
                    Positioned(
                        top: 0,
                        child: Container(
                          width: width1,
                          height: height1 * 0.01,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                Colors.black.withOpacity(0.3),
                                Colors.black.withOpacity(0.15),
                                Colors.transparent
                              ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter)),
                        )),
                    ListView(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 10),
                          child: Row(
                            children: [
                              Icon(
                                CupertinoIcons.location_solid,
                                color: primaryColor,
                                size: 30,
                              ),
                              SizedBox(
                                width: width1 * 0.04,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.user.clinicName,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "Futura"),
                                  ),
                                  Text(
                                    widget.user.clinicLocation,
                                    style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "Futura"),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 10),
                          child: Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.graduationCap,
                                color: primaryColor,
                                size: 28,
                              ),
                              SizedBox(
                                width: width1 * 0.04,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.role == "vet"
                                        ? "Veterinary"
                                        : "Expereince",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "Futura"),
                                  ),
                                  Text(
                                    widget.user.profession,
                                    style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "Futura"),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 10),
                          child: Row(
                            children: [
                              Icon(
                                CupertinoIcons.clock_fill,
                                color: primaryColor,
                                size: 28,
                              ),
                              SizedBox(
                                width: width1 * 0.04,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Mon-Fri ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "Futura"),
                                  ),
                                  Text(
                                    widget.user.fromTime +
                                        " - " +
                                        widget.user.toTime,
                                    style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "Futura"),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 10),
                          child: Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.dollarSign,
                                color: primaryColor,
                                size: 28,
                              ),
                              SizedBox(
                                width: width1 * 0.04,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Fees",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "Futura"),
                                  ),
                                  Text(
                                    widget.user.price,
                                    style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "Futura"),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 10),
                          child: Row(
                            children: [
                              Text(
                                "Reviews",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Futura",
                                    fontSize: 15),
                              ),
                              SizedBox(
                                width: width1 * 0.02,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.green,
                                size: 14,
                              ),
                              Text(
                                reviews,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Futura"),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height1 * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            "About",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: height1 * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            widget.user.about,
                            style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        SizedBox(
                          height: height1 * 0.03,
                        ),
                        widget.role == "vet" ? StreamBuilder<List<AppointmentModel>>(
                          stream: widget.screen == "service" ? readRequests() : readUsers(),
                          builder: (context, snapshot) {
                            if(!snapshot.hasData){
                              return Center(child: Text("No Requests!"),);
                            }else if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            } else if (snapshot.hasData) {
                              final users = snapshot.data!;
                              return Container(
                                height: height1*0.2,
                                  child: ListView(children: users.map(allRequests).toList()));
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ) : StreamBuilder<List<WalkingModel>>(
                          stream: widget.screen == "service" ? readWalkRequests() : readWalkUsers(),
                          builder: (context, snapshot) {
                            if(!snapshot.hasData){
                              return Center(child: Text("No Requests!"),);
                            }else if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            } else if (snapshot.hasData) {
                              final users = snapshot.data!;
                              return Container(
                                  height: height1*0.2,
                                  child: ListView(children: users.map(allWalkRequests).toList()));
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: height1 * 0.1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: widget.screen == "service"
                  ? SizedBox()
                  : SizedBox(
                      height: height1 * 0.06,
                      width: width1,
                      child: RaisedButton(
                        color: Colors.white,
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          widget.role == "vet" ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      VetAppointment(user1: widget.user))) : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      BookWalking(user1: widget.user)));
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: primaryColor
                              ),
                          child: Container(
                            height: height1 * 0.06,
                            width: width1,
                            child: Center(
                                child: Text(
                              "Book Appointment",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            )),
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget allRequests(AppointmentModel request) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: PhysicalModel(color: Colors.black,
      elevation: 3,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: width1,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(Icons.medical_services,size: height1*0.07,color: Colors.green,),
                SizedBox(width: width1*0.02,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(request.request == "pending" ? "Coming Up!" : request.request.toUpperCase(),style: TextStyle(color: primaryColor,fontSize: 18,fontWeight: FontWeight.w600,fontFamily: "Futura"),),
                    Text(request.type.toUpperCase(),style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: "Futura")),
                    Text(request.purpose.toUpperCase(),style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: "Futura")),
                    Text(request.time,style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: "Futura")),
                  ],
                )
              ],
            ),
            widget.screen == "service" ? Container(
              height: height1*0.1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height1 * 0.03,
                    width: width1*0.15,
                    child: RaisedButton(
                      color: Colors.white,
                      padding: EdgeInsets.all(0),
                      onPressed: (){
                        showDialog(context: context, builder: (_) => AlertDialog(
                          title: Text("Are you sure to accept the appointment?"),
                          content: TextField(
                            controller: fees,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: "Fees"
                            ),
                          ),
                          actions: [
                            FlatButton(
                                onPressed: (){
                              FirebaseFirestore.instance.collection("vetAppointment").doc(user?.uid).collection("vetAppointments").doc(request.documentId).update({'request' : 'accepted'});
                              FirebaseFirestore.instance.collection("appointment").doc(request.userId).collection("appointments").doc(request.documentId).update({'request' : 'accepted'});
                              FirebaseFirestore.instance.collection("vetAppointment").doc(user?.uid).collection("vetAppointments").doc(request.documentId).delete();
                              FirebaseFirestore.instance.collection("appointment").doc(request.userId).collection("appointments").doc(request.documentId).update({'fees' : fees.text.trim()});
                              Navigator.pop(context);
                            }, child: Text("Yes")),
                            FlatButton(onPressed: () {
                              fees.clear();
                              Navigator.pop(context);
                            }, child: Text("No")),
                          ],
                        ));
                        },
                      child: Ink(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.green
                        ),
                        child: Container(
                          height: height1 * 0.06,
                          width: width1,
                          child: Center(
                              child: FittedBox(
                                child: Text(
                                  "Accept",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white),
                                ),
                              )),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),SizedBox(
                    height: height1 * 0.03,
                    width: width1*0.15,
                    child: RaisedButton(
                      color: Colors.white,
                      padding: EdgeInsets.all(0),
                      onPressed: (){
                        showDialog(context: context, builder: (_) => AlertDialog(
                          title: Text("Refuse!"),
                          content: Text("Are you sure to refuse the appointment?"),
                          actions: [
                            FlatButton(onPressed: (){
                              firebaseQueries(request);
                              Navigator.pop(context);
                            }, child: Text("Yes")),
                            FlatButton(onPressed: () => Navigator.pop(context), child: Text("No")),
                          ],
                        ));
                        // Dialog(
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     children: [
                        //       Text("Do you want to refuse?"),
                        //       Row(
                        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //         children: [
                        //           SizedBox(
                        //             height: height1 * 0.05,
                        //             width: width1*0.2,
                        //             child: RaisedButton(
                        //               color: Colors.white,
                        //               padding: EdgeInsets.all(0),
                        //               onPressed: firebaseQueries(request),
                        //               child: Ink(
                        //                 decoration: BoxDecoration(
                        //                     borderRadius: BorderRadius.circular(5.0),
                        //                     color: Colors.green
                        //                 ),
                        //                 child: Container(
                        //                   height: height1 * 0.06,
                        //                   width: width1,
                        //                   child: Center(
                        //                       child: FittedBox(
                        //                         child: Text(
                        //                           "YES",
                        //                           style: TextStyle(
                        //                               fontSize: 14,
                        //                               fontWeight: FontWeight.normal,
                        //                               color: Colors.white),
                        //                         ),
                        //                       )),
                        //                 ),
                        //               ),
                        //               shape: RoundedRectangleBorder(
                        //                 borderRadius: BorderRadius.circular(5.0),
                        //               ),
                        //             ),
                        //           ),SizedBox(
                        //             height: height1 * 0.05,
                        //             width: width1*0.2,
                        //             child: RaisedButton(
                        //               color: Colors.white,
                        //               padding: EdgeInsets.all(0),
                        //               onPressed: () => Navigator.pop(context),
                        //               child: Ink(
                        //                 decoration: BoxDecoration(
                        //                     borderRadius: BorderRadius.circular(5.0),
                        //                     color: Colors.red
                        //                 ),
                        //                 child: Container(
                        //                   height: height1 * 0.06,
                        //                   width: width1,
                        //                   child: Center(
                        //                       child: FittedBox(
                        //                         child: Text(
                        //                           "NO",
                        //                           style: TextStyle(
                        //                               fontSize: 14,
                        //                               fontWeight: FontWeight.normal,
                        //                               color: Colors.white),
                        //                         ),
                        //                       )),
                        //                 ),
                        //               ),
                        //               shape: RoundedRectangleBorder(
                        //                 borderRadius: BorderRadius.circular(5.0),
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ));
                        },
                      child: Ink(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.red
                        ),
                        child: Container(
                          height: height1 * 0.06,
                          width: width1,
                          child: Center(
                              child: FittedBox(
                                child: Text(
                                  "Refuse",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white),
                                ),
                              )),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ],
              ),
            ): Align(
              alignment: Alignment.center,
              child: SizedBox(child: Column(
                children: [
                  Text("Request ${request.request}!",style: TextStyle(color: Colors.black,fontSize: 14,fontFamily: "Futura"),),
                  SizedBox(height: height1*0.01,),
                  request.request != "accepted" || request.payment != "pending" ? SizedBox() : SizedBox(
                    height: height1 * 0.03,
                    width: width1*0.15,
                    child: RaisedButton(
                      color: Colors.white,
                      padding: EdgeInsets.all(0),
                      onPressed: (){
                        showDialog(context: context, builder: (_) => AlertDialog(
                          title: Text("Payment"),
                          content: Text("You have to pay "+request.fees+" Rs to the vet"),
                          actions: [
                            SizedBox(
                              height: height1*0.05,
                              width: width1*0.18,
                              child: RaisedButton(
                                padding: EdgeInsets.all(0),
                                  onPressed: (){
                                  },
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Container(
                                height: height1*0.05,
                                width: width1*0.18,
                                child: Center(
                                    child: FittedBox(child: Text("Pay Now",style: TextStyle(color: Colors.white),)),
                                ),
                              ),
                                  )),
                            ),
                            SizedBox(
                              height: height1*0.05,
                              width: width1*0.18,
                              child: RaisedButton(
                                padding: EdgeInsets.all(0),
                                  onPressed: (){
                                    FirebaseFirestore.instance.collection("appointment").doc(user?.uid).collection("appointments").doc(request.documentId).update({'payment' : "accepted"});
                                    Navigator.pop(context);
                                  },
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Container(
                                height: height1*0.05,
                                width: width1*0.18,
                                child: Center(
                                    child: FittedBox(child: Text("Pay On Visit",style: TextStyle(color: Colors.white),)),
                                ),
                              ),
                                  )),
                            ),
                          ],
                        ));
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: primaryColor
                        ),
                        child: Container(
                          height: height1 * 0.06,
                          width: width1,
                          child: Center(
                              child: FittedBox(
                                child: Text(
                                  "Pay",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white),
                                ),
                              )),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  )
                ],
              )),
            )
          ],
        ),
      ),
    ),
  );
  Widget allWalkRequests(WalkingModel request) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: PhysicalModel(color: Colors.black,
      elevation: 3,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: width1,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(FontAwesomeIcons.walking,size: height1*0.07,color: Colors.green,),
                SizedBox(width: width1*0.02,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(request.request == "pending" ? "Coming Up!" : request.request.toUpperCase(),style: TextStyle(color: primaryColor,fontSize: 18,fontWeight: FontWeight.w600,fontFamily: "Futura"),),
                    Text("Walks: "+request.walk,style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: "Futura")),
                    Text(request.address.toUpperCase(),overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: "Futura")),
                    Text(request.date,style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: "Futura")),
                  ],
                )
              ],
            ),
            widget.screen == "service" ? Container(
              height: height1*0.1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height1 * 0.03,
                    width: width1*0.15,
                    child: RaisedButton(
                      color: Colors.white,
                      padding: EdgeInsets.all(0),
                      onPressed: (){
                        showDialog(context: context, builder: (_) => AlertDialog(
                          title: Text("Are you sure to accept the request?"),
                          content: TextField(
                            controller: fees,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: "Fees"
                            ),
                          ),
                          actions: [
                            FlatButton(
                                onPressed: (){
                              FirebaseFirestore.instance.collection("userWalking").doc(user?.uid).collection("userWalkings").doc(request.documentId).update({'request' : 'accepted'});
                              FirebaseFirestore.instance.collection("walking").doc(request.userId).collection("walking").doc(request.documentId).update({'request' : 'accepted'});
                              FirebaseFirestore.instance.collection("userWalking").doc(user?.uid).collection("userWalkings").doc(request.documentId).delete();
                              FirebaseFirestore.instance.collection("walking").doc(request.userId).collection("walking").doc(request.documentId).update({'fees' : fees.text.trim()});
                              Navigator.pop(context);
                            }, child: Text("Yes")),
                            FlatButton(onPressed: () {
                              fees.clear();
                              Navigator.pop(context);
                            }, child: Text("No")),
                          ],
                        ));
                        },
                      child: Ink(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.green
                        ),
                        child: Container(
                          height: height1 * 0.06,
                          width: width1,
                          child: Center(
                              child: FittedBox(
                                child: Text(
                                  "Accept",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white),
                                ),
                              )),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),SizedBox(
                    height: height1 * 0.03,
                    width: width1*0.15,
                    child: RaisedButton(
                      color: Colors.white,
                      padding: EdgeInsets.all(0),
                      onPressed: (){
                        showDialog(context: context, builder: (_) => AlertDialog(
                          title: Text("Refuse!"),
                          content: Text("Are you sure to refuse the appointment?"),
                          actions: [
                            FlatButton(onPressed: (){
                              walkFirebaseQueries(request);
                              Navigator.pop(context);
                            }, child: Text("Yes")),
                            FlatButton(onPressed: () => Navigator.pop(context), child: Text("No")),
                          ],
                        ));
                        // Dialog(
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     children: [
                        //       Text("Do you want to refuse?"),
                        //       Row(
                        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //         children: [
                        //           SizedBox(
                        //             height: height1 * 0.05,
                        //             width: width1*0.2,
                        //             child: RaisedButton(
                        //               color: Colors.white,
                        //               padding: EdgeInsets.all(0),
                        //               onPressed: firebaseQueries(request),
                        //               child: Ink(
                        //                 decoration: BoxDecoration(
                        //                     borderRadius: BorderRadius.circular(5.0),
                        //                     color: Colors.green
                        //                 ),
                        //                 child: Container(
                        //                   height: height1 * 0.06,
                        //                   width: width1,
                        //                   child: Center(
                        //                       child: FittedBox(
                        //                         child: Text(
                        //                           "YES",
                        //                           style: TextStyle(
                        //                               fontSize: 14,
                        //                               fontWeight: FontWeight.normal,
                        //                               color: Colors.white),
                        //                         ),
                        //                       )),
                        //                 ),
                        //               ),
                        //               shape: RoundedRectangleBorder(
                        //                 borderRadius: BorderRadius.circular(5.0),
                        //               ),
                        //             ),
                        //           ),SizedBox(
                        //             height: height1 * 0.05,
                        //             width: width1*0.2,
                        //             child: RaisedButton(
                        //               color: Colors.white,
                        //               padding: EdgeInsets.all(0),
                        //               onPressed: () => Navigator.pop(context),
                        //               child: Ink(
                        //                 decoration: BoxDecoration(
                        //                     borderRadius: BorderRadius.circular(5.0),
                        //                     color: Colors.red
                        //                 ),
                        //                 child: Container(
                        //                   height: height1 * 0.06,
                        //                   width: width1,
                        //                   child: Center(
                        //                       child: FittedBox(
                        //                         child: Text(
                        //                           "NO",
                        //                           style: TextStyle(
                        //                               fontSize: 14,
                        //                               fontWeight: FontWeight.normal,
                        //                               color: Colors.white),
                        //                         ),
                        //                       )),
                        //                 ),
                        //               ),
                        //               shape: RoundedRectangleBorder(
                        //                 borderRadius: BorderRadius.circular(5.0),
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ));
                        },
                      child: Ink(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.red
                        ),
                        child: Container(
                          height: height1 * 0.06,
                          width: width1,
                          child: Center(
                              child: FittedBox(
                                child: Text(
                                  "Refuse",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white),
                                ),
                              )),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ],
              ),
            ): Align(
              alignment: Alignment.center,
              child: SizedBox(child: Column(
                children: [
                  Text("Request ${request.request}!",style: TextStyle(color: Colors.black,fontSize: 14,fontFamily: "Futura"),),
                  SizedBox(height: height1*0.01,),
                  request.request != "accepted" || request.payment != "pending" ? SizedBox() : SizedBox(
                    height: height1 * 0.03,
                    width: width1*0.15,
                    child: RaisedButton(
                      color: Colors.white,
                      padding: EdgeInsets.all(0),
                      onPressed: (){
                        showDialog(context: context, builder: (_) => AlertDialog(
                          title: Text("Payment"),
                          content: Text("You have to pay "+request.fees+" Rs to the vet"),
                          actions: [
                            SizedBox(
                              height: height1*0.05,
                              width: width1*0.18,
                              child: RaisedButton(
                                padding: EdgeInsets.all(0),
                                  onPressed: (){
                                  },
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Container(
                                height: height1*0.05,
                                width: width1*0.18,
                                child: Center(
                                    child: FittedBox(child: Text("Pay Now",style: TextStyle(color: Colors.white),)),
                                ),
                              ),
                                  )),
                            ),
                            SizedBox(
                              height: height1*0.05,
                              width: width1*0.18,
                              child: RaisedButton(
                                padding: EdgeInsets.all(0),
                                  onPressed: (){
                                    FirebaseFirestore.instance.collection("walking").doc(user?.uid).collection("walking").doc(request.documentId).update({'payment' : "accepted"});
                                    Navigator.pop(context);
                                  },
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Container(
                                height: height1*0.05,
                                width: width1*0.18,
                                child: Center(
                                    child: FittedBox(child: Text("Pay On Visit",style: TextStyle(color: Colors.white),)),
                                ),
                              ),
                                  )),
                            ),
                          ],
                        ));
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: primaryColor
                        ),
                        child: Container(
                          height: height1 * 0.06,
                          width: width1,
                          child: Center(
                              child: FittedBox(
                                child: Text(
                                  "Pay",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white),
                                ),
                              )),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  )
                ],
              )),
            )
          ],
        ),
      ),
    ),
  );



  Stream<List<AppointmentModel>> readUsers(){
    return FirebaseFirestore.instance
        .collection("appointment")
        .doc(user?.uid)
        .collection("appointments").where("id", isEqualTo: widget.user.id)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => AppointmentModel.fromJson(doc.data())).toList());
  }
  Stream<List<AppointmentModel>> readRequests(){
    return FirebaseFirestore.instance
        .collection("vetAppointment")
        .doc(user?.uid)
        .collection("vetAppointments")
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => AppointmentModel.fromJson(doc.data())).toList());
  }
  
  firebaseQueries(AppointmentModel request){
    FirebaseFirestore.instance.collection("vetAppointment").doc(user?.uid).collection("vetAppointments").doc(request.documentId).update({'request' : 'refused'});
    FirebaseFirestore.instance.collection("appointment").doc(request.userId).collection("appointments").doc(request.documentId).update({'request' : 'refused'});
    FirebaseFirestore.instance.collection("vetAppointment").doc(user?.uid).collection("vetAppointments").doc(request.documentId).delete();
  }
  Stream<List<WalkingModel>> readWalkUsers(){
    return FirebaseFirestore.instance
        .collection("walking")
        .doc(user?.uid)
        .collection("walking").where("id", isEqualTo: widget.user.id)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => WalkingModel.fromJson(doc.data())).toList());
  }
  Stream<List<WalkingModel>> readWalkRequests(){
    return FirebaseFirestore.instance
        .collection("userWalking")
        .doc(user?.uid)
        .collection("userWalkings")
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => WalkingModel.fromJson(doc.data())).toList());
  }

  walkFirebaseQueries(WalkingModel request){
    FirebaseFirestore.instance.collection("userWalking").doc(user?.uid).collection("userWalkings").doc(request.documentId).update({'request' : 'refused'});
    FirebaseFirestore.instance.collection("walking").doc(request.userId).collection("walkings").doc(request.documentId).update({'request' : 'refused'});
    FirebaseFirestore.instance.collection("userWalking").doc(user?.uid).collection("userWalkings").doc(request.documentId).delete();
  }
}
