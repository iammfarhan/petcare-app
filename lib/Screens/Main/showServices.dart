import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petcare/Model/serviceModel.dart';
import 'package:petcare/Screens/Main/Components/detail.dart';
class ShowServices extends StatefulWidget {

  final String role;

  const ShowServices({Key? key, required this.role}) : super(key: key);
  @override
  State<ShowServices> createState() => _ShowServicesState();
}

class _ShowServicesState extends State<ShowServices> {
  ServiceModel service = ServiceModel(id: "1", fullName: "Ali", profession: "a", price: "A", clinicName: "a", clinicLocation: "clinicLocation", about: "about", fromTime: "fromTime", toTime: "toTime");
  User? user = FirebaseAuth.instance.currentUser;
  Future<ServiceModel?> readVetUser() async {
    final docUser = FirebaseFirestore.instance.collection("vetService").doc(user?.uid);
    final snapshot = await docUser.get();

    if(snapshot.exists){
      return ServiceModel.fromJson(snapshot.data()!);
    }
  }
  Future<ServiceModel?> readWalkUser() async {
    final docUser = FirebaseFirestore.instance.collection("walkService").doc(user?.uid);
    final snapshot = await docUser.get();

    if(snapshot.exists){
      return ServiceModel.fromJson(snapshot.data()!);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ServiceModel?>(
        future: widget.role == "vet" ? readVetUser() : readWalkUser(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            final user = snapshot.data!;
            return Detail(user: user, role: widget.role,screen: "service",);
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}
