import 'package:flutter/material.dart';
// import 'package:remottely/models/user_model.dart';

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

class CustomDrawer extends StatelessWidget {
    final _auth = FirebaseAuth.instance;
  // final PageController pageController;

  // CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 203, 236, 241), Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
        );

    return Drawer(
      child: Consumer<DrawerProvider>(
        builder: (ctx, drawerProvider2, _) {
          return Stack(
            children: <Widget>[
              _buildDrawerBack(),
              ListView(
                padding: EdgeInsets.only(left: 32.0, top: 16.0),
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 8.0),
                    padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                    height: 170.0,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 8.0,
                          left: 0.0,
                          child: Text(
                            "Remottely\nShop",
                            style: TextStyle(
                                fontSize: 34.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                       Positioned(
                        left: 0.0,
                        bottom: 0.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Olá, ${_auth.currentUser.uid == null ? "" : _auth.currentUser.displayName}",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              child: Text(
                                _auth.currentUser.uid == null
                                    ? "Entre ou cadastre-se >"
                                    : "Sair",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                if (_auth.currentUser.uid != null) {
                                  final provider =
                                      Provider.of<GoogleSignInProvider>(context,
                                          listen: false);
                                  provider.logout();
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                  InkWell(
                    onTap: () {
                      //  Navigator.of(context).pop();
                      toggleDrawer();
                      drawerProvider2.changeIndex(0);
                    },
                    child: DrawerTile(
                      icon: Icons.home,
                      text: "Início",
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      //  Navigator.of(context).pop();
                      toggleDrawer();
                      drawerProvider2.changeIndex(1);
                    },
                    child: DrawerTile(
                      icon: Icons.home,
                      text: "Início",
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      //  Navigator.of(context).pop();
                      toggleDrawer();
                      drawerProvider2.changeIndex(2);
                    },
                    child: DrawerTile(
                      icon: Icons.home,
                      text: "Início",
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      //  Navigator.of(context).pop();
                      toggleDrawer();
                      drawerProvider2.changeIndex(3);
                    },
                    child: DrawerTile(
                      icon: Icons.home,
                      text: "form",
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      //  Navigator.of(context).pop();
                      toggleDrawer();
                      drawerProvider2.changeIndex(4);
                    },
                    child: DrawerTile(
                      icon: Icons.home,
                      text: "perfil",
                    ),
                  ),
                  // DrawerTile(Icons.home, "Início", pageController, 0),
                  // DrawerTile(Icons.list, "Produtos", pageController, 1),
                  // DrawerTile(Icons.location_on, "Lojas", pageController, 2),
                  // DrawerTile(Icons.playlist_add_check, "Meus Pedidos", pageController, 3),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
