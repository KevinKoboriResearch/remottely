import 'package:flutter/material.dart';
import 'package:remottely/routes/routes.dart';

class UserRouteInformationParser extends RouteInformationParser<UserRoutePath> {
  @override
  Future<UserRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);

    if (uri.pathSegments.isEmpty || uri.pathSegments.first == 'users') {
      return UsersListPath();
    } else if (uri.pathSegments.first == 'settings') {
      return UsersSettingsPath();
    } else {
      if (uri.pathSegments.length >= 2) {
        if (uri.pathSegments[0] == 'user') {
          return UsersDetailsPath(int.tryParse(uri.pathSegments[1]));
        }
      }
      return Error404Path();
    }
  }

  @override
  RouteInformation restoreRouteInformation(UserRoutePath configuration) {
    if (configuration is UsersListPath) {
      return RouteInformation(location: '/users');
    }
    if (configuration is UsersSettingsPath) {
      return RouteInformation(location: '/settings');
    }
    if (configuration is UsersDetailsPath) {
      return RouteInformation(location: '/user/${configuration.id}');
    }
    return null;
  }
}
