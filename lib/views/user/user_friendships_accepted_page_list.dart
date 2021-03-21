import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remottely/widgets/layouts/layout_custom_scroll_view.dart';
import 'package:remottely/data/firestore/users_collection.dart';
import 'package:remottely/widgets/user/user_friendship_stream_item.dart';
import 'package:remottely/views/user/user_friendships_search_page_list.dart';
import 'package:remottely/views/user/user_friendships_blocked_page_list.dart';
import 'package:remottely/views/user/user_friendships_arrived_page_list.dart';
import 'package:remottely/views/user/user_friendships_sent_page_list.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'dart:ui';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:remottely/utils/my_flutter_app_icons_2.dart';

import 'package:remottely/data/firestore/friendships_collection.dart';

import 'package:remottely/data/firestore/friendships_collection.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:remottely/exceptions/check_internet_connection.dart';
    class UserFriendshipsAcceptedPageList extends StatefulWidget {
  @override
  _UserFriendshipsAcceptedPageListState createState() => _UserFriendshipsAcceptedPageListState();
}

class _UserFriendshipsAcceptedPageListState extends State<UserFriendshipsAcceptedPageList> {
  BuildContext contextPage;
  int contextPageNum = 0;
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

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
    contextPage = context;
    return Scaffold(
      backgroundColor: AppColors.astronautCanvasColor,
      extendBody: true,
      body: Builder(
        builder: (context) {
          return StreamBuilder(
            stream: FriendshipCollection().userFriendshipsAcceptedSnapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> notificationsSnapshot) {
              if (!notificationsSnapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return LayoutCustomScrollView(
                  1,
                  UserFriendshipsAcceptedPageList(),
                  'C O N T A T O S',
                  notificationsSnapshot,
                  UserFriendshipStreamItem('blocked', notificationsSnapshot));
            },
          );
        },
      ),
      floatingActionButton: SpeedDial(
        marginEnd: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        // label: Text("OPEN"),
        // activeLabel: Text("CLOSE"),
        buttonSize: 56.0,
        visible: true,
        closeManually: false,
        renderOverlay: false,
        curve: Curves.bounceIn,
        overlayColor: AppColors.astratosDarkGreyColor,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'ABRIR DIALOG',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: AppColors.accentColor,
        foregroundColor: AppColors.astratosDarkGreyColor,
        elevation: 8.0,
        children: [
          SpeedDialChild(
            child: Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Icon(
                MyFlutterApp.user_plus,
              ),
            ),
            backgroundColor: Colors.green,
            label: 'Procurar Usuários',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              // var friends = await FriendshipCollection().friendsList();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UserFriendshipsSearchPageList(),//friends),
                ),
              );
            },
          ),
          SpeedDialChild(
            child: Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Icon(
                MyFlutterApp.user_friends,
              ),
            ),
            backgroundColor: Colors.blue,
            label: 'Pedidos a Aceitar',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UserFriendshipsArrivedPageList(),
                ),
              );
            },
          ),
          SpeedDialChild(
            child: Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Icon(
                MyFlutterApp.user_edit,
              ),
            ),
            backgroundColor: Colors.yellow,
            label: 'Pedidos Enviados',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UserFriendshipsSentPageList(),
                ),
              );
            },
          ),
          SpeedDialChild(
            child: Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Icon(
                MyFlutterApp.user_lock,
              ),
            ),
            backgroundColor: Colors.red,
            label: 'Usuários Bloqueados',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UserFriendshipsBlockedPageList(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
