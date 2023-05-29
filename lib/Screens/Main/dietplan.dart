import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petcare/Model/dietModel.dart';

import '../../constants.dart';
import 'Components/DietComponents/dietDetail.dart';
import 'Components/DietComponents/makeDiet.dart';

class DietPlan extends StatefulWidget {
  const DietPlan({Key? key}) : super(key: key);

  @override
  State<DietPlan> createState() => _DietPlanState();
}
class _DietPlanState extends State<DietPlan> {
  User? user = FirebaseAuth.instance.currentUser;
  var height1;
  var width1;
  @override
  Widget build(BuildContext context) {
    height1 = MediaQuery.of(context).size.height;
    width1 = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text("Diet Plan",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold,fontFamily: "Futura"),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: primaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        elevation: 1,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => MakeDiet()));
        },
        child: Icon(Icons.add,color: Colors.white,),
      ),
      body: Container(
        height: height1,
        width: width1,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: StreamBuilder<List<DietModel>>(
          stream: readUsers(),
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Center(child: Text("No Meal Added!"),);
            }else if (snapshot.hasError) {
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
        ),
      );
  }
  Widget buildUser(DietModel user) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: PhysicalModel(
      elevation: 5,
      color: Colors.black,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => DietDetail(user: user)));
        },
        child: Container(
          height: height1*0.3,
          width: width1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                image: AssetImage("images/food.png"),
                fit: BoxFit.cover,
                opacity: 0.8
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                  bottom: 30,
                  left: 10,
                  child: Text(user.dietName,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontFamily: 'Futura',fontSize: 20,letterSpacing: 1),)),
              Positioned(
                  top: 10,
                  right: 10,
                  child: Row(
                    children: [
                      if(user.dog == "true")
                        SvgPicture.asset("images/dog.svg",color: Colors.black,height: height1*0.03,),
                      SizedBox(width: width1*0.01,),
                      if(user.cat == "true")
                        SvgPicture.asset("images/cat.svg",color: Colors.black,height: height1*0.03,),
                    ],
                  ))
            ],
          ),
        ),
      ),
    ),
  );

  Stream<List<DietModel>> readUsers() => FirebaseFirestore.instance
      .collection("diet")
      .doc(user?.uid)
      .collection("diets")
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => DietModel.fromJson(doc.data())).toList());
}
