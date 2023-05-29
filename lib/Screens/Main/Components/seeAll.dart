import 'package:flutter/material.dart';
import 'package:petcare/Screens/Main/Components/VetComponents/veterinaryAll.dart';

import '../../../constants.dart';
import '../nav.dart';
import 'WalkingComponents/walkingAll.dart';

class SeeAll extends StatefulWidget {
  final String service;
  const SeeAll({Key? key, required this.service}) : super(key: key);

  @override
  State<SeeAll> createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  List<Widget> all = [
    VeterinaryAll(),
    WalkingAll(),
  ];
  @override
  Widget build(BuildContext context) {
    var height1 = MediaQuery.of(context).size.height;
    var width1 = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.05),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Nav())),icon: Icon(Icons.arrow_back,color: Colors.black,),),
        title: Text(servicesText[servicesText.indexOf(widget.service)],style: TextStyle(color: primaryColor,fontSize: 25,fontWeight: FontWeight.bold,fontFamily: "Futura"),),
        centerTitle: true,
      ),
      body: Container(
        height: height1,
        width: width1,
        child: all[servicesText.indexOf(widget.service)],
      ),
    );
  }
}
