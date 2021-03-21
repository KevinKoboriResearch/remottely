import 'package:flutter/material.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:remottely/utils/constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math' as math;
import 'package:remottely/widgets/design/buttonPop.dart';
import 'package:flutter/material.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:remottely/utils/constants.dart';
import 'dart:ui';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:page_transition/page_transition.dart';
import 'package:remottely/views/device/devices_page_list.dart';

class LayoutCustomScrollView extends StatefulWidget {
  final int popPage;
  final Widget currentPage;
  final String pageTitle;
  // final AsyncSnapshot<QuerySnapshot> snapshot;
  dynamic snapshot;
  final Widget pageData;
  LayoutCustomScrollView(this.popPage, this.currentPage, this.pageTitle,
      this.snapshot, this.pageData);

  @override
  _LayoutCustomScrollViewState createState() => _LayoutCustomScrollViewState();
}

//Navigator.pop(context);
class _LayoutCustomScrollViewState extends State<LayoutCustomScrollView> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: SizedBox(
            height: 24,
          ),
        ),
        SliverAppBar(
          pinned: true,
          toolbarHeight: 44,
          elevation: 0,
          leading:  widget.popPage != 0 ? IconButton(
            icon: Icon(
              MyFlutterApp.left_open_big,//angle_double_left,
              size: 20,
              color: AppColors.astratosDarkGreyColor,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ) : Container(),
          backgroundColor: AppColors.astronautCanvasColor.withOpacity(0.9),
          centerTitle: kIsWeb ? true : false,
          title: kIsWeb || widget.popPage != 0
              ? NeumorphicText(
                  widget.pageTitle,
                  style: NeumorphicStyle(
                    depth: 1,
                    color: AppColors.textColor,
                  ),
                  textStyle: NeumorphicTextStyle(
                    fontFamily: 'Astronaut_PersonalUse',
                    fontSize: 32,
                  ),
                )
              : null,
          actions: widget.popPage != 0
                  ? []
                  : kIsWeb
              ? [
                  InkWell(
                    hoverColor: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        top: 1.0,
                        bottom: 3.0,
                        right: 12.0,
                      ),
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(math.pi),
                        child: NeumorphicIcon(
                          MyFlutterApp.sort,
                          size: 42,
                          style: NeumorphicStyle(
                            depth: 1,
                            color: AppColors.textColor,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ]
              : [
                      //popPage
                      SizedBox(width: 16.0),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10.0,
                        ),
                        child: NeumorphicText(
                          widget.pageTitle, //'C H A V E S',
                          style: NeumorphicStyle(
                            depth: 1,
                            color: AppColors.textColor,
                          ),
                          textStyle: NeumorphicTextStyle(
                            fontFamily: 'Astronaut_PersonalUse',
                            fontSize: 32,
                          ),
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        hoverColor: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            top: 1.0,
                            bottom: 3.0,
                            right: 12.0,
                          ),
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(math.pi),
                            child: NeumorphicIcon(
                              MyFlutterApp.sort,
                              size: 42,
                              style: NeumorphicStyle(
                                depth: 1,
                                color: AppColors.textColor,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                    ],
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 10,
          ),
        ),
        widget.pageData,
        SliverToBoxAdapter(
          child: SizedBox(
            height: 70,
          ),
        ),
      ],
    );
  }
}
