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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:remottely/providers/drawer_provider.dart';

import 'package:remottely/views/control/app_drawer.dart';

// import 'package:remottely/screens/login_screen.dart';
import 'package:remottely/tiles/drawer_tile.dart';
import 'package:remottely/views/control/app_shell.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:remottely/router/remottely_app_state.dart';
import 'package:remottely/utils/remottely_icons.dart';
import 'package:remottely/router/inner_router_delegate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:remottely/router/remottely_app_state.dart';
import 'package:remottely/router/inner_router_delegate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:remottely/providers/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:remottely/utils/constants.dart';
import 'package:remottely/providers/drawer_provider.dart';
import 'package:remottely/tiles/drawer_tile.dart';
import 'dart:math' as math;
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:remottely/providers/drawer_provider.dart';

enum FilterOptions {
  Favorite,
  All,
}

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen>
    with SingleTickerProviderStateMixin {
  bool _showFavoriteOnly = false;
  bool _isLoading = true;
  final auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    // Provider.of<Products>(context, listen: false).loadProducts().then((_) {
    //   setState(() {
    //     _isLoading = false;
    //   });
    // });
  }

  // toggleDrawer() async {
  //   if (appShellScaffoldKey.currentState.isDrawerOpen) {
  //     appShellScaffoldKey.currentState.openEndDrawer();
  //   } else {
  //     appShellScaffoldKey.currentState.openDrawer();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final DrawerProvider drawerProvider = Provider.of(context);
    // drawerProvider.pageIndex;
    return Scaffold(
      // backgroundColor: Colors.grey[100],
      // drawer: CustomDrawer(),
      extendBody: true,
      body: Builder(
        builder: (context) => StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('companies')
              .doc('bwBiNTo7yOIUYehamSmD')
              .collection('products')
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshotProducts) {
            if (snapshotProducts.data.docs.length == 0) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Colors.blue;
                          return Colors
                              .white; //Color(0xffDDDDDD); // Use the component's default.
                        },
                      ),
                    ),
                    onPressed: () async {
                      // final provider =
                      //     Provider.of<GoogleSignInProvider>(context, listen: false);
                      // await provider.login(context);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 64),
                        Text(
                          'R E M O T T E L Y',
                          style: TextStyle(
                            // depth: 1,
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'anurati',
                          ),
                        ),
                        Spacer(flex: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Criar ', //'Sign In With ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.grey[600]),
                            ),
                            Text(
                              'L',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.blue),
                            ),
                            Text(
                              'o',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.red),
                            ),
                            Text(
                              'j',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.yellow[800]),
                            ),
                            Text(
                              'a',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.green),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Clique na tela',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ],
              );
            } else if (!snapshotProducts.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(
              child: Container(
                width: 1000,
                child: CustomScrollView(
                  slivers: [
                    // SliverAppBar(
                    //   backgroundColor: Colors.transparent,
                    //   toolbarHeight: 0,
                    //   elevation: 0,
                    //   leading: Container(),
                    //   title: Container(),
                    //   actions: [],
                    // ),
                    SliverAppBar(
                      floating: true,
                      snap: true,
                      backgroundColor: Colors.white,
                      elevation: 0.0,
                      toolbarHeight: 40,
                      expandedHeight: 40,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: false,
                        titlePadding: EdgeInsets.fromLTRB(14.0, 0.0, 12.0, 0.0),
                        title: Row(
                          children: [
                            Text(
                                snapshotProducts.hasData
                                    ? snapshotProducts.data.docs[0]
                                        ['companyTitle']
                                    : '',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800])),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                toggleDrawer();
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0.0, 6.0, 0.0, 0.0),
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
                          ],
                        ),
                      ),
                    ),
                    SliverAppBar(
                      pinned: true,
                      backgroundColor: Colors.white,
                      elevation: 0,
                      toolbarHeight: 66,
                      // expandedHeight: 186,
                      // leadingWidth: 0,
                      // titleSpacing: 100,
                      titleSpacing: 0,
                      title: Padding(
                        padding: EdgeInsets.all(12),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Expanded(
                            child: TextField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                fillColor: Colors.grey[200],
                                filled: true,
                                prefixIcon: Icon(Icons.search, size: 24),
                                // prefixStyle: TextStyle(),
                                border: InputBorder.none,
                                // labelText: "Search by Name",
                                hintText: "Search by Name",
                                hintStyle: TextStyle(color: Colors.grey),
                                contentPadding:
                                    EdgeInsets.fromLTRB(0, 15, 0, 0),
                                isDense: true,
                              ),
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // ProductsGrid(snapshotProducts),
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(
                        8.0,
                        0.0,
                        8.0,
                        8.0,
                      ),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 210,
                          childAspectRatio: 0.70,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return ProductGridItem(snapshotProducts.data.docs[
                                index]); //Container(height: 100, color: Colors.red);
                            // return ChangeNotifierProvider.value(
                            //   value: products[index],
                            //   child: ProductGridItem(),
                            // );
                          },
                          childCount: snapshotProducts.data.docs
                              .length, //products.length, // widget.snapshotProducts.data.docs.length,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      // drawer: AppDrawer(),
    );
  }
}
