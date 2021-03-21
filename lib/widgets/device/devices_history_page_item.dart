import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/views/device/device_history_page_list.dart';
import 'package:remottely/utils/constants.dart';
import 'package:remottely/data/firestore/devices_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remottely/utils/my_flutter_app_icons_2.dart';
import 'dart:ui';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DevicesHistoryPageItem extends StatefulWidget {
  final AsyncSnapshot<QuerySnapshot> devicesHistorySnapshot;
  DevicesHistoryPageItem(this.devicesHistorySnapshot);

  @override
  _DevicesHistoryPageItemState createState() => _DevicesHistoryPageItemState();
}

class _DevicesHistoryPageItemState extends State<DevicesHistoryPageItem> {
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 830,
        childAspectRatio: 4.4,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: EdgeInsets.fromLTRB(
                8.0, kIsWeb ? 8.0 : 16.0, 8.0, 0.0),
            child: Column(
              children: <Widget>[
                Neumorphic(
                  style: NeumorphicStyle(
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(6),
                    ),
                    depth: 2,
                    color: AppColors.astratosDarkGreyColor,
                  ),
                  child: Container(
                    width:
                        (kIsWeb ? 507 : MediaQuery.maybeOf(context).size.width),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.astratosDarkGreyColor,
                        backgroundImage: widget.devicesHistorySnapshot.data
                                    .docs[index]['deviceImage']['deviceImageUrl'] !=
                                ''
                            ? NetworkImage(widget.devicesHistorySnapshot.data
                                .docs[index]['deviceImage']['deviceImageUrl'])
                            : AssetImage('assets/logo/logo.png'),
                      ),
                      title: Text(
                        widget.devicesHistorySnapshot.data.docs[index]
                            ['deviceTitle'],
                        maxLines: 1,
                        style: TextStyle(
                          color: AppColors.astronautCanvasColor,
                        ),
                      ),
                      subtitle: Text(
                        widget.devicesHistorySnapshot.data.docs[index]
                            ['deviceProperty'],
                        maxLines: 1,
                        style: TextStyle(
                          color: AppColors.astronautCanvasColor,
                        ),
                      ),
                      trailing: Container(
                        width: 80,
                        child: Row(
                          children: <Widget>[
                            Spacer(),
                            Container(
                              width: 50,
                              child: NeumorphicButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: DeviceHistoryPageList(widget
                                          .devicesHistorySnapshot
                                          .data
                                          .docs[index]),
                                    ),
                                  );
                                },
                                style: NeumorphicStyle(
                                  boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(4),
                                  ),
                                  color: AppColors.astratosGreyColor
                                      .withOpacity(0.2),
                                  depth: 1,
                                ),
                                padding: const EdgeInsets.all(6.0),
                                child: Icon(
                                  MyFlutterApp2.angle_double_right,
                                  color: AppColors.accentColor,
                                  size: 26,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        childCount: widget.devicesHistorySnapshot.data.docs.length,
      ),
    );
  }
}
