import 'package:flutter/material.dart';
import 'package:remottely/models/current_user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:remottely/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:remottely/providers/products.dart';
// import 'package:remottely/widgets/product/products_grid.dart';
// import 'package:remottely/widgets/badge.dart';
// import 'package:remottely/widgets/app_drawer.dart';
// import 'package:remottely/providers/cart.dart';
// import 'package:remottely/utils/app_routes.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:remottely/views/device/device_detail_page.dart';
// import 'package:remottely/views/device/devices_manage_page_list.dart';
// import 'package:remottely/views/device/device_form_page.dart';
// final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:remottely/widgets/product/product_grid_item.dart';
// import 'package:remottely/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:shop/providers/auth.dart';
// import 'package:remottely/providers/product.dart';
// import 'package:remottely/providers/cart.dart';
// import 'package:remottely/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:remottely/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:remottely/providers/drawer_provider.dart';
import 'package:provider/provider.dart';
import 'package:remottely/providers/drawer_provider.dart';

class UsersListScreen extends StatelessWidget {
  final List<User> users;
  final ValueChanged<User> onTapped;

  UsersListScreen({
    @required this.users,
    @required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    // final DrawerProvider drawerProvider = Provider.of(context);
    return Scaffold(
      body: ListView(
        children: [
          Consumer<DrawerProvider>(
            builder: (ctx, drawerProvider, _) => InkWell(
              onTap: () {
                drawerProvider.changeIndex(1);
              },
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
                child: NeumorphicIcon(
                  MyFlutterApp.sort,
                  size: 32,
                  style: NeumorphicStyle(
                    depth: 1,
                    color: AppColors.textColor,
                  ),
                ),
              ),
            ),
          ),
          for (var user in users)
            ListTile(
              title: Text(user.username),
              subtitle: Text(user.realName),
              onTap: () => onTapped(user),
            )
        ],
      ),
    );
  }
}
