import 'package:flutter/material.dart';
import 'package:remottely/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:remottely/views/settings_screen.dart';
import 'package:remottely/widgets/router/user_app_state.dart';
import 'package:remottely/views/user_detail_screen.dart';
import 'package:remottely/widgets/router/fade_animation_page.dart';
import 'package:remottely/routes/routes.dart';
import 'package:remottely/views/users_list_screen.dart';

class InnerRouterDelegate extends RouterDelegate<UserRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<UserRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  UsersAppState get appState => _appState;
  UsersAppState _appState;
  set appState(UsersAppState value) {
    if (value == _appState) {
      return;
    }
    _appState = value;
    notifyListeners();
  }

  InnerRouterDelegate(this._appState);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (appState.selectedIndex == 0) ...[
          FadeAnimationPage(
            child: UsersListScreen(
              users: appState.users,
              onTapped: _handleUserTapped,
            ),
            key: ValueKey('UsersListPage'),
          ),
          if (appState.selectedUser != null)
            MaterialPage(
              key: ValueKey(appState.selectedUser),
              child: UserDetailsScreen(user: appState.selectedUser),
            ),
        ] else if (appState.selectedIndex == 1)
          FadeAnimationPage(
            child: SettingsScreen(),
            key: ValueKey('SettingsPage'),
          ),
        //     FadeAnimationPage(
        //       child: Error404Screen(),
        //       key: ValueKey('SettingsPage'),
        //     ),
        // else if (appState.selectedIndex == 1)
        //     FadeAnimationPage(
        //       child: SettingsScreen(),
        //       key: ValueKey('SettingsPage'),
        //     ),
        // else
        //     FadeAnimationPage(
        //       child: Error404Screen(),
        //       key: ValueKey('SettingsPage'),
        //     ),
      ],
      onPopPage: (route, result) {
        appState.selectedUser = null;
        notifyListeners();
        return route.didPop(result);
      },
    );
  }

  @override
  Future<void> setNewRoutePath(UserRoutePath path) async {
    // This is not required for inner router delegate because it does not
    // parse route
    assert(false);
  }

  void _handleUserTapped(User user) {
    appState.selectedUser = user;
    notifyListeners();
  }
}
