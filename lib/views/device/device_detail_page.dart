import 'dart:async';

import 'package:flutter/material.dart';
import 'package:remottely/widgets/design/app_clipper.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:remottely/utils/constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:remottely/utils/my_flutter_app_icons_2.dart';
import 'package:remottely/functions/streams.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:ui';
import 'dart:convert';
import 'package:remottely/models/user_model.dart';
import 'package:provider/provider.dart';
//detect if user exist in firebase
//send request to become a manager
import 'package:firebase_auth/firebase_auth.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/utils/constants.dart';
import 'package:remottely/views/control/drawer_page.dart';
import 'package:remottely/widgets/device/devices_page_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remottely/data/firestore/devices_collection.dart';
import 'package:remottely/widgets/layouts/layout_custom_scroll_view.dart';
import 'package:remottely/views/device/device_form_page.dart';

import 'package:remottely/views/device/device_add_users_page_list.dart';
import 'package:remottely/data/firestore/friendships_collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/utils/constants.dart';
import 'package:remottely/views/control/drawer_page.dart';
import 'package:remottely/widgets/device/devices_page_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remottely/data/firestore/devices_collection.dart';
import 'package:remottely/widgets/layouts/layout_custom_scroll_view.dart';
import 'package:remottely/views/device/device_form_page.dart';
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
import 'package:remottely/views/device/device_add_users_page_list.dart';
import 'package:remottely/data/firestore/friendships_collection.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:remottely/exceptions/check_internet_connection.dart';
class DeviceDetailPage extends StatefulWidget {
  final device;
  DeviceDetailPage(this.device);

  @override
  _DeviceDetailPageState createState() => _DeviceDetailPageState();
}

class _DeviceDetailPageState extends State<DeviceDetailPage> {
  final auth = FirebaseAuth.instance;
  // var hey;
  @override
  void initState() {
    super.initState();
    // CheckInternet().checkConnection(context);
  }

