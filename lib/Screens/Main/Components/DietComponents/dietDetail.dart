import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petcare/Model/dietModel.dart';
import 'package:petcare/Screens/Main/dietplan.dart';

import '../../../../constants.dart';
import '../../nav.dart';

class DietDetail extends StatefulWidget {
  DietDetail({Key? key, required this.user}) : super(key: key);
  DietModel user;
  @override
  State<DietDetail> createState() => _DietDetailState();
}

class _DietDetailState extends State<DietDetail> {
  @override
  Widget build(BuildContext context) {
    var height1 = MediaQuery.of(context).size.height;
    var width1 = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: height1,
          width: width1,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                child: Container(
                  height: height1/2.5,
                  width: width1,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/food.png"),
                      fit: BoxFit.cover
                    )
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: height1/1.5,
                  width: width1,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                    color: Colors.white
                  ),
                  child: ListView(
                    children: [
                      Align(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: width1*0.2,
                              height: height1*0.01,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey.shade400
                              ),
                            ),
                          ),
                        alignment: Alignment.topCenter,
                      ),
                      SizedBox(height: height1*0.02,),
                      Text(widget.user.dietName,style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold,fontFamily: "Futura",fontSize: 30,letterSpacing: 0.5),),
                      SizedBox(height: height1*0.02,),
                      Row(
                        children: [
                          if(widget.user.dog == "true")
                            SvgPicture.asset("images/dog.svg",color: Colors.black,height: height1*0.03,),
                          SizedBox(width: width1*0.01,),
                          if(widget.user.cat == "true")
                            SvgPicture.asset("images/cat.svg",color: Colors.black,height: height1*0.03,),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey.shade400,
                      ),
                      SizedBox(height: height1*0.02,),
                      Text("Description",style: TextStyle(color: Colors.black87,fontSize: 20,fontWeight: FontWeight.bold,fontFamily: "Futura"),),
                      SizedBox(height: height1*0.01,),
                      Text(widget.user.description,style: TextStyle(color: Colors.black87,fontFamily: "Futura",fontSize: 15),)
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: 15,
                  left: 15,
                  child: Container(
                height: height1*0.04,
                width: height1*0.04,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10)
                ),
                    child: Align(
                        alignment: Alignment.center,
                        child: IconButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Nav())),icon: Icon(Icons.arrow_back_ios,color: Colors.black87,size: 15,),)),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
