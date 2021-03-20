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

//     class OrdersScreen extends StatefulWidget {
//   @override
//   OrdersScreenState createState() => OrdersScreenState();
// }

// class OrdersScreenState extends State<OrdersScreen> {

Widget buildLoading() => Stack(
      fit: StackFit.expand,
      children: [
        Center(child: CircularProgressIndicator()),
      ],
    );
