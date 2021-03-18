import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:remottely/widgets/router/user_app_state.dart';
import 'package:remottely/views/control/app_shell.dart';
import 'package:remottely/routes/routes.dart';

class UserRouterDelegate extends RouterDelegate<UserRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<UserRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  UsersAppState appState = UsersAppState();

  UserRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    appState.addListener(notifyListeners);
  }

  UserRoutePath get currentConfiguration {
    if (appState.selectedIndex == 1) {
      return UsersSettingsPath();
    } else if (appState.selectedIndex == 0) {
      if (appState.selectedUser == null) {
        return UsersListPath();
      } else {
        return UsersDetailsPath(appState.getSelectedUserById());
      }
    } else {
      return Error404Path();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          child: AppShell(appState: appState),
        ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        if (appState.selectedUser != null) {
          appState.selectedUser = null;
        }
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(UserRoutePath path) async {
    if (path is UsersListPath) {
      appState.selectedIndex = 0;
      appState.selectedUser = null;
    } else if (path is UsersSettingsPath) {
      appState.selectedIndex = 1;
    } else if (path is UsersDetailsPath) {
      appState.setSelectedUserById(path.id);
    }
  }
}
