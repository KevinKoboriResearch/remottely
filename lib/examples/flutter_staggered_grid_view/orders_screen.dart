import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:remottely/providers/products.dart';
// import 'package:remottely/widgets/products_grid.dart';
// import 'package:remottely/widgets/badge.dart';
// import 'package:remottely/widgets/app_drawer.dart';
// import 'package:remottely/providers/cart.dart';
// import 'package:remottely/utils/app_routes.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart' kIsWeb kIsWeb;
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:remottely/views/device/device_detail_page.dart';
// import 'package:remottely/views/device/devices_manage_page_list.dart';
// import 'package:remottely/views/device/device_form_page.dart';
// final GlobalKey<NavigatorState> navigatorKey =  GlobalKey<NavigatorState>();
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:remottely/widgets/design/app_clipper.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:remottely/utils/constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:remottely/utils/my_flutter_app_icons_2.dart';
import 'package:remottely/functions/streams.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:ui';
import 'dart:convert';
import 'package:remottely/models/user_model.dart';
import 'package:provider/provider.dart';
//detect if user exist in firebase
//send request to become a manager
import 'package:firebase_auth/firebase_auth.dart';
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

import 'package:remottely/views/device/device_add_users_page_list.dart';
import 'package:remottely/data/firestore/friendships_collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:flutter/material.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:remottely/utils/constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math' as math;
import 'package:remottely/widgets/design/buttonPop.dart';
import 'package:flutter/material.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:remottely/utils/constants.dart';
import 'dart:ui';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:page_transition/page_transition.dart';
import 'package:remottely/views/device/devices_page_list.dart';
import 'package:remottely/views/device/device_add_users_page_list.dart';
import 'package:remottely/data/firestore/friendships_collection.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:remottely/exceptions/check_internet_connection.dart';

class OrdersScreen extends StatefulWidget {
  @override
  OrdersScreenState createState() => OrdersScreenState();
}

class OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    // _getLastKnowUserLocation();
  }

  _getImageValues(Future<ui.Image> futureImage) {
    futureImage.then((value) {
      return value;
    });
  }

  // _getImageWidth() async {
  //   await futureImage.then((value) {
  //     return value;
  //   });
  // }
  ui.Image image;
  // Future<ui.Image> futureImage;
  Future<ui.Image> _getImage(String urlImage) async {
    Completer<ui.Image> completer = Completer<ui.Image>();
    //  NetworkImage('https://i.stack.imgur.com/lkd0a.png')
    //   .resolve( ImageConfiguration())
    //   .addListener((ImageInfo info, bool _) => completer.complete(info.image));
    // return completer.future;

    NetworkImage(urlImage)
        .resolve(ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      completer.complete(info.image);
    }));
    // futureImage = completer.future;

    image = await _getImageValues(completer.future);
    // image.width = await _getImageWidth();
    return completer.future;
  }
// FirebaseFirestore.instance.collection('products').snapshots(),
  @override
  Widget build(BuildContext context) {
    // var fatherIndex;
    // ui.Image image;
    // var h = image.width;
    // var w = image.height;
    return Scaffold(
      // backgroundColor: Colors.green,
      // appBar: AppBar(
      //   title: Text('example 02'),
      // ),
      body: Builder(
        builder: (context) => StreamBuilder(
          stream: DevicesCollection().devicesSnapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> productsSnapshot) {
            if (!productsSnapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var kIsWeb = false;
            return CustomScrollView(
              slivers: <Widget>[
                // SliverToBoxAdapter(
                //   child: SizedBox(height: 4.0),
                // ),
                // SliverAppBar(toolbarHeight: 4.0,pinned: false,),
                SliverToBoxAdapter(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: StaggeredGridView.countBuilder(
                      crossAxisCount: 4,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      staggeredTileBuilder: (int index) => StaggeredTile.count(
                          kIsWeb ? 1 : 2,
                          kIsWeb
                              ? 1 *
                                  productsSnapshot.data.docs[index]
                                      ['deviceImage']['deviceImageHeight'] /
                                  productsSnapshot.data.docs[index]
                                      ['deviceImage']['deviceImageWidth']
                              : 2 *
                                  productsSnapshot.data.docs[index]
                                      ['deviceImage']['deviceImageHeight'] /
                                  productsSnapshot.data.docs[index]
                                      ['deviceImage']['deviceImageWidth']),
                      itemCount: productsSnapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (kIsWeb) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: FadeInImage(
                              placeholder:
                                  AssetImage('assets/images/kevinkobori.jpg'),
                              image: NetworkImage(
                                  productsSnapshot.data.docs[index]
                                      ['deviceImage']['deviceImageUrl']),
                              fit: BoxFit.cover,
                            ),
                          );
                        } else {
                          // return Padding(
                          //   padding: EdgeInsets.only(
                          //     top: index == 0 || index == 1 ? 8.0 : 0.0,
                          //   ),
                          //   child: 
                            return Stack(
                              children: [
                                Container(
                                  // width: 1000,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: FadeInImage(
                                      placeholder: AssetImage(
                                          'assets/images/kevinkobori.jpg'),
                                      image: NetworkImage(
                                          productsSnapshot.data.docs[index]
                                              ['deviceImage']['deviceImageUrl']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // Column(
                                //   mainAxisAlignment: MainAxisAlignment.end,
                                //   // crossAxisAlignment: CrossAxisAlignment.end,
                                //   children: [
                                //     Container(
                                //       height: 50,
                                //       color: Colors.red,
                                //     )
                                //   ],
                                // ),
                              ],
                            // ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
