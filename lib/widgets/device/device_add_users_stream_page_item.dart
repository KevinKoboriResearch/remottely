import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/utils/constants.dart';
import 'package:date_format/date_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/material.dart';
import 'package:remottely/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:remottely/widgets/design/app_clipper.dart';
import 'package:remottely/views/device/device_form_page.dart';
import 'package:remottely/views/device/device_detail_page.dart';

import 'package:remottely/data/firestore/users_collection.dart';
import 'package:remottely/data/firestore/friendships_collection.dart';
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

class DeviceAddUsersStreamPageItem extends StatefulWidget {
  final String type;
  var device;
  final AsyncSnapshot<QuerySnapshot> usersListSnapshot;
  DeviceAddUsersStreamPageItem(this.type, this.device, this.usersListSnapshot);

  @override
  _DeviceAddUsersStreamPageItemState createState() =>
      _DeviceAddUsersStreamPageItemState();
}

class _DeviceAddUsersStreamPageItemState
    extends State<DeviceAddUsersStreamPageItem> {
  @override
  Widget build(BuildContext context) {
    var usersList = widget.device['deviceUsers'];
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 830,
        childAspectRatio: 3.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return StreamBuilder(
              stream: UsersCollection()
                  .userSnapshots(widget.usersListSnapshot.data.docs[index].id),
              // .userSnapshots('z1GwphLVQgU8m46H8sDDI4NUxH83'),
              builder: (context, snapshot) {
                return Center(
                  child: Container(
                    width: (kIsWeb
                            ? 507
                            : MediaQuery.maybeOf(context).size.width) *
                        0.95,
                    child: GestureDetector(
                      onTap: () {},
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              height: 120,
                              width: (kIsWeb
                                  ? 507
                                  : MediaQuery.maybeOf(context).size.width),
                              color: AppColors.astratosDarkGreyColor,
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: ClipPath(
                              clipper: AppClipper2(),
                              child: FadeInImage(
                                height: 120,
                                width: (kIsWeb
                                        ? 507
                                        : MediaQuery.maybeOf(context)
                                            .size
                                            .width) *
                                    0.5,
                                placeholder: AssetImage('assets/logo/logo.png'),
                                image: snapshot.data['userImageUrl'] != ''
                                    ? NetworkImage(
                                        snapshot.data['userImageUrl'])
                                    : AssetImage('assets/logo/logo.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            height: 120,
                            width: (kIsWeb
                                ? 507
                                : MediaQuery.maybeOf(context).size.width),
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                Spacer(),
                                Container(
                                  width: ((kIsWeb
                                              ? 507
                                              : MediaQuery.maybeOf(context)
                                                  .size
                                                  .width) *
                                          0.44) *
                                      0.80,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "${widget.type}".toUpperCase(),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: AppColors.accentColor,
                                          height: 1.4,
                                          fontSize: 10,
                                        ),
                                      ),
                                      Text(
                                        "${snapshot.data["userName"]}"
                                            .toUpperCase(),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          height: 1.4,
                                          fontSize: 10,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${snapshot.data["userName"]}"
                                            .toUpperCase(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: AppColors.astronautCanvasColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        "${snapshot.data["userName"]}"
                                            .toUpperCase(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: AppColors.astronautCanvasColor,
                                          height: 1.4,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 4),
                                Column(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      child: NeumorphicButton(
                                        onPressed: () {
                                          // widget.device['deviceUsers'] = [];
                                          // oi.add('${snapshot.data["userId"]}');
                                          // widget.device['deviceUsers'] = oi;
                                          // .add(
                                          //     '${snapshot.data["userId"]}');
                                          // print(
                                          //     'UHAAAAAUHAAAAAUHAAAAAUHAAAAA:' +
                                          //         widget.device["deviceUsers"]
                                          //             .toString());
                                          // print(
                                          //     'UHAAAAAUHAAAAAUHAAAAAUHAAAAA:${snapshot.data["userId"]}');
                                          var teste = usersList
                                              .contains(
                                                  snapshot.data["userId"]);
                                          if (!teste) {
                                            usersList
                                                .add(snapshot.data["userId"]);
                                            DevicesCollection()
                                                .deviceUpdateDeviceUsers(
                                              widget.device,
                                              usersList,
                                            );
                                          }
                                          // .then((value) {});
                                          // FriendshipCollection()
                                          //     .friendshipRequestSet(
                                          //         widget.usersListSnapshot.data
                                          //             .docs[index],
                                          //         widget.type)
                                          //     .then((value) {

                                          // });
                                        },
                                        style: NeumorphicStyle(
                                          boxShape:
                                              NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(4),
                                          ),
                                          color: AppColors.astratosGreyColor
                                              .withOpacity(0.2),
                                          depth: 1,
                                        ),
                                        padding: const EdgeInsets.all(6.0),
                                        child: Icon(
                                          usersList
                                              .contains(
                                                  snapshot.data["userId"]) ?
                                                  MyFlutterApp.user_edit : MyFlutterApp.user_plus,
                                          // widget.type == 'removed'
                                          //     ? MyFlutterApp.user_edit
                                          //     : widget.type == 'accepted'
                                          //         ? MyFlutterApp.user_plus
                                          //         : widget.type == 'sent'
                                          //             ? MyFlutterApp.user_plus
                                          //             : MyFlutterApp.user_lock,
                                          color: usersList
                                              .contains(
                                                  snapshot.data["userId"]) ?
                                                  AppColors.whiteColor : AppColors.greenColor,
                                          // widget.type == 'contacts'
                                          //     ? AppColors.whiteColor
                                          //     : widget.type == 'add'
                                          //         ? AppColors.greenColor
                                          //         : widget.type == 'invites'
                                          //             ? AppColors.blueColor
                                          //             : AppColors.redColor,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    // widget.type == 'invites'
                                    //     ? Icon(
                                    //         widget.type != 'invites'
                                    //             ? MyFlutterApp.verified_user
                                    //             : MyFlutterApp.verified_user,
                                    //         color: AppColors.greenColor,
                                    //         size: 16,
                                    //       )
                                    //     : Container(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
        childCount: widget.usersListSnapshot.data.docs.length,
      ),
    );
  }
}
