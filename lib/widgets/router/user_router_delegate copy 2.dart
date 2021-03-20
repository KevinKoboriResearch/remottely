import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:remottely/widgets/router/user_app_state.dart';
import 'package:remottely/views/control/app_shell.dart';
import 'package:remottely/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remottely/providers/google_sign_in.dart';
import 'package:remottely/widgets/sign_up_widget.dart';
import 'package:provider/provider.dart';

class UserRouterDelegate extends RouterDelegate<UserRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<UserRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  UsersAppState appState = UsersAppState();

  UserRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    appState.addListener(notifyListeners);
  }

  UserRoutePath get currentConfiguration {
    if (appState.selectedUser != null) {
      return UsersDetailsPath(appState.getSelectedUserById());
    } else {
      if (appState.selectedIndex == 0) {
        return UsersListPath();
      } else if (appState.selectedIndex == 1) {
        return SearchPath();
      } else if (appState.selectedIndex == 2) {
        return ShopPath();
      } else if (appState.selectedIndex == 3) {
        return OrdersPath();
      } else if (appState.selectedIndex == 4) {
        return ProfilePath();
      } else {
        return Error404Path();
      }
    }
  }

  Widget build(BuildContext context) => Scaffold(
        body: Navigator(
          key: navigatorKey,
          pages: [
            MaterialPage(
              child: AppShell(appState: appState),
            ),
          ],
          onPopPage: (route, result) {
            if (!route.didPop(result)) {
              return true;
            }

            if (appState.selectedUser != null) {
              appState.selectedUser = null;
            }
            notifyListeners();
            return true;
          },
        ),
      );
  Widget buildLoading() => Stack(
        fit: StackFit.expand,
        children: [
          Center(child: CircularProgressIndicator()),
        ],
      );

  @override
  Future<void> setNewRoutePath(UserRoutePath path) async {
    if (path is UsersListPath) {
      appState.selectedIndex = 0;
      appState.selectedUser = null;
    } else if (path is SearchPath) {
      appState.selectedIndex = 1;
    } else if (path is ShopPath) {
      appState.selectedIndex = 2;
    } else if (path is OrdersPath) {
      appState.selectedIndex = 3;
    } else if (path is ProfilePath) {
      appState.selectedIndex = 4;
    } else if (path is UsersDetailsPath) {
      appState.setSelectedUserById(path.id);
    }
    // else {
    //   appState.selectedUser = null;
    // }
  }
}
