import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/data/firestore/device_triggered_collection.dart';
import 'package:remottely/widgets/device/device_history_page_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remottely/widgets/layouts/layout_push.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:remottely/exceptions/check_internet_connection.dart';
class DeviceHistoryPageList extends StatefulWidget {
  final QueryDocumentSnapshot device;
  DeviceHistoryPageList(this.device);

  @override
  _DeviceHistoryPageListState createState() => _DeviceHistoryPageListState();
}

class _DeviceHistoryPageListState extends State<DeviceHistoryPageList> {
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
    return LayoutPush(
      true,
      DeviceHistoryPageList(widget.device),
      widget.device['deviceTitle'],
      StreamBuilder(
        stream: DeviceTriggered().deviceTriggeredSnapshots(widget.device.id),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> deviceHistorySnapshot) {
          if (!deviceHistorySnapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return CustomScrollView(
            slivers: <Widget>[
              DeviceHistoryPageItem(deviceHistorySnapshot),
               SliverToBoxAdapter(
                    child: SizedBox(
                      height: 70,
                    ),
                  ),
            ],
          );
        },
      ),
    );
  }
}
