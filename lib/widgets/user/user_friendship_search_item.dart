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

import 'package:remottely/data/firestore/friendships_collection.dart';

class UserFriendshipSearchItem extends StatefulWidget {
  final String type;
  final index;
  final AsyncSnapshot<QuerySnapshot> usersListSnapshot;
  UserFriendshipSearchItem(this.type, this.usersListSnapshot, this.index);

  @override
  _UserFriendshipSearchItemState createState() =>
      _UserFriendshipSearchItemState();
}

class _UserFriendshipSearchItemState extends State<UserFriendshipSearchItem> {
  @override
  Widget build(BuildContext context) {
    // return SliverGrid(
    //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
    //     maxCrossAxisExtent: 830,
    //     childAspectRatio: 3.0,
    //   ),
    //   delegate: SliverChildBuilderDelegate(
    //     (context, widget.index) {
          bool added = false;
          return Center(
            child: Container(
              width: (kIsWeb ? 400 : MediaQuery.maybeOf(context).size.width) *
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
                            ? 400
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
                                  ? 400
                                  : MediaQuery.maybeOf(context).size.width) *
                              0.5,
                          placeholder: AssetImage('assets/logo/logo.png'),
                          image: widget.usersListSnapshot.data.docs[widget.index]
                                      ['userImageUrl'] !=
                                  ''
                              ? NetworkImage(widget.usersListSnapshot.data
                                  .docs[widget.index]['userImageUrl'])
                              : AssetImage('assets/logo/logo.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: 120,
                      width: (kIsWeb
                          ? 400
                          : MediaQuery.maybeOf(context).size.width),
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          Spacer(),
                          Container(
                            width: ((kIsWeb
                                        ? 400
                                        : MediaQuery.maybeOf(context)
                                            .size
                                            .width) *
                                    0.44) *
                                0.80,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "${widget.usersListSnapshot.data.docs[widget.index]['userName']}"
                                      .toUpperCase(),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppColors.accentColor,
                                    height: 1.4,
                                    fontSize: 10,
                                  ),
                                ),
                                Text(
                                  "${widget.usersListSnapshot.data.docs[widget.index]['userName']}"
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
                                  "${widget.usersListSnapshot.data.docs[widget.index]['userName']}"
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
                                  "${widget.usersListSnapshot.data.docs[widget.index]['userName']}"
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
                                    FriendshipCollection().friendshipRequestSet(
                                        widget
                                            .usersListSnapshot.data.docs[widget.index],
                                        widget.type);
                                    setState(() {
                                      added = !added;
                                    });
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
                                    added
                                        ? MyFlutterApp.user_edit
                                        : MyFlutterApp.user_lock,
                                    // widget.type == 'contacts'
                                    //     ? MyFlutterApp.user_4
                                    //     : widget.type == 'add'
                                    //         ? MyFlutterApp.user_plus
                                    //         : widget.type == 'invites'
                                    //             ? MyFlutterApp.user_edit
                                    //             : MyFlutterApp.user_lock,
                                    color: widget.type == 'contacts'
                                        ? AppColors.whiteColor
                                        : widget.type == 'add'
                                            ? AppColors.greenColor
                                            : widget.type == 'invites'
                                                ? AppColors.blueColor
                                                : AppColors.redColor,
                                    size: 24,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Icon(
                                added
                                    ? MyFlutterApp.verified_user
                                    : MyFlutterApp.user_lock,
                                color: AppColors.greenColor,
                                size: 16,
                              ),
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
    //     },
    //     childCount: widget.usersListSnapshot.data.docs.length,
    //   ),
    // );
  }
}
