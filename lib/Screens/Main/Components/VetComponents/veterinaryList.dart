import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petcare/Screens/Main/Components/VetComponents/veterinaryAll.dart';
import 'package:petcare/Screens/Main/Components/detail.dart';

import '../../../../constants.dart';

class VeterinaryList extends StatefulWidget {
  const VeterinaryList({Key? key}) : super(key: key);

  @override
  State<VeterinaryList> createState() => _VeterinaryListState();
}

class _VeterinaryListState extends State<VeterinaryList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: VeterinaryAll(),
    );
  }
}
