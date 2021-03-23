import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:remottely/router/remottely_app_state.dart';
import 'package:remottely/views/control/app_shell.dart';
import 'package:remottely/router/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:remottely/providers/google_sign_in.dart';
import 'package:remottely/widgets/sign_up_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:remottely/widgets/global/build_loading.dart';

class UserRouterDelegate extends RouterDelegate<UserRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<UserRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  RemottelyAppState appState = RemottelyAppState();

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
        body: ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
          child: kIsWeb
              ? FutureBuilder(
                  future: Future.delayed(Duration(milliseconds: 1000))
                      .then((_) => FirebaseAuth.instance.authStateChanges()),
                  builder: (context, snapshot) {
                    return StreamBuilder(
                      stream: FirebaseAuth.instance.authStateChanges(),
                      builder: (context, snapshot) {
                        final provider =
                            Provider.of<GoogleSignInProvider>(context);
// appState.selectedIndex =null;
                        if (provider.isSigningIn) {
                          return buildLoading();
                        } else if (!snapshot.hasData) {
                          return SignUpWidget();
                        } else {
                          if (appState.selectedIndex == null) {
                            appState.selectedIndex = 0;
                          }
                          return Navigator(
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
                          );
                        }
                      },
                    );
                  },
                )
              : StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    final provider = Provider.of<GoogleSignInProvider>(context);
// appState.selectedIndex =null;
                    if (provider.isSigningIn) {
                      return buildLoading();
                    } else if (!snapshot.hasData) {
                      return SignUpWidget();
                    } else {
                      if (appState.selectedIndex == null) {
                        appState.selectedIndex = 0;
                      }
                      return Navigator(
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
                      );
                    }
                  },
                ),
        ),
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
