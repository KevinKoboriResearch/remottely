import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remottely/providers/products.dart';
import 'package:remottely/widgets/products_grid.dart';
import 'package:remottely/widgets/badge.dart';
import 'package:remottely/widgets/app_drawer.dart';
import 'package:remottely/providers/cart.dart';
import 'package:remottely/utils/app_routes.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
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

  _getImageValues(Future<ui.Image> futureImage) async {
    await futureImage.then((value) {
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

  @override
  Widget build(BuildContext context) {
    // var fatherIndex;
    // ui.Image image;
    // var h = image.width;
    // var w = image.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('example 02'),
      ),
      body: Builder(
        builder: (context) => StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('products')
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> productsSnapshot) {
            if (!productsSnapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  itemCount: productsSnapshot.data.docs.length, //8,
                  itemBuilder: (BuildContext context, int index) {
                    // fatherIndex = index;
                    // return FutureBuilder<ui.Image>(
                    //   future:
                    //       _getImage(productsSnapshot.data.docs[index]['image']),
                    //   builder: (BuildContext context,
                    //       AsyncSnapshot<ui.Image> productImageSnapshot) {
                    // if (!productImageSnapshot.hasData) {
                    //   return Text('Loading...');
                    // } else {
                    // image = productImageSnapshot.data;
                    // return Column(
                    //   children: [
                    return FadeInImage(
                      placeholder: AssetImage('assets/images/kevinkobori.jpg'),
                      image: NetworkImage(
                          productsSnapshot.data.docs[index]['image']),
                      fit: BoxFit.cover,
                    );
                    //   ],
                    // );
                    // }
                    //   },
                    // );
                  },
                  staggeredTileBuilder: (int index) {
                    // _getImage(productsSnapshot.data.docs[index]['image'])
                    //     .then((value) {
                    StaggeredTile.count(2, 2); // * value.height / value.width);
                    // });
                  },
                  // index.isEven
                  //     ? 2 * image.height != null
                  //         ? image.height
                  //         : 1 / image.width != null
                  //             ? image.width
                  //             : 1
                  //     : 2 * image.height != null
                  //         ? image.height
                  //         : 1 / image.width != null
                  //             ? image.width
                  //             : 1),
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
