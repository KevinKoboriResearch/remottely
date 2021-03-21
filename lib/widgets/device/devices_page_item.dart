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

class DevicesPageItem extends StatefulWidget {
  final AsyncSnapshot<QuerySnapshot> devicesSnapshot;
  DevicesPageItem(this.devicesSnapshot);

  @override
  _DevicesPageItemState createState() => _DevicesPageItemState();
}

class _DevicesPageItemState extends State<DevicesPageItem> {
  // @override
  // void initState() {
  //   super.initState();
  //   bool isManager = widget.device['deviceManagers']
  //       .contains('A1fFrPGWCPdSixXZ9T5qxwtRGD82');
  // }
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 830,
        childAspectRatio: 1.7,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
              child: GestureDetector(
                onTap: () {
                  // Navigator.of(context).pushNamed(
                  //   AppRoutes.DEVICE_DETAIL,
                  //   arguments: widget.devicesSnapshot.data.docs[index],
                  // );
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DeviceDetailPage(
                          widget.devicesSnapshot.data.docs[index]),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: 220,
                        width: (kIsWeb
                            ? 400
                            : MediaQuery.maybeOf(context).size.width),
                        color: AppColors.astratosDarkGreyColor,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: ClipPath(
                        clipper: AppClipper(),
                        child: FadeInImage(
                          height: 220,
                          width: (kIsWeb
                              ? 400
                              : MediaQuery.maybeOf(context).size.width),
                          placeholder: AssetImage('assets/logo/logo.png'),
                          image: widget.devicesSnapshot.data.docs[index]
                                      ['deviceImage']['deviceImageUrl'] != ''
                              ? NetworkImage(widget.devicesSnapshot.data
                                  .docs[index]['deviceImage']['deviceImageUrl'])
                              : AssetImage('assets/logo/logo.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Neumorphic(
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(12),
                        ),
                        depth: 3,
                        lightSource: LightSource.topLeft,
                        color: Colors.transparent,
                      ),
                      child: Container(
                        height: 220,
                        width: (kIsWeb
                            ? 400
                            : MediaQuery.maybeOf(context).size.width),
                        color: AppColors.astratosDarkGreyColor.withOpacity(0.8),
                      ),
                    ),
                    Container(
                      height: 220,
                      width: (kIsWeb
                          ? 400
                          : MediaQuery.maybeOf(context).size.width),
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: (kIsWeb
                                    ? 400
                                    : MediaQuery.maybeOf(context).size.width) *
                                0.69,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Image(
                                      height: 28,
                                      width: 28,
                                      image: AssetImage(
                                        "assets/logo/remottely_light.png",
                                      ),
                                      filterQuality: FilterQuality.high,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(width: 12),
                                    Container(
                                      width: (kIsWeb
                                              ? 400
                                              : MediaQuery.maybeOf(context)
                                                  .size
                                                  .width) *
                                          0.5,
                                      child: Text(
                                        "R E M O T T E L Y",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: AppColors.astronautCanvasColor,
                                          fontFamily: 'Anurati',
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    widget.devicesSnapshot.data
                                            .docs[index]['deviceManagers']
                                            .contains(auth.currentUser.uid)
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4.0),
                                            child: Icon(
                                              Icons.settings,
                                              color: AppColors.accentColor,
                                              size: 16,
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Icon(
                                    MyFlutterApp.user_friends,
                                    color: AppColors.astronautCanvasColor,
                                    size: 16,
                                  ),
                                ),
                                Container(
                                  width: 28,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      widget.devicesSnapshot.data
                                          .docs[index]['deviceUsers'].length
                                          .toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.astronautCanvasColor,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 26),
                                Text(
                                  widget.devicesSnapshot.data
                                      .docs[index]['deviceTitle']
                                      .toUpperCase(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppColors.astronautCanvasColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  widget.devicesSnapshot.data
                                      .docs[index]['deviceProperty']
                                      .toUpperCase(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppColors.astronautCanvasColor,
                                    height: 1.4,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Column(
                            children: [
                              SizedBox(height: 4),
                              widget.devicesSnapshot.data.docs[index]
                                          ['deviceVerified'] ==
                                      true
                                  ? Container(
                                      padding:
                                          const EdgeInsets.only(right: 4.0),
                                      width: 30,
                                      child: Icon(
                                        MyFlutterApp.verified_user,
                                        size: 20,
                                        color: AppColors.greenColor,
                                      ),
                                    )
                                  : Container(),
                              Container(
                                width: 30,
                                height: 10,
                              ),
                              Spacer(),
                              Container(
                                width: 30,
                                child: NeumorphicIcon(
                                  MyFlutterApp2.barcode,
                                  size: 20,
                                  style: NeumorphicStyle(
                                    boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(6),
                                    ),
                                    color: AppColors.astratosDarkGreyColor,
                                    depth: 1,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: 30,
                                child: NeumorphicIcon(
                                  MyFlutterApp2.barcode,
                                  size: 20,
                                  style: NeumorphicStyle(
                                    boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(6),
                                    ),
                                    color: AppColors.astratosDarkGreyColor,
                                    depth: 1,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: 40,
                                child: NeumorphicButton(
                                  onPressed: () {
                                    deviceKeyDialog(
                                        context,
                                        widget
                                            .devicesSnapshot.data.docs[index]);
                                  },
                                  style: NeumorphicStyle(
                                    boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(4),
                                    ),
                                    color: AppColors.astratosGreyColor
                                        .withOpacity(0.299),
                                    depth: 1,
                                  ),
                                  padding: const EdgeInsets.all(6.0),
                                  child: Icon(
                                    MyFlutterApp.remottely_key,
                                    color: AppColors.accentColor,
                                    size: 28,
                                  ),
                                ),
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
        },
        childCount: widget.devicesSnapshot.data.docs.length,
      ),
    );
  }
}
