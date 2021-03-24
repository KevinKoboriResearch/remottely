import 'package:flutter/material.dart';
import 'package:remottely/router/routes.dart';
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

class UserRouteInformationParser extends RouteInformationParser<UserRoutePath> {
  // final BuildContext context;
  // UserRouteInformationParser({this.context});

  // getDrawerProvider() {
  //   var drawerProvider = Provider.of<DrawerProvider>(context, listen: false);
  //   return drawerProvider;
  // }
  int _appIndex;


  getRouteAppStateIndex() {
    return _appIndex;
  }

  @override
  Future<UserRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);

    if (uri.pathSegments.isEmpty || uri.pathSegments.first == 'users') {
      _appIndex = 0;
      return UsersListPath();
    } else if (uri.pathSegments.first == 'search') {
      _appIndex = 1;
      return SearchPath();
    } else if (uri.pathSegments.first == 'shop') {
      _appIndex = 2;
      return ShopPath();
    } else if (uri.pathSegments.first == 'orders') {
      _appIndex = 3;
      return OrdersPath();
    } else if (uri.pathSegments.first == 'profile') {
      _appIndex = 4;
      return ProfilePath();
    } else {
      if (uri.pathSegments.length >= 2) {
        if (uri.pathSegments[0] == 'user') {
          return UsersDetailsPath(int.tryParse(uri.pathSegments[1]));
        }
      }
      _appIndex = 5;
      return Error404Path();
    }
  }

  @override
  RouteInformation restoreRouteInformation(UserRoutePath configuration) {
    if (configuration is UsersListPath) {
      return RouteInformation(location: '/users');
    }
    if (configuration is UsersDetailsPath) {
      return RouteInformation(location: '/user/${configuration.id}');
    }
    if (configuration is SearchPath) {
      return RouteInformation(location: '/search');
    }
    if (configuration is ShopPath) {
      return RouteInformation(location: '/shop');
    }
    if (configuration is OrdersPath) {
      return RouteInformation(location: '/orders');
    }
    if (configuration is ProfilePath) {
      return RouteInformation(location: '/profile');
    }
    if (configuration is Error404Path) {
      return RouteInformation(location: '/error404');
    }
    return RouteInformation(location: '/error404');
    // return null;
  }
}
