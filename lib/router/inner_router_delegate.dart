import 'package:flutter/material.dart';
import 'package:remottely/models/current_user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:remottely/router/remottely_app_state.dart';
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
import 'package:remottely/views/users_list_screen.dart';
import 'package:remottely/views/user_detail_screen.dart';

import 'package:remottely/providers/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:remottely/providers/products.dart';
// import 'package:remottely/widgets/product/products_grid.dart';
// import 'package:remottely/widgets/badge.dart';
// import 'package:remottely/widgets/app_drawer.dart';
// import 'package:remottely/providers/cart.dart';
// import 'package:remottely/utils/app_routes.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:remottely/views/device/device_detail_page.dart';
// import 'package:remottely/views/device/devices_manage_page_list.dart';
// import 'package:remottely/views/device/device_form_page.dart';
// final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:remottely/widgets/product/product_grid_item.dart';
// import 'package:remottely/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:shop/providers/auth.dart';
// import 'package:remottely/providers/product.dart';
// import 'package:remottely/providers/cart.dart';
// import 'package:remottely/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:remottely/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:provider/provider.dart';
import 'package:remottely/providers/drawer_provider.dart';

import 'package:remottely/views/control/app_drawer.dart';

// import 'package:remottely/screens/login_screen.dart';
import 'package:remottely/tiles/drawer_tile.dart';
import 'package:remottely/views/control/app_shell.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:remottely/router/remottely_app_state.dart';
import 'package:remottely/utils/remottely_icons.dart';
import 'package:remottely/router/inner_router_delegate.dart';

import 'package:flutter/foundation.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:remottely/router/remottely_app_state.dart';
import 'package:remottely/router/inner_router_delegate.dart';

import 'package:remottely/providers/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:remottely/utils/constants.dart';
import 'package:remottely/providers/drawer_provider.dart';
import 'package:remottely/tiles/drawer_tile.dart';
import 'dart:math' as math;
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:remottely/providers/drawer_provider.dart';

class InnerRouterDelegate extends RouterDelegate<UserRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<UserRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  RemottelyAppState get appState => _appState;
  RemottelyAppState _appState;
  set appState(RemottelyAppState value) {
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
          // FadeAnimationPage(
          //   child: Container(),
          //   key: ValueKey('HomePage'),
          // )
          ...[
          FadeAnimationPage(
            child: UsersListScreen(
              users: appState.users,
              onTapped: _handleUserTapped,
            ),
            key: ValueKey('UsersListPage'),
          ),
          if (appState.selectedUser != null)
            FadeAnimationPage(
              key: ValueKey(appState.selectedUser),
              child: UserDetailsScreen(user: appState.selectedUser),
            ),
        ] else if (appState.selectedIndex == 1)
          FadeAnimationPage(
            child: ShopScreen(),
            key: ValueKey('SearchPage'),
          ),
        if (appState.selectedIndex == 2)
          FadeAnimationPage(
            child: Scaffold(
              appBar: AppBar(
                leading: ElevatedButton(
                  onPressed: () {
                    toggleDrawer();
                  },
                  child: Text('menu'),
                ),
              ),
              body: ElevatedButton(
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.logout();
                },
                child: Text('Logout'),
              ),
            ),
            key: ValueKey('shopPage'),
          ),
        if (appState.selectedIndex == 3)
          FadeAnimationPage(
            child: ProductFormPage('tapanapanterahs', 'tabacos', null),
            key: ValueKey('ordersPage'),
          ),
        if (appState.selectedIndex == 4)
          FadeAnimationPage(
            child: Container(),
            key: ValueKey('ProfilePage'),
          ),
        if (appState.selectedIndex == 5)
          FadeAnimationPage(
            child: Scaffold(
              appBar: AppBar(
                leading: ElevatedButton(
                  onPressed: () {
                    toggleDrawer();
                  },
                  child: Text('ERROR 404'),
                ),
              ),
              body: ElevatedButton(
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.logout();
                },
                child: Text('Página não encontrada'),
              ),
            ),
            key: ValueKey('error404Page'),
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
