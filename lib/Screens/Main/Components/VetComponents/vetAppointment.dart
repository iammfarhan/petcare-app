import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petcare/Model/appointmentModel.dart';
import 'package:petcare/Model/serviceModel.dart';
import 'package:petcare/constants.dart';

import '../../../../Model/appointmentConstants.dart';

class VetAppointment extends StatefulWidget {
  VetAppointment({Key? key, required this.user1}) : super(key: key);
  ServiceModel user1;
  @override
  State<VetAppointment> createState() => _VetAppointmentState();
}

class _VetAppointmentState extends State<VetAppointment> {
  var width, height;
  bool isSelected = false;

  int purpose = 0, appointment = 0, day = 0, time = 0;
  DateTime dateTime = DateTime.now();

  User? user = FirebaseAuth.instance.currentUser;
  TimeOfDay now = TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute);

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Book Appointment',
          style: TextStyle(
              color: primaryColor,
              fontFamily: "Futura",
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              displayText(
                'Type of Appointment',
                18.0,
                FontWeight.bold,
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PhysicalModel(
                    elevation: 3,
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(18.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          appointment = 0;
                        });
                      },
                      child: Container(
                        width: height * 0.14,
                        height: height * 0.15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0),
                          color: appointment != 0 ? Colors.white : null,
                          gradient: appointment == 0 ? gradient : null,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * 0.05,
                            ),
                            Icon(
                              Icons.home,
                              color: appointment != 0
                                  ? Colors.black
                                  : Colors.white,
                              size: width * 0.06,
                            ),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            Text(
                              'Home Visit',
                              style: TextStyle(
                                  color: appointment != 0
                                      ? Colors.black
                                      : Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  PhysicalModel(
                    elevation: 3,
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(18.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          appointment = 1;
                        });
                      },
                      child: Container(
                        width: height * 0.14,
                        height: height * 0.15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0),
                          color: appointment != 1 ? Colors.white : null,
                          gradient: appointment == 1 ? gradient : null,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * 0.05,
                            ),
                            Icon(
                              Icons.add_circle_outline,
                              color: appointment != 1
                                  ? Colors.black
                                  : Colors.white,
                              size: width * 0.06,
                            ),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            Text(
                              'Clinic',
                              style: TextStyle(
                                  color: appointment != 1
                                      ? Colors.black
                                      : Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.06,
              ),
              displayText('Purpose of Visit', 17.0, FontWeight.bold),
              SizedBox(
                height: height * 0.04,
              ),
              Wrap(spacing: 5, runSpacing: 10, children: [
                SizedBox(
                  width: width * 0.2,
                  height: height * 0.04,
                  child: RaisedButton(
                    padding: EdgeInsets.all(0),
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        purpose = 0;
                      });
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                          color: purpose != 0 ? Colors.white : null,
                          gradient: purpose == 0 ? gradient : null,
                          borderRadius: BorderRadius.circular(18.0)),
                      child: Container(
                        width: width * 0.2,
                        height: height * 0.04,
                        child: Center(
                          child: Text(
                            'Neuter',
                            style: TextStyle(
                                color:
                                    purpose != 0 ? primaryColor : Colors.white),
                          ),
                        ),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: primaryColor),
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.27,
                  height: height * 0.04,
                  child: RaisedButton(
                    padding: EdgeInsets.all(0),
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        purpose = 1;
                      });
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                          color: purpose != 1 ? Colors.white : null,
                          gradient: purpose == 1 ? gradient : null,
                          borderRadius: BorderRadius.circular(18.0)),
                      child: Container(
                        width: width * 0.27,
                        height: height * 0.04,
                        child: Center(
                          child: Text(
                            'Consultation',
                            style: TextStyle(
                                color:
                                    purpose != 1 ? primaryColor : Colors.white),
                          ),
                        ),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: primaryColor),
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.27,
                  height: height * 0.04,
                  child: RaisedButton(
                    padding: EdgeInsets.all(0),
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        purpose = 2;
                      });
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                          color: purpose != 2 ? Colors.white : null,
                          gradient: purpose == 2 ? gradient : null,
                          borderRadius: BorderRadius.circular(18.0)),
                      child: Container(
                        width: width * 0.27,
                        height: height * 0.04,
                        child: Center(
                          child: Text(
                            'Vaccination',
                            style: TextStyle(
                                color:
                                    purpose != 2 ? primaryColor : Colors.white),
                          ),
                        ),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: primaryColor),
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.2,
                  height: height * 0.04,
                  child: RaisedButton(
                    padding: EdgeInsets.all(0),
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        purpose = 3;
                      });
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                          color: purpose != 3 ? Colors.white : null,
                          gradient: purpose == 3 ? gradient : null,
                          borderRadius: BorderRadius.circular(18.0)),
                      child: Container(
                        width: width * 0.2,
                        height: height * 0.04,
                        child: Center(
                          child: Text(
                            'Dental',
                            style: TextStyle(
                                color:
                                    purpose != 3 ? primaryColor : Colors.white),
                          ),
                        ),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: primaryColor),
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
              ]),
              SizedBox(
                height: height * 0.06,
              ),
              displayText('Availability', 17.0, FontWeight.bold),
              SizedBox(
                height: height * 0.03,
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
                height: height * 0.02,
              ),
              InkWell(
                onTap: () async {
                  TimeOfDay? newTime = await showTimePicker(
                      context: context, initialTime: now);
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
                    Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,size: 18,),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     PhysicalModel(
              //       elevation: 3,
              //       color: Colors.grey,
              //       borderRadius: BorderRadius.circular(5),
              //       child: InkWell(
              //         onTap: () {
              //           setState(() {
              //             day = 0;
              //           });
              //         },
              //         child: Container(
              //           width: width * 0.4,
              //           height: height * 0.06,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(5),
              //             color: day != 0 ? Colors.white : null,
              //             gradient: day == 0 ? gradient : null,
              //           ),
              //           child: Row(
              //             children: [
              //               SizedBox(
              //                 width: width * 0.03,
              //               ),
              //               Container(
              //                 height: height * 0.03,
              //                 width: height * 0.03,
              //                 decoration: BoxDecoration(
              //                   borderRadius:
              //                       BorderRadius.circular(width * 0.01),
              //                   color: Color(0xFFE0DFDF),
              //                 ),
              //                 child: Center(
              //                   child: FittedBox(
              //                     child: Icon(
              //                       Icons.wb_sunny,
              //                       color:
              //                           day != 0 ? Colors.grey : Colors.yellow,
              //                       size: 15,
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //               SizedBox(
              //                 width: width * 0.04,
              //               ),
              //               Text(
              //                 'Morning',
              //                 style: TextStyle(
              //                     fontSize: 14,
              //                     color: day != 0 ? Colors.black : Colors.white,
              //                     fontWeight: FontWeight.normal),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //     SizedBox(
              //       width: width * 0.05,
              //     ),
              //     PhysicalModel(
              //       elevation: 3,
              //       color: Colors.grey,
              //       borderRadius: BorderRadius.circular(5),
              //       child: InkWell(
              //         onTap: () {
              //           setState(() {
              //             day = 1;
              //           });
              //         },
              //         child: Container(
              //           width: width * 0.4,
              //           height: height * 0.06,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(5),
              //             color: day != 1 ? Colors.white : null,
              //             gradient: day == 1 ? gradient : null,
              //           ),
              //           child: Row(
              //             children: [
              //               SizedBox(
              //                 width: width * 0.03,
              //               ),
              //               Container(
              //                 height: height * 0.03,
              //                 width: height * 0.03,
              //                 decoration: BoxDecoration(
              //                   borderRadius:
              //                       BorderRadius.circular(width * 0.01),
              //                   color: Color(0xFFE0DFDF),
              //                 ),
              //                 child: Center(
              //                   child: Icon(
              //                     Icons.wb_cloudy,
              //                     color: day != 1
              //                         ? Colors.grey
              //                         : Colors.blueAccent,
              //                     size: 15,
              //                   ),
              //                 ),
              //               ),
              //               SizedBox(
              //                 width: width * 0.04,
              //               ),
              //               Text(
              //                 'Evening',
              //                 style: TextStyle(
              //                     fontSize: 14,
              //                     color: day != 1 ? Colors.black : Colors.white,
              //                     fontWeight: FontWeight.normal),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(height: height * 0.02),
              // Wrap(
              //   spacing: 5,
              //   runSpacing: 10,
              //   children: [
              //     InkWell(
              //       onTap: () {
              //         setState(() {
              //           time = 0;
              //         });
              //       },
              //       child: PhysicalModel(
              //         elevation: 3,
              //         color: Colors.grey,
              //         borderRadius: BorderRadius.circular(5),
              //         child: Container(
              //           width: width * 0.2,
              //           height: height * 0.04,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(5),
              //             color: time != 0 ? Colors.white : null,
              //             gradient: time == 0 ? gradient : null,
              //           ),
              //           child: Center(
              //             child: Text(
              //               '09:00 AM',
              //               style: TextStyle(
              //                   fontSize: 14,
              //                   color: time != 0 ? Colors.black : Colors.white,
              //                   fontWeight: FontWeight.normal),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //     InkWell(
              //       onTap: () {
              //         setState(() {
              //           time = 1;
              //         });
              //       },
              //       child: PhysicalModel(
              //         elevation: 3,
              //         color: Colors.grey,
              //         borderRadius: BorderRadius.circular(5),
              //         child: Container(
              //           width: width * 0.2,
              //           height: height * 0.04,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(5),
              //             color: time != 2 ? Colors.white : null,
              //             gradient: time == 2 ? gradient : null,
              //           ),
              //           child: Center(
              //             child: Text(
              //               '09:30 AM',
              //               style: TextStyle(
              //                   fontSize: 14,
              //                   color: time != 2 ? Colors.black : Colors.white,
              //                   fontWeight: FontWeight.normal),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //     InkWell(
              //       onTap: () {
              //         setState(() {
              //           time = 3;
              //         });
              //       },
              //       child: PhysicalModel(
              //         elevation: 3,
              //         color: Colors.grey,
              //         borderRadius: BorderRadius.circular(5),
              //         child: Container(
              //           width: width * 0.2,
              //           height: height * 0.04,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(5),
              //             color: time != 3 ? Colors.white : null,
              //             gradient: time == 3 ? gradient : null,
              //           ),
              //           child: Center(
              //             child: Text(
              //               '10:00 AM',
              //               style: TextStyle(
              //                   fontSize: 14,
              //                   color: time != 3 ? Colors.black : Colors.white,
              //                   fontWeight: FontWeight.normal),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //     InkWell(
              //       onTap: () {
              //         setState(() {
              //           time = 4;
              //         });
              //       },
              //       child: PhysicalModel(
              //         elevation: 3,
              //         color: Colors.grey,
              //         borderRadius: BorderRadius.circular(5),
              //         child: Container(
              //           width: width * 0.2,
              //           height: height * 0.04,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(5),
              //             color: time != 4 ? Colors.white : null,
              //             gradient: time == 4 ? gradient : null,
              //           ),
              //           child: Center(
              //             child: Text(
              //               '10:30 AM',
              //               style: TextStyle(
              //                   fontSize: 14,
              //                   color: time != 4 ? Colors.black : Colors.white,
              //                   fontWeight: FontWeight.normal),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //     InkWell(
              //       onTap: () {
              //         setState(() {
              //           time = 5;
              //         });
              //       },
              //       child: PhysicalModel(
              //         elevation: 3,
              //         color: Colors.grey,
              //         borderRadius: BorderRadius.circular(5),
              //         child: Container(
              //           width: width * 0.2,
              //           height: height * 0.04,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(5),
              //             color: time != 5 ? Colors.white : null,
              //             gradient: time == 5 ? gradient : null,
              //           ),
              //           child: Center(
              //             child: Text(
              //               '11:00 AM',
              //               style: TextStyle(
              //                   fontSize: 14,
              //                   color: time != 5 ? Colors.black : Colors.white,
              //                   fontWeight: FontWeight.normal),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //     InkWell(
              //       onTap: () {
              //         setState(() {
              //           time = 6;
              //         });
              //       },
              //       child: PhysicalModel(
              //         elevation: 3,
              //         color: Colors.grey,
              //         borderRadius: BorderRadius.circular(5),
              //         child: Container(
              //           width: width * 0.2,
              //           height: height * 0.04,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(5),
              //             color: time != 6 ? Colors.white : null,
              //             gradient: time == 6 ? gradient : null,
              //           ),
              //           child: Center(
              //             child: Text(
              //               '11:30 AM',
              //               style: TextStyle(
              //                   fontSize: 14,
              //                   color: time != 6 ? Colors.black : Colors.white,
              //                   fontWeight: FontWeight.normal),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(height: height * 0.08),
              // displayText('Pets', 17.0, FontWeight.bold),
              // SizedBox(height: height * 0.03),
              // ListTile(
              //     contentPadding: EdgeInsets.all(0),
              //     leading: Container(
              //       width: 50,
              //       child: AspectRatio(
              //         aspectRatio: 1,
              //         child: Container(
              //           decoration: BoxDecoration(
              //               shape: BoxShape.circle,
              //               image: DecorationImage(
              //                   fit: BoxFit.cover,
              //                   image: AssetImage("images/dog.jpg"))),
              //         ),
              //       ),
              //     ),
              //     title: Text(petName),
              //     subtitle: Text(
              //       petBreed,
              //       style: TextStyle(
              //           fontWeight: FontWeight.bold, color: Colors.black),
              //     ),
              //     trailing: Switch(
              //         value: isSelected,
              //         onChanged: (value) {
              //           setState(() {
              //             isSelected = value;
              //           });
              //         })),
              // SizedBox(
              //   height: height * 0.08,
              // ),
              Center(
                child: InkWell(
                  onTap: writeData,
                  child: Container(
                    width: width / 1.2,
                    height: height * 0.05,
                    child: Center(
                      child: Text(
                        'Book Appointment',
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
      ),
    );
  }

  Widget displayText(String text, double size, FontWeight weight) {
    return Text(
      text,
      style: TextStyle(color: primaryColor, fontWeight: weight, fontSize: size),
    );
  }

  Future writeData() async {
    try{
      String id = FirebaseFirestore.instance.collection("appointment").doc(user?.uid).collection("appointments").doc().id;
      final doc = FirebaseFirestore.instance.collection("appointment").doc(user?.uid).collection("appointments").doc(id);
      final vetDoc = FirebaseFirestore.instance.collection("vetAppointment").doc(widget.user1.id).collection("vetAppointments").doc(id);
      final appointmentModel = AppointmentModel(
        payment: "pending",
        documentId: id,
        request: "pending",
        id: widget.user1.id,
          userId : user?.uid,
          time: now.hourOfPeriod.toString() + ":" + now.minute.toString() + now.period.name,
          pet: petId[0],
          purpose: purposeList[purpose],
          availability: dateTime.day.toString() +
              '/' +
              dateTime.month.toString() +
              '/' +
              dateTime.year.toString(),
          type: appointmentList[appointment], fees: ''
          );
      final json = appointmentModel.toJson();
      await doc.set(json,SetOptions(merge: true));
      await vetDoc.set(json,SetOptions(merge: true));
    }catch (e){
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
