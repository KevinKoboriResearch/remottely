import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/material.dart';
import 'package:remottely/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:remottely/widgets/design/app_clipper.dart';
import 'package:remottely/views/device/device_form_page.dart';
import 'package:remottely/views/device/device_detail_page.dart';

class DevicesManagePageItem extends StatefulWidget {
  final AsyncSnapshot<QuerySnapshot> devicesSnapshot;
  DevicesManagePageItem(this.devicesSnapshot);

  @override
  _DevicesManagePageItemState createState() => _DevicesManagePageItemState();
}

class _DevicesManagePageItemState extends State<DevicesManagePageItem> {
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 830,
        childAspectRatio: 3.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Center(
            child: Container(
              width: (kIsWeb ? 507 : MediaQuery.maybeOf(context).size.width) *
                  0.95,
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
                                  : MediaQuery.maybeOf(context).size.width) *
                              0.5,
                          placeholder: AssetImage('assets/logo/logo.png'),
                          image: widget.devicesSnapshot.data.docs[index]
                                      ['deviceImage']['deviceImageUrl'] !=
                                  ''
                              ? NetworkImage(widget.devicesSnapshot.data
                                  .docs[index]['deviceImage']['deviceImageUrl'])
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "${widget.devicesSnapshot.data.docs[index]['deviceUsers'][0]}"
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
                                  "${widget.devicesSnapshot.data.docs[index]['deviceUsers'][0]}"
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
                                  "${widget.devicesSnapshot.data.docs[index]['deviceTitle']}"
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
                                  "${widget.devicesSnapshot.data.docs[index]['deviceProperty']}"
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
                                child: NeumorphicButton(
                                  onPressed: () {
                                    // Navigator.of(context).pushNamed(
                                    //   AppRoutes.DEVICE_FORM,
                                    //   arguments:
                                    //       widget.devicesSnapshot.data.docs[index],
                                    // );
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => DeviceFormPage(widget.devicesSnapshot.data.docs[index]),
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
                                    MyFlutterApp.pencil_alt,
                                    color: AppColors.accentColor,
                                    size: 28,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 2.0),
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
                                ],
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
