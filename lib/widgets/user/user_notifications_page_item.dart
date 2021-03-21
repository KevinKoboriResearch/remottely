import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/utils/constants.dart';
import 'package:date_format/date_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class UserNotificationsPageItem extends StatefulWidget {
  final AsyncSnapshot<QuerySnapshot> userNotificationsSnapshot;
  UserNotificationsPageItem(this.userNotificationsSnapshot);

  @override
  _UserNotificationsPageItemState createState() =>
      _UserNotificationsPageItemState();
}

class _UserNotificationsPageItemState extends State<UserNotificationsPageItem> {
  @override
  Widget build(BuildContext context) {
    // DateTime todayDate =
    //     DateTime.parse(widget.deviceHistory['deviceTriggeredDateTime']);
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 830,
        childAspectRatio: 4.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          DateTime todayDate = DateTime.parse(widget
              .userNotificationsSnapshot.data.docs[index]['userNotificationDateTime']);
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
                              '${widget.userNotificationsSnapshot.data.docs[index]['userNotificationTitle']}\n${widget.userNotificationsSnapshot.data.docs[index]['userNotificationDesc']}',
                              style: TextStyle(
                                color: AppColors.astronautCanvasColor,
                              ),
                            ),
                            subtitle: Text(
                              'Data :  ' +
                                  formatDate(todayDate, [
                                    yyyy,
                                    '/',
                                    mm,
                                    '/',
                                    dd,
                                    ' - ',
                                    hh,
                                    ':',
                                    nn,
                                    ':',
                                    ss,
                                    ' ',
                                    am
                                  ]),
                              style: TextStyle(
                                color: AppColors.astratosBlueColor,
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
        childCount: widget.userNotificationsSnapshot.data.docs.length,
      ),
    );
  }
}
