import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import './remottely_app_state.dart';
import './routes.dart';
import '../app_shell.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ui/views/authentication/sign_in/sign_in_view.dart';
import '../../ui/views/home/home_view.dart';
import '../models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import './remottely_router_delegate.dart';
import './remottely_route_information_parser.dart';
import 'package:provider/provider.dart';
// import './providers/drawer_provider.dart';

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
      } else if (appState.selectedIndex == 5) {
        return Error404Path();
      } else {
        return Error404Path();
      }
    }
  }

  Widget build(BuildContext context) => Scaffold(
        body:Consumer<User>(
        builder: (_, user, __) {
          if (user == null) {
            return const SignInView();
          } else {
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
            // const HomeView();
          }
        },
      ),
//         ChangeNotifierProvider(
//           create: (context) => GoogleSignInProvider(),
//           child: kIsWeb
//               ? FutureBuilder(
//                   future: Future.delayed(Duration(milliseconds: 1000))
//                       .then((_) => FirebaseAuth.instance.authStateChanges()),
//                   builder: (context, snapshot) {
//                     return StreamBuilder(
//                       stream: FirebaseAuth.instance.authStateChanges(),
//                       builder: (context, snapshot) {
//                         final provider =
//                             Provider.of<GoogleSignInProvider>(context);
// // appState.selectedIndex =null;
//                         if (provider.isSigningIn) {
//                           return buildLoading();
//                         } else if (!snapshot.hasData) {
//                           return SignUpWidget();
//                         } else {
            // if (appState.selectedIndex == null) {
            //   appState.selectedIndex = 0;
            // }
            // return
        //     Navigator(
        //   key: navigatorKey,
        //   pages: [
        //     MaterialPage(
        //       child: AppShell(appState: appState),
        //     ),
        //   ],
        //   onPopPage: (route, result) {
        //     if (!route.didPop(result)) {
        //       return true;
        //     }

        //     if (appState.selectedUser != null) {
        //       appState.selectedUser = null;
        //     }
        //     notifyListeners();
        //     return true;
        //   },
        // ),
//                         }
//                       },
//                     );
//                   },
//                 )
//               : StreamBuilder(
//                   stream: FirebaseAuth.instance.authStateChanges(),
//                   builder: (context, snapshot) {
//                     final provider = Provider.of<GoogleSignInProvider>(context);
// // appState.selectedIndex =null;
//                     if (provider.isSigningIn) {
//                       return buildLoading();
//                     } else if (!snapshot.hasData) {
//                       return SignUpWidget();
//                     } else {
//                       if (appState.selectedIndex == null) {
//                         appState.selectedIndex = 0;
//                       }
//                       return Navigator(
//                         key: navigatorKey,
//                         pages: [
//                           MaterialPage(
//                             child: AppShell(appState: appState),
//                           ),
//                         ],
//                         onPopPage: (route, result) {
//                           if (!route.didPop(result)) {
//                             return true;
//                           }

//                           if (appState.selectedUser != null) {
//                             appState.selectedUser = null;
//                           }
//                           notifyListeners();
//                           return true;
//                         },
//                       );
//                     }
//                   },
//                 ),
//         ),
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
    } else if (path is Error404Path) {
      appState.selectedIndex = 5;
    } else if (path is UsersDetailsPath) {
      appState.setSelectedUserById(path.id);
    } else {
      appState.selectedUser = null;
    }
  }
}
