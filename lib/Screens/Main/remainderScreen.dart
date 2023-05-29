import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:petcare/Model/remainderModel.dart';
import 'package:petcare/constants.dart';
import 'package:petcare/services/notification_api.dart';

import 'Components/RemainderComponents/addRemainder.dart';

class RemainderScreen extends StatefulWidget {
  const RemainderScreen({Key? key}) : super(key: key);

  @override
  State<RemainderScreen> createState() => _RemainderScreenState();
}

class _RemainderScreenState extends State<RemainderScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  var height1;
  var width1;
  @override
  Widget build(BuildContext context) {
    height1 = MediaQuery.of(context).size.height;
    width1 = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Navigator.pop(context),icon: Icon(Icons.arrow_back_ios,color: Colors.white),),
        title: Text("Remainders",style: TextStyle(color: Colors.white,fontFamily: "Futura",fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 1,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddRemainder()));
        },
        child: Center(
          child: Icon(Icons.add,color: Colors.white,),
        )
      ),
      body: StreamBuilder<List<RemainderModel>>(
        stream: readUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView(children: users.map(buildRemainder).toList());
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget buildRemainder(RemainderModel remainder) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: (){
        //Navigator.push(context, MaterialPageRoute(builder: (context) => Detail(user: user,)));
      },
      child: Material(
        elevation: 2,
        color: Colors.black.withOpacity(0.3),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        child: Container(
            width: width1/1.2,
            height: height1*0.15,
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: height1*0.15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Remainder",style: TextStyle(color: Colors.black,fontSize: 22, fontWeight: FontWeight.bold,fontFamily: "Futura",letterSpacing: 1),),
                      Text(remainder.title,style: TextStyle(color: Colors.black,fontSize: 14,fontFamily: "Futura"),),
                      Text(remainder.body,style: TextStyle(color: Colors.black,fontSize: 14,fontFamily: "Futura"),)
                    ],
                  ),
                ),
                Container(
                  height: height1*0.15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(onPressed: (){
                        deleteRemainder(remainder);
                      }, icon: Icon(Icons.delete, color: Colors.red,),iconSize: 20,),
                      Text(remainder.time,style: TextStyle(color: Colors.black,fontSize: 22, fontWeight: FontWeight.bold,fontFamily: "Futura",letterSpacing: 1),),
                      Text(remainder.dateTime,style: TextStyle(color: Colors.black,fontSize: 14,fontFamily: "Futura"),)
                    ],
                  ),
                )
              ],
            )
        ),
      ),
    ),
  );

  Stream<List<RemainderModel>> readUsers() => FirebaseFirestore.instance
      .collection("remainder")
  .doc(user?.uid).collection("remainders")
      .snapshots()
      .map((snapshot) => snapshot.docs
      .map((doc) => RemainderModel.fromJson(doc.data()))
      .toList());
  
  deleteRemainder(RemainderModel remainder)async{
    await FirebaseFirestore.instance.collection("remainder").doc(user?.uid).collection("remainders").doc(remainder.docId).delete();
    NotificationApi.deleteNotification(int.parse(remainder.docId));
  }
}
