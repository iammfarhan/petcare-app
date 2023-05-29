import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../Model/serviceModel.dart';
import '../../../../Model/walkingServiceModel.dart';
import '../../../../constants.dart';
import '../detail.dart';

class WalkingAll extends StatefulWidget {
  const WalkingAll({Key? key}) : super(key: key);

  @override
  State<WalkingAll> createState() => _WalkingAllState();
}

class _WalkingAllState extends State<WalkingAll> {
  var height1;
  var width1;

  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    height1 = MediaQuery.of(context).size.height;
    width1 = MediaQuery.of(context).size.width;
    return Scaffold(
      body: StreamBuilder<List<ServiceModel>>(
        stream: readUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView(children: users.map(buildUser).toList());
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )
    );
  }

  Widget buildUser(ServiceModel user) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Detail(screen: "all",role: "walk",user: user,)));
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
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: height1*0.12,
                        width: height1*0.12,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: AssetImage("images/profile.jpg"),
                                fit: BoxFit.fill
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.fullName,style: TextStyle(fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: "Futura"),),
                          Text(user.profession,style: TextStyle(color: Colors.grey.shade700,
                            fontSize: 14,),),
                          Row(
                            children: [
                              Icon(FontAwesomeIcons.dollarSign,color: Colors.yellow,size: 15,),
                              SizedBox(width: 2,),
                              Text(user.price,style: TextStyle(fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                  color: Colors.black),)
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    height: height1 * 0.04,
                    width: width1 * 0.06,
                    decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5)),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: primaryColor,
                      size: 15,
                    ),
                  ),
                )
              ],
            )
        ),
      ),
    ),
  );

  Stream<List<ServiceModel>> readUsers() => FirebaseFirestore.instance
      .collection("walkService").where("id", isNotEqualTo: user?.uid)
      .snapshots()
      .map((snapshot) => snapshot.docs
      .map((doc) => ServiceModel.fromJson(doc.data()))
      .toList());
}
