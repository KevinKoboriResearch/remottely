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
import 'package:remottely/views/control/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/router/remottely_router_delegate.dart';
import 'package:remottely/router/remottely_route_information_parser.dart';
import 'package:provider/provider.dart';
import 'package:remottely/providers/drawer_provider.dart';

GlobalKey<ScaffoldState> _appShellScaffoldKey = new GlobalKey<ScaffoldState>();
toggleDrawer() async {
  if (_appShellScaffoldKey.currentState.isDrawerOpen) {
    _appShellScaffoldKey.currentState.openEndDrawer();
  } else {
    _appShellScaffoldKey.currentState.openDrawer();
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
  // GlobalKey<ScaffoldState> _appShellScaffoldKey =
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
  //   if (_appShellScaffoldKey.currentState.isDrawerOpen) {
  //     _appShellScaffoldKey.currentState.openEndDrawer();
  //   } else {
  //     _appShellScaffoldKey.currentState.openDrawer();
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
    return Consumer<DrawerProvider>(
      builder: (ctx, drawerProvider, _) {
        if (drawerProvider.pageIndex != null) {
          appState.selectedIndex = drawerProvider.pageIndex;
          drawerProvider.pageIndex = null;
        } else {
          var route = _routeInformationParser.getRouteAppStateIndex();
          if (route != null) {
            appState.selectedIndex = route;
          } else {
            // appState.selectedIndex = 0;
          }
          // appState.selectedIndex = drawerProvider.pageIndex;
        }
        return Center(
          child: Container(
            width: 1000,
            height: MediaQuery.of(context).size.height,
            child: Scaffold(
              key: _appShellScaffoldKey,
              extendBody: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                toolbarHeight: 0,
                elevation: 0,
                leading: Container(),
                title: Container(),
                actions: [],
              ),
              drawer: CustomDrawer(),
              body: Router(
                routerDelegate: _routerDelegate,
                backButtonDispatcher: _backButtonDispatcher,
              ),
            ),
          ),
        );
      },
    );
  }
}
