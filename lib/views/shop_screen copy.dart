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
// final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
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
      extendBody: false,
      body: Builder(
        builder: (context) => StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('products')
              // .where(
              //   "deviceUsers",
              //   arrayContains:
              //       // "userEmail": auth.currentUser.email.toLowerCase(),
              //       auth.currentUser.uid,
              //   // "userName": auth.currentUser.displayName.toLowerCase(),
              // )
              // .orderBy("deviceProperty")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            //     return LayoutCustomScrollView(0, DevicesPageList(), 'C H A V E S',
            //         snapshot, DevicesPageItem(snapshot));
            //   },
            // );
            return Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 2.0),
                width: 1000,
                child: CustomScrollView(
                  slivers: [
                    // SliverAppBar(
                    //   pinned: false,
                    //   // toolbarHeight: 40,
                    //   elevation: 0,
                    //   backgroundColor: Colors.white.withOpacity(1),
                    //   leading: InkWell(
                    //     onTap: () => Scaffold.of(context).openDrawer(),
                    //     child: Icon(Icons.menu, color: Colors.black),
                    //   ),
                    //   centerTitle: true,
                    //   title: Container(
                    //     width: 60,
                    //     child: FadeInImage(
                    //       placeholder:
                    //           AssetImage('assets/logo/tapanapanterahs.png'),
                    //       image: AssetImage('assets/logo/tapanapanterahs.png'),
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    //   actions: <Widget>[
                    //     PopupMenuButton(
                    //       onSelected: (FilterOptions selectedValue) {
                    //         setState(
                    //           () {
                    //             if (selectedValue == FilterOptions.Favorite) {
                    //               _showFavoriteOnly = true;
                    //             } else {
                    //               _showFavoriteOnly = false;
                    //             }
                    //           },
                    //         );
                    //       },
                    //       icon: Icon(
                    //         Icons.more_vert,
                    //         color: Colors.black,
                    //       ),
                    //       itemBuilder: (_) => [
                    //         PopupMenuItem(
                    //           child: Text('Somente Favoritos'),
                    //           value: FilterOptions.Favorite,
                    //         ),
                    //         PopupMenuItem(
                    //           child: Text('Todos'),
                    //           value: FilterOptions.All,
                    //         ),
                    //       ],
                    //     ),
                    //     // Consumer<Cart>(
                    //     //   child: IconButton(
                    //     //     icon: Icon(
                    //     //       MyFlutterApp.bag,
                    //     //       color: Colors.black,
                    //     //     ),
                    //     //     onPressed: () {
                    //     //       // Navigator.of(context)
                    //     //       //     .pushNamed(AppRoutes.CART);
                    //     //     },
                    //     //   ),
                    //     //   builder: (_, cart, child) => Badge(
                    //     //     value: cart.itemsCount.toString(),
                    //     //     child: child,
                    //     //   ),
                    //     // )
                    //   ],
                    // ),
                    // SliverAppBar(
                    //   pinned: true,
                    //   // toolbarHeight: 40,
                    //   elevation: 0,
                    //   leadingWidth: 0,
                    //   title: Container(
                    //     decoration: BoxDecoration(
                    //       border: Border.all(
                    //         color: Colors.grey.withOpacity(0.5),
                    //         width: 1.0,
                    //       ),
                    //       borderRadius: BorderRadius.circular(4.0),
                    //     ),
                    //     margin: EdgeInsets.all(12),
                    //     child: Row(
                    //       children: <Widget>[
                    //         Padding(
                    //           padding: EdgeInsets.only(left: 8),
                    //           child: Icon(
                    //             Icons.search,
                    //             color: Colors.grey,
                    //             size: 20,
                    //           ),
                    //         ),
                    //         new Expanded(
                    //           child: TextField(
                    //             keyboardType: TextInputType.text,
                    //             decoration: InputDecoration(
                    //               border: InputBorder.none,
                    //               hintText: "Search by Name",
                    //               hintStyle: TextStyle(color: Colors.grey),
                    //               contentPadding: EdgeInsets.symmetric(
                    //                   vertical: 8, horizontal: 8),
                    //               isDense: true,
                    //             ),
                    //             style: TextStyle(
                    //               fontSize: 14.0,
                    //               color: Colors.black,
                    //             ),
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    //   backgroundColor: Colors.white.withOpacity(1),
                    //   leading: Container(),
                    //   centerTitle: false,
                    //   // title: Container(
                    //   //   width: 60,
                    //   //   child: FadeInImage(
                    //   //     placeholder: AssetImage(
                    //   //         'assets/logo/tapanapanterahs.png'),
                    //   //     image: AssetImage(
                    //   //         'assets/logo/tapanapanterahs.png'),
                    //   //     fit: BoxFit.cover,
                    //   //   ),
                    //   // ),
                    // ),
                    // // SliverToBoxAdapter(
                    // //   child: SizedBox(height: 2.0),
                    // // ),
                    // SliverToBoxAdapter(
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       border: Border.all(
                    //         color: Colors.grey.withOpacity(0.5),
                    //         width: 1.0,
                    //       ),
                    //       borderRadius: BorderRadius.circular(4.0),
                    //     ),
                    //     margin: EdgeInsets.all(12),
                    //     child: Row(
                    //       children: <Widget>[
                    //         Padding(
                    //           padding: EdgeInsets.only(left: 8),
                    //           child: Icon(
                    //             Icons.search,
                    //             color: Colors.grey,
                    //             size: 20,
                    //           ),
                    //         ),
                    //         new Expanded(
                    //           child: TextField(
                    //             keyboardType: TextInputType.text,
                    //             decoration: InputDecoration(
                    //               border: InputBorder.none,
                    //               hintText: "Search by Name",
                    //               hintStyle: TextStyle(color: Colors.grey),
                    //               contentPadding: EdgeInsets.symmetric(
                    //                   vertical: 8, horizontal: 8),
                    //               isDense: true,
                    //             ),
                    //             style: TextStyle(
                    //               fontSize: 14.0,
                    //               color: Colors.black,
                    //             ),
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
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
                                  child: Text('Loja'),
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
                      toolbarHeight: 26,
                      // expandedHeight: 186,
                      leading: Container(),
                      // leadingWidth: 0,
                      // titleSpacing: 100,
                      flexibleSpace: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        margin: EdgeInsets.all(12),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Icon(
                                Icons.search,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ),
                            new Expanded(
                              child: Theme(
                                data: Theme.of(context)
                                    .copyWith(splashColor: Colors.transparent),
                                child: TextField(
                                  autofocus: false,
                                  style: TextStyle(
                                      fontSize: 22.0, color: Color(0xFFbdc6cf)),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Username',
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 8.0, top: 8.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                  ),
                                ),
                              ),
//                               TextField(
//                                 cursorColor: Colors.green,
// background
//                                 keyboardType: TextInputType.text,
//                                 decoration: InputDecoration(
//                                   hoverColor: Colors.red,
//                                   focusColor: Colors.red,
//                                   fillColor: Colors.red,
//                                   border: InputBorder.none,
//                                   hintText: "Search by Name",
//                                   hintStyle: TextStyle(color: Colors.grey),
//                                   contentPadding: EdgeInsets.symmetric(
//                                       vertical: 8, horizontal: 8),
//                                   isDense: true,
//                                 ),
//                                 style: TextStyle(
//                                   fontSize: 14.0,
//                                   color: Colors.black,
//                                 ),
//                               ),
                            )
                          ],
                        ),
                      ),
                      // Container(height: 1000, width:1000, color: Colors.red),
                      // FlexibleSpaceBar(
                      //   // background: Stack(
                      //   //   children: <Widget>[
                      //   //     Center(
                      //   //       child: FadeInImage(
                      //   //         height: 220,
                      //   //         width: (kIsWeb
                      //   //             ? 507
                      //   //             : MediaQuery.maybeOf(context)
                      //   //                 .size
                      //   //                 .width), //* 0.95,
                      //   //         placeholder: AssetImage('assets/logo/logo.png'),
                      //   //         image: snapshot.data['deviceImageUrl'] != '' ||
                      //   //                 snapshot.data['deviceImageUrl'] != null
                      //   //             ? NetworkImage(
                      //   //                 snapshot.data['deviceImageUrl'])
                      //   //             : AssetImage('assets/logo/logo.png'),
                      //   //         fit: BoxFit.cover,
                      //   //       ),
                      //   //     ),
                      //   //     // Center(
                      //   //     //   child: Padding(
                      //   //     //     padding: const EdgeInsets.only(top: 48.0),
                      //   //     //     child: Container(
                      //   //     //       width: (kIsWeb
                      //   //     //           ? 507
                      //   //     //           : MediaQuery.maybeOf(context).size.width),
                      //   //     //       color: AppColors.astratosDarkGreyColor
                      //   //     //           .withOpacity(0.3),
                      //   //     //     ),
                      //   //     //   ),
                      //   //     // ),
                      //   //   ],
                      //   // ),
                      //   background: Container(
                      //     decoration: BoxDecoration(
                      //       border: Border.all(
                      //         color: Colors.grey.withOpacity(0.5),
                      //         width: 1.0,
                      //       ),
                      //       borderRadius: BorderRadius.circular(4.0),
                      //     ),
                      //     margin: EdgeInsets.all(12),
                      //     child: Row(
                      //       children: <Widget>[
                      //         Padding(
                      //           padding: EdgeInsets.only(left: 8),
                      //           child: Icon(
                      //             Icons.search,
                      //             color: Colors.grey,
                      //             size: 20,
                      //           ),
                      //         ),
                      //         new Expanded(
                      //           child: TextField(
                      //             keyboardType: TextInputType.text,
                      //             decoration: InputDecoration(
                      //               border: InputBorder.none,
                      //               hintText: "Search by Name",
                      //               hintStyle: TextStyle(color: Colors.grey),
                      //               contentPadding: EdgeInsets.symmetric(
                      //                   vertical: 8, horizontal: 8),
                      //               isDense: true,
                      //             ),
                      //             style: TextStyle(
                      //               fontSize: 14.0,
                      //               color: Colors.black,
                      //             ),
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ),
                    ProductsGrid(snapshot),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}