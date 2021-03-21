import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/utils/constants.dart';
import 'package:remottely/views/control/drawer_page.dart';
import 'package:remottely/widgets/device/devices_manage_page_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remottely/data/firestore/devices_collection.dart';
import 'package:remottely/widgets/layouts/layout_custom_scroll_view.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:remottely/exceptions/check_internet_connection.dart';
    class DevicesManagePageList extends StatefulWidget {
  @override
  _DevicesManagePageListState createState() => _DevicesManagePageListState();
}

class _DevicesManagePageListState extends State<DevicesManagePageList> {
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
      drawer: DrawerPage(),
      backgroundColor: AppColors.astronautCanvasColor,
      extendBody: true,
      body: Builder(
        builder: (context) {
          return StreamBuilder(
            stream: DevicesCollection().devicesUserSnapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return LayoutCustomScrollView(
                  0, DevicesManagePageList(), 'G E R E N C I A R', snapshot, DevicesManagePageItem(snapshot));
            },
          );
        },
      ),
    );
  }
}
