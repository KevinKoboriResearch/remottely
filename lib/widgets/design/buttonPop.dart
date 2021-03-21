import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/utils/my_flutter_app_icons_2.dart';
import 'package:remottely/widgets/design/app_clipper.dart';
import 'package:remottely/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remottely/data/firestore/devices_collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:remottely/widgets/device/device_key_dialog.dart';
import 'package:remottely/functions/flushbar.dart';

Widget buttonPop(context, darkColor) {
  return Container(
    width: 40,
    child: NeumorphicButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(4),
        ),
        color: darkColor ? AppColors.astratosDarkGreyColor : AppColors.astronautCanvasColor,
        depth: 1,
      ),
      padding: const EdgeInsets.fromLTRB(4, 6, 6, 8),
      child: Icon(
        MyFlutterApp.angle_double_left,
        color: AppColors.accentColor,
        size: 26,
      ),
    ),
  );
}
