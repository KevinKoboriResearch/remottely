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
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/widgets/layouts/layout_push.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remottely/data/firestore/notifications_collection.dart';
import 'package:remottely/widgets/user/user_notifications_page_item.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:remottely/exceptions/check_internet_connection.dart';
  class UserNotifications extends StatefulWidget {
  @override
  _UserNotificationsState createState() => _UserNotificationsState();
}

class _UserNotificationsState extends State<UserNotifications> {
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
    return Scaffold(
      backgroundColor: AppColors.astronautCanvasColor,
      extendBody: true,
      body: Builder(
        builder: (context) {
          return StreamBuilder(
            stream: NotificationsCollection()
                .userNotificationSnapshots(), //Devices().devicesUserSnapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> userNotificationsSnapshot) {
              if (!userNotificationsSnapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return LayoutCustomScrollView(
                  1, UserNotifications(), 'N O T I F I C A Ç Õ E S', userNotificationsSnapshot, UserNotificationsPageItem(userNotificationsSnapshot));
            },
          );
        },
      ),
    );
  }
}
