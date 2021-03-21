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
import 'package:remottely/exceptions/check_internet_connection.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

class DevicesPageList extends StatefulWidget {
  @override
  _DevicesPageListState createState() => _DevicesPageListState();
}

class _DevicesPageListState extends State<DevicesPageList> {
  @override
  void initState() {
    super.initState();
    CheckInternet().checkConnection(context);
  }

  @override
  void dispose() {
    CheckInternet().listener.cancel();
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
              return LayoutCustomScrollView(0, DevicesPageList(), 'C H A V E S',
                  snapshot, DevicesPageItem(snapshot));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        onPressed: () {
          // Navigator.of(context).pushNamed(
          //   AppRoutes.DEVICE_FORM,
          // );
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DeviceFormPage(null),
            ),
          );
        },
        child: NeumorphicIcon(
          MyFlutterApp.plus_2,
          size: 42,
          style: NeumorphicStyle(
            depth: 2,
            color: AppColors.astronautCanvasColor,
          ),
        ),
        backgroundColor: AppColors.accentColor,
      ),
    );
  }
}
