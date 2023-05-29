import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:petcare/Screens/Main/pet.dart';
import 'package:petcare/constants.dart';

import '../../Model/petModel.dart';

class PetProfile extends StatefulWidget {
  PetProfile({Key? key}) : super(key: key);
  int index = 0;

  @override
  State<PetProfile> createState() => _PetProfileState();
}

class _PetProfileState extends State<PetProfile> {
  User? user = FirebaseAuth.instance.currentUser;

  var height1;
  var width1;
  @override
  Widget build(BuildContext context) {
    height1 = MediaQuery.of(context).size.height;
    width1 = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Pets",
          style: TextStyle(
              color: Colors.white, fontFamily: "Futura", fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
          elevation: 3,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Pet()));
          },
          backgroundColor: primaryColor,
          child: Icon(
            Icons.add,
            color: Colors.white,
          )),
      body: Container(
        height: height1,
        width: width1,
        child: StreamBuilder<List<PetData>>(
          stream: readUsers(),
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Center(child: Text("No Pets Added!"),);
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

  Widget buildUser(PetData user) => Padding(
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
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: height1*0.12,
                    width: height1*0.12,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: user.pet == "dog" ? AssetImage("images/dog.png") : AssetImage("images/cat.jpg") ,
                            fit: BoxFit.cover
                        ),
                      shape: BoxShape.circle
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),),
                      Text(user.breed,style: TextStyle(color: Colors.grey.shade700,fontSize: 14,),),
                    ],
                  ),
                ),
              ],
            )
        ),
      ),
    ),
  );

  Stream<List<PetData>> readUsers() => FirebaseFirestore.instance
      .collection("Pet")
      .doc(user?.uid)
      .collection("Pets")
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => PetData.fromJson(doc.data())).toList());
}
