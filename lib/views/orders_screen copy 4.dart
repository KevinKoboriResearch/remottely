import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var h = 900;
    var w = 800;
    return Scaffold(
      body: Builder(
        builder: (context) => StreamBuilder(
          stream: FirebaseFirestore.instance.collection('products').snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> productsSnapshot) {
            if (!productsSnapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Padding(
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
                    return StaggeredTile.count(2, 2); // * value.height / value.width);
                    // });
                  },
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
