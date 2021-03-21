import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remottely/widgets/layouts/layout_custom_scroll_view.dart';
import 'package:remottely/widgets/device/device_add_users_stream_page_item.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/material.dart';
import 'package:remottely/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:remottely/utils/my_flutter_app_icons_2.dart';
import 'package:remottely/widgets/device/device_key_dialog.dart';
import 'package:remottely/widgets/design/app_clipper.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:remottely/views/device/device_detail_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:remottely/data/firestore/friendships_collection.dart';
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
import 'package:remottely/data/firestore/friendships_collection.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:remottely/exceptions/check_internet_connection.dart';

class DeviceAddUsersPageList extends StatefulWidget {
  var device;
  DeviceAddUsersPageList(this.device);

  @override
  _DeviceAddUsersPageListState createState() => _DeviceAddUsersPageListState();
}

class _DeviceAddUsersPageListState extends State<DeviceAddUsersPageList> {
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
          return FutureBuilder(
            future: DevicesCollection()
                .userFriendshipsAcceptedNotIncludedSnapshots(widget.device),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> userFriendshipsSnapshots) {
              if (!userFriendshipsSnapshots.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return LayoutCustomScrollView(
                  1,
                  DeviceAddUsersPageList(widget.device),
                  // DeviceDetailPage(widget.device),
                  'A U T O R I Z A R',
                  userFriendshipsSnapshots,
                  DeviceAddUsersStreamPageItem(
                      'autotization', widget.device, userFriendshipsSnapshots));
            },
          );
        },
      ),
    );
  }
}
