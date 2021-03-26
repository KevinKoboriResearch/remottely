import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './widgets/product_grid_item.dart';
// import '../../../ui/widgets/app_drawer.dart';
import '../../../../app/utils/my_flutter_app_icons.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../../../app/providers/products.dart';
import '../../../../ui/widgets/badge.dart';
import '../../../../app/providers/cart.dart';
import '../../../../app/utils/app_routes.dart';
import '../../../../app/services/creation_aware_list_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

enum FilterOptions {
  Favorite,
  All,
}

class StorePage extends StatefulWidget {
  const StorePage({
    Key key,
  }) : super(key: key);
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage>
    with SingleTickerProviderStateMixin {
  // bool _showFavoriteOnly = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    Provider.of<Products>(context, listen: false).listenToProducts();
  }

  void _refreshProducts(BuildContext context) {
    return Provider.of<Products>(context, listen: false).listenToProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context);
    final products = productsProvider.items;

    return Scaffold(
      extendBody: true,
      key: _scaffoldKey,
      // endDrawer: AppDrawer(),
      body: Builder(
        builder: (context) {
          return SafeArea(
            child: products == null
                ? Stack(
                    fit: StackFit.expand,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
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
                            InkWell(
                              child: Icon(
                                Icons.menu,
                                color: Colors.black,
                              ),
                              onTap: () {
                                _scaffoldKey.currentState.openEndDrawer();
                                // _appShellScaffoldKey.currentState.openEndDrawer();
                              },
                            ),
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
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ],
                  )
                : CustomScrollView(
                    slivers: [
                      // padding: EdgeInsets.only(top: kIsWeb ? kPadding : 0),
                      kIsWeb
                          ? SliverToBoxAdapter(child: SizedBox(height: 20))
                          : SliverToBoxAdapter(),
                      // SliverToBoxAdapter(child: SizedBox(height: 60)),
                      SliverAppBar(
                        floating: true,
                        snap: true,
                        backgroundColor: Colors.white,
                        elevation: 0.0,
                        toolbarHeight: 48,
                        expandedHeight: 46,
                        leading: Container(),
                        actions: [Container()],
                        leadingWidth: 0,
                        flexibleSpace: FlexibleSpaceBar(
                          centerTitle: false,
                          titlePadding:
                              EdgeInsets.fromLTRB(14.0, 0.0, 0.0, 0.0),
                          title: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 106,
                                child: Text(
                                    products != []
                                        ? products[0].companyTitle
                                        : '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,

                                    //     ? products[0].companyTitle
                                    //     : '',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  // setState(() {
                                  //   _showFavoriteOnly = !_showFavoriteOnly;
                                  // });
                                  Navigator.of(context).pushNamed(
                                    AppRoutes.FAVORITES,
                                  );
                                  // Navigator.of(context).pop();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 8.0, 12.0, 0.0),
                                  child: Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.rotationY(math.pi),
                                    child: 
                                    // kIsWeb
                                    //     ? 
                                        Icon(
                                            Icons.bookmark,
                                            size: 24,
                                          )
                                        // : 
                                        // NeumorphicIcon(
                                        //     Icons.bookmark_border,
                                        //     size: 24,
                                        //     style: NeumorphicStyle(
                                        //       color: Colors.black,
                                        //       depth: 1,
                                        //       intensity: 1,
                                        //       lightSource: LightSource.lerp(
                                        //           LightSource.bottom,
                                        //           LightSource.top,
                                        //           1),
                                        //     ),
                                        //   ),
                                  ),
                                ),
                              ),
                              Consumer<Cart>(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(AppRoutes.CART);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        8.0, 8.0, 16.0, 0.0),
                                    child: Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.rotationY(math.pi),
                                      child: Icon(
                                        MyFlutterApp.bag,
                                        // size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                builder: (_, cart, child) => Badge(
                                  value: cart.itemsCount.toString(),
                                  child: child,
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
                        toolbarHeight: 56,
                        titleSpacing: 0,
                        leading: Container(),
                        leadingWidth: 0,
                        actions: [
                          InkWell(
                            onTap: () {
                              _scaffoldKey.currentState.openEndDrawer();
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  8.0, 0.0, 16.0, 0.0),
                              child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(math.pi),
                                child: Icon(
                                  MyFlutterApp.sort,
                                  color: Colors.black,
                                  // size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                        title: Padding(
                          padding: EdgeInsets.fromLTRB(12.0, 12.0, 6.0, 12.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            // child: Expanded(
                            child: Container(
                              height: 34,
                              child: TextField(
                                // expands: false,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                  prefixIcon: Icon(Icons.search, size: 24),
                                  // prefixStyle: TextStyle(),
                                  border: InputBorder.none,
                                  // labelText: "Search by Name",
                                  hintText: "Pesquisar",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(0, 7, 0, 0),
                                  isDense: true,
                                ),
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            // ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(products.length,
                                  // categories.length,
                                  (index) {
                                return Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      index == 0.0 ? 14.0 : 4.0,
                                      0.0,
                                      index == products.length - 1 ? 14.0 : 0.0,
                                      0.0),
                                  child: OutlinedButton(
                                    child: new Text(
                                      products[index].title,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: null,
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    // clipBehavior: Clip.values(CupertinoIcons.textformat_123),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 8.0)),
                      products.length == 0
                          ? SliverToBoxAdapter(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height - 200,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            )
                          : SliverPadding(
                              padding: EdgeInsets.fromLTRB(
                                8.0,
                                0.0,
                                8.0,
                                8.0,
                              ),
                              sliver: SliverGrid(
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 203,
                                  childAspectRatio: 0.78,
                                ),
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    return CreationAwareListItem(
                                      itemCreated: () {
                                        if (index % 6 == 0)
                                          productsProvider
                                              .requestMoreCompanyProductsData();
                                      },
                                      child: ChangeNotifierProvider.value(
                                        value: products[index],
                                        child: ProductGridItem('store'),
                                      ),
                                    );
                                  },
                                  childCount: products.length,
                                ),
                              ),
                            ),
                    ],
                  ),
            // },
          );
        },
      ),
    );
    // drawer: AppDrawer(),
  }
}
