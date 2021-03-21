import 'package:flutter/material.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:remottely/utils/constants.dart';
import 'dart:ui';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:page_transition/page_transition.dart';
import 'package:remottely/views/device/devices_page_list.dart';

class LayoutPush extends StatefulWidget {
  final bool popPage;
  final String pageTitle;
  final Widget pageData;
  final Widget currentPage;
  LayoutPush(this.popPage, this.currentPage, this.pageTitle, this.pageData);

  @override
  _LayoutPushState createState() => _LayoutPushState();
}

class _LayoutPushState extends State<LayoutPush> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.astronautCanvasColor,
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.astratosDarkGreyColor,
        elevation: 8,
        leading: IconButton(
          icon: Icon(
            MyFlutterApp.angle_double_left,
            size: 20,
            color: AppColors.astronautCanvasColor,
          ),
          onPressed: () => widget.popPage
              ? Navigator.of(context).pop()
              : Navigator.pushReplacement(
                  context,
                  PageTransition(
                    type: PageTransitionType.leftToRightJoined,
                    child: DevicesPageList(),
                    childCurrent: widget.currentPage,
                  ),
                ),
        ),
        title: Text(
          widget.pageTitle,
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Astronaut_PersonalUse',
            color: AppColors.astronautCanvasColor,
            letterSpacing: 4,
            wordSpacing: 4,
          ),
        ),
      ),
      // body: CustomScrollView(
      //   slivers: <Widget>[
      //     SliverAppBar(
      //       backgroundColor: AppColors.astratosDarkGreyColor,
      //       pinned: true,
      //       elevation: 0,
      //       centerTitle: true,
      //       leading: IconButton(
      //         icon: Icon(
      //           MyFlutterApp.angle_double_left,
      //           size: 20,
      //           color: AppColors.astronautCanvasColor,
      //         ),
      //         onPressed: () => widget.popPage
      //         ? Navigator.of(context).pop()
      //         : Navigator.pushReplacement(
      //             context,
      //             PageTransition(
      //               type: PageTransitionType.leftToRightJoined,
      //               child: DevicesPageList(),
      //               childCurrent: widget.currentPage,
      //             ),
      //           ),
      //       ),
      //       title: Text(
      //          widget.pageTitle,
      //         style: TextStyle(
      //           fontSize: 18,
      //           color: AppColors.astronautCanvasColor,
      //           fontFamily: 'Astronaut_PersonalUse',
      //         ),
      //       ),
      //     ),
      //     widget.pageData
      //   ],
      // ),
      body: widget.pageData,
    );
  }
}
