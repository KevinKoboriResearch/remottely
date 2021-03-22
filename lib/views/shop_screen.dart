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

enum FilterOptions {
  Favorite,
  All,
}

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[100],
      extendBody: false,
      body: Builder(
        builder: (context) => StreamBuilder(
          stream: FirebaseFirestore.instance
              //  .collection('companies')
              // //  .doc('RPJkEiX3yxV2ZWH19LNHDZyCdZ33')
              //   .where(
              //     "companyManagers",
              //     arrayContains: auth.currentUser.uid,
              //   )
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
                        Container(
                          width: 104,
                          child: Neumorphic(
                            style: NeumorphicStyle(
                              depth: 3,
                              color: Colors.white, //Color(0xffDDDDDD),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 2.0),
                              child: Row(
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
                            ),
                          ),
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
            //     return LayoutCustomScrollView(0, DevicesPageList(), 'C H A V E S',
            //         snapshotProducts, DevicesPageItem(snapshotProducts));
            //   },
            // );
            return Center(
              child: Container(
                width: 1000,
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      backgroundColor: Colors.white,
                      elevation: 0,
                      toolbarHeight: 0,
                      expandedHeight: 60,
                      leading: Container(),
                      flexibleSpace: FlexibleSpaceBar(
                        background: Column(
                          children: [
                            Spacer(flex: 3),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Text(
                                      snapshotProducts.hasData
                                          ? snapshotProducts.data.docs[0]
                                              ['companyTitle']
                                          : '', //'tapanapanterahs',
                                      style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[800])),
                                ),
                              ],
                            ),
                            Spacer(),
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
                      padding: EdgeInsets.all(8.0),
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
