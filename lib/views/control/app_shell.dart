import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:remottely/router/remottely_app_state.dart';
import 'package:remottely/utils/remottely_icons.dart';
import 'package:remottely/router/inner_router_delegate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:remottely/screens/login_screen.dart';
import 'package:remottely/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:remottely/views/users_list_screen.dart';
import 'package:remottely/views/user_detail_screen.dart';

import 'package:remottely/providers/google_sign_in.dart';
import 'package:provider/provider.dart';

class AppShell extends StatefulWidget {
  final RemottelyAppState appState;
  AppShell({
    @required this.appState,
  });

  @override
  _AppShellState createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final _auth = FirebaseAuth.instance;
  InnerRouterDelegate _routerDelegate;
  ChildBackButtonDispatcher _backButtonDispatcher;

  void initState() {
    super.initState();
    _routerDelegate = InnerRouterDelegate(widget.appState);
  }

  @override
  void didUpdateWidget(covariant AppShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    _routerDelegate.appState = widget.appState;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Defer back button dispatching to the child router
    // if(widget.appState.selectedIndex == 0) {

    _backButtonDispatcher = Router.of(context)
        .backButtonDispatcher
        .createChildBackButtonDispatcher();
    // }
  }

  @override
  Widget build(BuildContext context) {
    // Claim priority, If there are parallel sub router, you will need
    // to pick which one should take priority;
    _backButtonDispatcher.takePriority();
// widget.appState.selectedIndex = 4;
    Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 203, 236, 241), Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
        );
    return Scaffold(
      drawer: Drawer(
        child: Stack(
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
                          "REMOTTELY\nSHOP",
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
                DrawerTile(
                    icon: Icons.home,
                    text: "Início",
                    onCountChanged: (int val) {
                      setState(() => widget.appState.selectedIndex = val);
                    },
                    page: 0),
                DrawerTile(
                    icon: Icons.list,
                    text: "Produtos",
                    onCountChanged: (int val) {
                      setState(() => widget.appState.selectedIndex = val);
                    },
                    page: 1),
                DrawerTile(
                    icon: Icons.location_on,
                    text: "Lojas",
                    onCountChanged: (int val) {
                      setState(() => widget.appState.selectedIndex = val);
                    },
                    page: 2),
                DrawerTile(
                    icon: Icons.playlist_add_check,
                    text: "Meus Pedidos",
                    onCountChanged: (int val) {
                      setState(() => widget.appState.selectedIndex = val);
                    },
                    page: 3),
              ],
            )
          ],
        ),
      ),
      extendBody: false,
      appBar: AppBar(),
      body: Router(
        routerDelegate: _routerDelegate,
        backButtonDispatcher: _backButtonDispatcher,
      ),
      // widget.appState.selectedIndex
      // bottomNavigationBar: SizedBox(
      //   // height: 50,
      //   child: BottomNavigationBar(
      //     backgroundColor: Colors.transparent,
      //     iconSize: 30.0,
      //     type: BottomNavigationBarType.fixed,
      //     elevation: 0,
      //     showSelectedLabels: false,
      //     showUnselectedLabels: false,
      //     items: [
      //       BottomNavigationBarItem(
      //         icon: widget.appState.selectedIndex == 0
      //             ? Icon(Icons.home, color: Colors.black)
      //             : Icon(Icons.home_outlined, color: Colors.black),
      //         label: 'users',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: widget.appState.selectedIndex == 1
      //             ? Icon(Icons.search_off, color: Colors.black)
      //             : Icon(Icons.search, color: Colors.black),
      //         label: 'tapanapanterahs',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(RemottelyIcons.shopping_bag, color: Colors.black),
      //         label: 'shop',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(MyFlutterApp.history, color: Colors.black),
      //         label: 'orders',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: auth.currentUser.photoURL != null ? CircleAvatar(
      //           maxRadius: 16,
      //           backgroundColor: widget.appState.selectedIndex == 4
      //               ? Colors.black
      //               : Colors.transparent,
      //           child: CircleAvatar(
      //             maxRadius: 14,
      //             backgroundImage: NetworkImage(auth.currentUser.photoURL),
      //           ),
      //         ):Icon(Icons.menu),
      //         label: 'profile',
      //       ),
      //     ],
      //     currentIndex: widget.appState.selectedIndex,
      //     onTap: (newIndex) {
      //       widget.appState.selectedIndex = newIndex;
      //     },
      //   ),
      // ),
    );
  }
}
