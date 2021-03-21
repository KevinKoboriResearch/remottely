import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/utils/constants.dart';
import 'package:date_format/date_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DeviceHistoryPageItem extends StatefulWidget {
  final AsyncSnapshot<QuerySnapshot> deviceHistorySnapshot;
  DeviceHistoryPageItem(this.deviceHistorySnapshot);

  @override
  _DeviceHistoryPageItemState createState() => _DeviceHistoryPageItemState();
}

class _DeviceHistoryPageItemState extends State<DeviceHistoryPageItem> {
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 830,
        childAspectRatio: 4.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          DateTime todayDate = DateTime.parse(widget.deviceHistorySnapshot.data
              .docs[index]['deviceTriggeredDateTime']);
          return Padding(
            padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
            child: Column(
              children: [
                Neumorphic(
                  style: NeumorphicStyle(
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(6),
                    ),
                    depth: 3,
                    color: AppColors.astratosDarkGreyColor,
                  ),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          // height: 80,
                          padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 10.0),
                          width: (kIsWeb
                              ? 507
                              : MediaQuery.maybeOf(context).size.width),
                          child: ListTile(
                            dense: true,
                            title: Text(
                              'Usuário : ${widget.deviceHistorySnapshot.data.docs[index]['deviceTriggeredUser']['userEmail']}\nEmail: ${widget.deviceHistorySnapshot.data.docs[index]['deviceTriggeredUser']['userEmail']}\nDistância : 103m.',
                              style: TextStyle(
                                color: AppColors.astronautCanvasColor,
                              ),
                            ),
                            subtitle: Text(
                              'Data :  ' +
                                  formatDate(todayDate, [
                                    dd,
                                    '/',
                                    mm,
                                    '/',
                                    yyyy,
                                    ' - ',
                                    HH,
                                    ':',
                                    nn,
                                    ':',
                                    ss,
                                  ]),
                              style: TextStyle(
                                color: AppColors.accentColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        childCount: widget.deviceHistorySnapshot.data.docs.length,
      ),
    );
  }
}
