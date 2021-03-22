import 'package:flutter/material.dart';
import 'package:remottely/models/current_user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:remottely/router/user_app_state.dart';
import 'package:remottely/router/animations/fade_animation_page.dart';
import 'package:remottely/router/routes.dart';
// import 'package:remottely/views/device/device_form_page.dart';
// import 'package:remottely/views/device/devices_manage_page_list.dart';
// import 'package:remottely/views/device/devices_maps_page.dart';
import 'package:remottely/views/shop_screen.dart';
// import 'package:remottely/views/device/devices_history_page_list.dart';
// import 'package:remottely/views/device/devices_page_list.dart';
import 'package:remottely/views/products/product_form_page.dart';
// import 'package:remottely/views/user/user_perfil_page.dart';
// import 'package:remottely/views/users_list_screen.dart';
// import 'package:remottely/views/user_detail_screen.dart';

import 'package:remottely/providers/google_sign_in.dart';
import 'package:provider/provider.dart';
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
        if (appState.selectedIndex == 0)
          FadeAnimationPage(
            child: Container(),
            key: ValueKey('HomePage'),
          )
        // ...[
        //   FadeAnimationPage(
        //     child: UsersListScreen(
        //       users: appState.users,
        //       onTapped: _handleUserTapped,
        //     ),
        //     key: ValueKey('UsersListPage'),
        //   ),
        //   if (appState.selectedUser != null)
        //     MaterialPage(
        //       key: ValueKey(appState.selectedUser),
        //       child: UserDetailsScreen(user: appState.selectedUser),
        //     ),
        // ]
        else if (appState.selectedIndex == 1)
          FadeAnimationPage(
            child: ShopScreen(),
            key: ValueKey('SearchPage'),
          ),
        if (appState.selectedIndex == 2)
          FadeAnimationPage(
            child: Container(child: ElevatedButton(
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.logout();
                },
                child: Text('Logout'),
              ),),
            key: ValueKey('shopPage'),
          ),
        if (appState.selectedIndex == 3)
          FadeAnimationPage(
            child: ProductFormPage(null),
            key: ValueKey('ordersPage'),
          ),
        if (appState.selectedIndex == 4)
          FadeAnimationPage(
            child: Container(),
            key: ValueKey('ProfilePage'),
          ),
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
