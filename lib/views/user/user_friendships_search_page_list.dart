import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/utils/constants.dart';
import 'package:remottely/views/control/drawer_page.dart';
import 'package:remottely/widgets/device/devices_page_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remottely/data/firestore/devices_collection.dart';
import 'package:remottely/widgets/layouts/layout_custom_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/widgets/layouts/layout_push.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remottely/data/firestore/notifications_collection.dart';
import 'package:remottely/widgets/user/user_notifications_page_item.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:remottely/utils/my_flutter_app_icons_2.dart';
import 'package:remottely/utils/constants.dart';
import 'dart:ui';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'dart:async';
import 'package:remottely/widgets/layouts/layout_push.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/utils/my_flutter_app_icons_2.dart';
import 'package:remottely/widgets/design/app_clipper.dart';
import 'package:remottely/utils/constants.dart';
import 'package:remottely/functions/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remottely/data/firestore/device_triggered_collection.dart';
import 'package:remottely/data/firestore/devices_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/widgets/layouts/layout_push.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:remottely/utils/constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/data/firestore/users_collection.dart';
import 'dart:ui';
import 'dart:convert';
import 'package:firebase_admin/firebase_admin.dart';
import 'package:firebase_admin/src/credential.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/utils/constants.dart';
import 'package:remottely/views/control/drawer_page.dart';
import 'package:remottely/widgets/device/devices_manage_page_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remottely/data/firestore/devices_collection.dart';
import 'package:remottely/widgets/layouts/layout_custom_scroll_view.dart';
import 'package:remottely/widgets/user/user_friendship_search_item.dart';
import 'package:flutter/material.dart';

import 'package:remottely/data/firestore/friendships_collection.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:remottely/exceptions/check_internet_connection.dart';
class UserFriendshipsSearchPageList extends StatefulWidget {
  // var friends;
  // UserFriendshipsSearchPageList(this.friends);

  @override
  _UserFriendshipsSearchPageListState createState() =>
      _UserFriendshipsSearchPageListState();
}

class _UserFriendshipsSearchPageListState
    extends State<UserFriendshipsSearchPageList> {


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
    // var friends = FriendshipCollection().friendsList();
    return Scaffold(
      backgroundColor: AppColors.astronautCanvasColor,
      extendBody: true,
      body: Builder(
        builder: (context) {
          return FutureBuilder(
            future: FriendshipCollection().userFriendshipsSearchSnapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> userFriendshipsSearchSnapshot) {
              if (!userFriendshipsSearchSnapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return LayoutCustomScrollView(
                1,
                UserFriendshipsSearchPageList(),
                'P E S Q U I S A R',
                userFriendshipsSearchSnapshot,
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 830,
                    childAspectRatio: 3.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return UserFriendshipSearchItem(
                          'sent', userFriendshipsSearchSnapshot, index);
                    },
                  childCount: userFriendshipsSearchSnapshot.data.docs.length,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
