import 'package:flutter/material.dart';
import '../models/current_user_model.dart';
import 'package:flutter/foundation.dart';
import './remottely_app_state.dart';
import './animations/fade_animation_page.dart';
import './routes.dart';
// import 'ui/providers/google_sign_in.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../app_shell.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ui/views/store/products/store_products_page.dart';
import '../constants/strings.dart';
import '../services/firebase_auth_service.dart';

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
          FadeAnimationPage(
            key: ValueKey('HomePage'),
            child: StorePage(),
            // Container(child: Center(child: Text('teste'))), //Container(),
          )
        //   ...[
        //   FadeAnimationPage(
        //     child: UsersListScreen(
        //       users: appState.users,
        //       onTapped: _handleUserTapped,
        //     ),
        //     key: ValueKey('UsersListPage'),
        //   ),
        //   if (appState.selectedUser != null)
        //     FadeAnimationPage(
        //       key: ValueKey(appState.selectedUser),
        //       child: Container(child:Center(child:Text('teste')))//UserDetailsScreen(user: appState.selectedUser),
        //     ),
        // ] else
        else if (appState.selectedIndex == 1)
          FadeAnimationPage(
            key: ValueKey('SearchPage'),
            child:
                Container(child: Center(child: Text('search'))), //ShopScreen(),
          ),
        if (appState.selectedIndex == 2)
          FadeAnimationPage(
            child: Scaffold(
              appBar: AppBar(
                leading: InkWell(
                  child: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                  onTap: () {
                    appShellScaffoldKey.currentState.openEndDrawer();
                    // _appShellScaffoldKey.currentState.openEndDrawer();
                  },
                ),
              ),
              body: ElevatedButton(
                onPressed: () {
                  context.read<FirebaseAuthService>().signOut();
                  // final provider =
                  //     Provider.of<GoogleSignInProvider>(context, listen: false);
                  // provider.logout();
                },
                child: Text('signOut'),
              ),
            ),
            key: ValueKey('shopPage'),
          ),
        if (appState.selectedIndex == 3)
          FadeAnimationPage(
              key: ValueKey('ordersPage'),
              child: Container(
                  child: Center(
                      child: Text(
                          'orders'))) //ProductFormPage('tapanapanterahs', 'tabacos', null),
              ),
        if (appState.selectedIndex == 4)
          FadeAnimationPage(
              key: ValueKey('ProfilePage'),
              child: Container(
                  child: Center(child: Text('profile'))) //Container(),
              ),
        if (appState.selectedIndex == 5)
          FadeAnimationPage(
            child: Scaffold(
              appBar: AppBar(
                leading: ElevatedButton(
                  onPressed: () {
                    // toggleDrawer();
                  },
                  child: Text('ERROR 404'),
                ),
              ),
              body: ElevatedButton(
                onPressed: () {
                  // final provider =
                  //     Provider.of<GoogleSignInProvider>(context, listen: false);
                  // provider.logout();
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
