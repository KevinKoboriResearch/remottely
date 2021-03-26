import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import './router/remottely_app_state.dart';
import './router/inner_router_delegate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../ui/widgets/app_drawer.dart';
// import 'package:/providers/drawer_provider.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:/views/control/app_drawer.dart';
import './router/remottely_route_information_parser.dart';

GlobalKey<ScaffoldState> appShellScaffoldKey = new GlobalKey<ScaffoldState>();
toggleDrawer() async {
  if (appShellScaffoldKey.currentState.isDrawerOpen) {
    appShellScaffoldKey.currentState.openEndDrawer();
  } else {
    appShellScaffoldKey.currentState.openDrawer();
  }
}

class AppShell extends StatefulWidget {
  final RemottelyAppState appState;

  AppShell({
    @required this.appState,
  });

  @override
  _AppShellState createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  // GlobalKey<ScaffoldState> appShellScaffoldKey =
  //     new GlobalKey<ScaffoldState>();
  final auth = FirebaseAuth.instance;
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

  // toggleDrawer() async {
  //   if (appShellScaffoldKey.currentState.isDrawerOpen) {
  //     appShellScaffoldKey.currentState.openEndDrawer();
  //   } else {
  //     appShellScaffoldKey.currentState.openDrawer();
  //   }
  // }
  UserRouteInformationParser _routeInformationParser =
      UserRouteInformationParser();
  // var drawerProvider = Provider.of<DrawerProvider>(context, listen: false);
  // drawerProvider = _routeInformationParser.getRouteAppStateIndex();

  @override
  Widget build(BuildContext context) {
    _backButtonDispatcher.takePriority();
    var appState = widget.appState;
    return
        // Consumer<DrawerProvider>(
        //   builder: (ctx, drawerProvider, _) {
        //     if (drawerProvider.pageIndex != null) {
        //       appState.selectedIndex = drawerProvider.pageIndex;
        //       // drawerProvider.pageIndex = null;
        //     } else {
        //       var route = _routeInformationParser.getRouteAppStateIndex();
        //       if (route != null) {
        //         appState.selectedIndex = route;
        //       } else {
        //         // appState.selectedIndex = 0;
        //       }
        //       // appState.selectedIndex = drawerProvider.pageIndex;
        //     }
        //     return
        Center(
      child: Container(
        width: 1000,
        height: MediaQuery.of(context).size.height,
        child: Scaffold(
          key: appShellScaffoldKey,
          extendBody: true,
          endDrawer: AppDrawer(),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            // toolbarHeight: 0,
            // elevation: 0,
            leading: Container(),
            title: Container(),
            actions: [InkWell(
                              child: Icon(
                                Icons.menu,
                                color: Colors.black,
                              ),
                              onTap: () {
                                appShellScaffoldKey.currentState.openEndDrawer();
                                // appShellScaffoldKey.currentState.openEndDrawer();
                              },
                            ),],
          ),
          // drawer: CustomDrawer(),
          body: Router(
            routerDelegate: _routerDelegate,
            backButtonDispatcher: _backButtonDispatcher,
          ),
            bottomNavigationBar: BottomNavigationBar(
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.verified_user, color: Colors.black),
                    label: 'users',
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search, color: Colors.black),
                    label: 'search',
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu, color: Colors.black),
                    label: 'shop',
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Icon(Icons.car_rental, color: Colors.black),
                    label: 'orders',
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Icon(Icons.supervised_user_circle,
                        color: Colors.black),
                    label: 'profile',
                    backgroundColor: Colors.white),
              ],
              currentIndex: appState.selectedIndex,
              onTap: (newIndex) {
                appState.selectedIndex = newIndex;
              },
            ),
        ),
      ),
    );
    //   },
    // );
  }
}
