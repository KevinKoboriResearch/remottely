import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ui/views/authentication/sign_in/sign_in_view.dart';
import '../ui/views/home/home_view.dart';
import 'models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import './router/remottely_router_delegate.dart';
import './router/remottely_route_information_parser.dart';
import 'package:provider/provider.dart';
// import './providers/drawer_provider.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

// final BuildContext context;
// UserRouteInformationParser({this.context});
// getDrawerProvider() {
// return drawerProvider;
// }
// getDrawerProvider().pageIndex = 1;

class _MyAppState extends State<MyApp> {
  UserRouterDelegate _routerDelegate = UserRouterDelegate();
  UserRouteInformationParser _routeInformationParser =
      UserRouteInformationParser();
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'Material App',
    //   theme: ThemeData(
    //     visualDensity: VisualDensity.adaptivePlatformDensity,
    //   ),
    //   home: Consumer<User>(
    //     builder: (_, user, __) {
    //       if (user == null) {
    //         return const SignInView();
    //       } else {
    //         return const HomeView();
    //       }
    //     },
    //   ),
    // );
    return MaterialApp.router(
      // navigatorKey: navigatorKey,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Remottely',
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}
