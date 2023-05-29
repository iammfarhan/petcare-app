import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petcare/Screens/Main/Components/WalkingComponents/walkingAll.dart';

import '../../../../constants.dart';
import '../detail.dart';

class WalkingList extends StatefulWidget {
  const WalkingList({Key? key}) : super(key: key);

  @override
  State<WalkingList> createState() => _WalkingListState();
}

class _WalkingListState extends State<WalkingList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: WalkingAll()
    );
  }
}
