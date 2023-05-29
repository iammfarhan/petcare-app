import 'package:flutter/material.dart';
import 'package:petcare/Screens/Main/Components/ServicesComponents/veterinaryService.dart';
import 'package:petcare/Screens/Main/Components/ServicesComponents/walkingService.dart';
import 'package:petcare/constants.dart';

class Services extends StatefulWidget {
  const Services({Key? key}) : super(key: key);

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  String dropdownvalue = 'Veterinary';
  @override
  Widget build(BuildContext context) {
    var height1 = MediaQuery.of(context).size.height;
    var width1 = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,),onPressed: () => Navigator.pop(context),),
        title: Text("Services",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontFamily: "Futura"),),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Container(
          height: height1,
          width: width1,
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              SizedBox(height: height1*0.03,),
              displayText("What service you provide?"),
              SizedBox(height: height1*0.01,),
              SizedBox(
                width: width1,
                child: DropdownButton(
                  underline: SizedBox(),
                  isExpanded: true,
                  value: dropdownvalue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: servicesText.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(items),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ),
              SizedBox(height: height1*0.01,),
              if(dropdownvalue == "Veterinary")
                VeterinaryService(),
              if(dropdownvalue == "Walking")
                WalkingService(),
            ],
          ),
      ),
    );
  }
  displayText(String text){
    return Text(text,style: TextStyle(
        color: primaryColor,
        fontWeight: FontWeight.bold,
        fontFamily: "Futura",
        fontSize: 15,
        letterSpacing: 0.5),);
  }
}