  @override
  void dispose() {
    // CheckInternet().listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DevicesCollection().deviceSnapshots(widget.device.id),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          backgroundColor: AppColors.astratosDarkGreyColor,
          extendBody: true,
          body: Builder(
            builder: (context) {
              return CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    pinned: true,
                    toolbarHeight: 44,
                    elevation: 0,
                    leading: IconButton(
                      icon: Icon(
                        MyFlutterApp.left_open_big, //angle_double_left,
                        size: 20,
                        color: AppColors.astronautCanvasColor,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    backgroundColor:
                        AppColors.astratosDarkGreyColor.withOpacity(0.9),
                    centerTitle: true,
                    title: Text(
                      "C H A V E",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Astronaut_PersonalUse',
                        color: AppColors.astronautCanvasColor,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 10,
                    ),
                  ),
                  SliverAppBar(
                    backgroundColor: AppColors.astratosDarkGreyColor,
                    elevation: 0,
                    toolbarHeight: 30,
                    expandedHeight: 186,
                    leading: Container(),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        children: <Widget>[
                          Center(
                            child: FadeInImage(
                              height: 220,
                              width: (kIsWeb
                                  ? 507
                                  : MediaQuery.maybeOf(context)
                                      .size
                                      .width), //* 0.95,
                              placeholder: AssetImage('assets/logo/logo.png'),
                              image: snapshot.data['deviceImage']['deviceImageUrl'] != '' ||
                                      snapshot.data['deviceImage']['deviceImageUrl'] != null
                                  ? NetworkImage(
                                      snapshot.data['deviceImage']['deviceImageUrl'])
                                  : AssetImage('assets/logo/logo.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 48.0),
                              child: ClipPath(
                                clipper: AppClipper3(),
                                child: Container(
                                  width: (kIsWeb
                                      ? 507
                                      : MediaQuery.maybeOf(context).size.width),
                                  color: AppColors.astratosDarkGreyColor
                                      .withOpacity(0.3),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Center(
                      child: Container(
                        width: (kIsWeb
                            ? 507
                            : MediaQuery.maybeOf(context).size.width),
                        padding: const EdgeInsets.only(
                          top: 18.0,
                          left: 12.0,
                          right: 12.0,
                          bottom: 72.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "P R O P R I E D A D E",
                                      style: TextStyle(
                                        color: AppColors.astronautCanvasColor,
                                        fontFamily: 'Astronaut_PersonalUse',
                                        fontSize: 22,
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Container(
                                      width: (kIsWeb
                                              ? 507
                                              : MediaQuery.maybeOf(context)
                                                  .size
                                                  .width) *
                                          0.67,
                                      child: Text(
                                        snapshot.data['deviceProperty']
                                            .toUpperCase(),
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: AppColors.accentColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Spacer(),
                                    Text(
                                      "N U M E R O",
                                      style: TextStyle(
                                        color: AppColors.astronautCanvasColor,
                                        fontFamily: 'Astronaut_PersonalUse',
                                        fontSize: 22,
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Container(
                                      width: (kIsWeb
                                              ? 507
                                              : MediaQuery.maybeOf(context)
                                                  .size
                                                  .width) *
                                          0.26,
                                      child: Text(
                                        snapshot.data['deviceTitle']
                                            .toUpperCase(),
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: AppColors.accentColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    // Spacer(),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 18),
                            Text(
                              snapshot.data['deviceManagers'].length == 1
                                  ? "G E S T O R"
                                  : "G E S T O R E S",
                              style: TextStyle(
                                color: AppColors.astronautCanvasColor,
                                fontFamily: 'Astronaut_PersonalUse',
                                fontSize: 22,
                              ),
                            ),
                            SizedBox(height: 6),
                            Container(
                              width: (kIsWeb
                                      ? 507
                                      : MediaQuery.maybeOf(context)
                                          .size
                                          .width) *
                                  0.93,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: streamUsersList(
                                    snapshot.data['deviceManagers'],
                                    'managers'),
                              ),
                            ),
                            SizedBox(height: 18),
                            Divider(
                              color: AppColors.astronautCanvasColor,
                              height: 10,
                              thickness: 1,
                              indent: 0,
                              endIndent: 0,
                            ),
                            SizedBox(height: 18),
                            Text(
                              "E N D E R E Ç O",
                              style: TextStyle(
                                color: AppColors.astronautCanvasColor,
                                fontFamily: 'Astronaut_PersonalUse',
                                fontSize: 22,
                              ),
                            ),
                            SizedBox(height: 6),
                            Container(
                              width: (kIsWeb
                                      ? 507
                                      : MediaQuery.maybeOf(context)
                                          .size
                                          .width) *
                                  0.93,
                              child: Text(
                                snapshot.data['deviceAdress'] != null
                                    ? snapshot.data['deviceAdress']
                                        .toUpperCase()
                                    : '',
                                style: TextStyle(
                                  color: AppColors.accentColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(height: 18),
                            Row(
                              children: [
                                Text(
                                  "U S U Á R I O S",
                                  style: TextStyle(
                                    color: AppColors.astronautCanvasColor,
                                    fontFamily: 'Astronaut_PersonalUse',
                                    fontSize: 22,
                                  ),
                                ),
                                SizedBox(width: 16),
                                NeumorphicIcon(
                                  MyFlutterApp2.angle_double_right,
                                  style: NeumorphicStyle(
                                    depth: 1,
                                    color: AppColors.astronautCanvasColor,
                                  ),
                                ),
                                SizedBox(width: 16),
                                NeumorphicText(
                                  '${snapshot.data['deviceUsers'].length}',
                                  style: NeumorphicStyle(
                                    depth: 1,
                                    color: AppColors.astronautCanvasColor,
                                  ),
                                  textStyle: NeumorphicTextStyle(
                                    fontFamily: 'Astronaut_PersonalUse',
                                    fontSize: 22,
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                            SizedBox(height: 6),
                            Container(
                              width: (kIsWeb
                                      ? 507
                                      : MediaQuery.maybeOf(context)
                                          .size
                                          .width) *
                                  0.93,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: streamUsersList(
                                    snapshot.data['deviceUsers'], 'users'),
                              ),
                            ),
                            SizedBox(height: 18),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 70,
                    ),
                  ),
                ],
              );
            },
          ),
          bottomNavigationBar:
              snapshot.data['deviceManagers'].contains(auth.currentUser.uid)
                  ? Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 6.0,
                                  sigmaY: 6.0,
                                ),
                                child: Container(
                                  width: (kIsWeb
                                      ? 507
                                      : MediaQuery.maybeOf(context).size.width),
                                  color: AppColors.astronautCanvasColor
                                      .withOpacity(0.1),
                                  padding: const EdgeInsets.only(
                                      top: 16.0,
                                      bottom: 16.0,
                                      left: 32.0,
                                      right: 16.0),
                                  child: _buildBottom(context, snapshot),
                                ),
                              ),
                            ),
                          ]),
                    )
                  : Container(),
        );
      },
    );
  }

  Widget _buildBottom(BuildContext context, dynamic snapshot) {
    return Row(
      children: <Widget>[
        Icon(
          MyFlutterApp.user_friends,
          color: AppColors.astronautCanvasColor,
        ),
        SizedBox(width: 30),
        Container(
          width: (kIsWeb ? 507 : MediaQuery.maybeOf(context).size.width) * 0.3,
          child: Text(
            snapshot.data['deviceUsers'].length.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.astronautCanvasColor,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
        ),
        Spacer(),
        NeumorphicButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DeviceAddUsersPageList(snapshot.data),
              ),
            );
          },
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(18),
            ),
            depth: 1,
          ),
          padding: const EdgeInsets.only(
            top: 14.0,
            bottom: 14.0,
            left: 14.0,
            right: 16.0,
          ),
          child: NeumorphicText(
            'A U T O R I Z A R',
            style: NeumorphicStyle(
              depth: 2,
              color: AppColors.astratosGreyColor,
            ),
            textStyle: NeumorphicTextStyle(
              fontFamily: 'Astronaut_PersonalUse',
              fontSize: 18,
            ),
          ),
        )
      ],
    );
  }
}
