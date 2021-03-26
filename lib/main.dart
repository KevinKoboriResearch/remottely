import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'app/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './app/utils/custom_route.dart';

import './app/utils/app_routes.dart';

// import './ui/views/auth_home_screen.dart';
// import './ui/views/product_detail_screen.dart';
// import './ui/views/cart_screen.dart';
// import './ui/views/orders_screen.dart';
// import './ui/views/products_screen.dart';

import './app/providers/products.dart';
import './app/providers/cart.dart';
// import './app/providers/orders.dart';
import './app/providers/auth.dart';
// import 'package:flutter/services.dart';
// import 'package:firebase_core/firebase_core.dart';
// import './app/providers/google_sign_in.dart';
// import './ui/views/store/products/product_form_page.dart';
// import './app/libraries/rxdart/lib/rxdart.dart';
// import './ui/views/store/products/favorites_products_page.dart';

void main() => runApp(
      /// Inject the [FirebaseAuthService]
      /// and provide a stream of [User]
      ///
      /// This needs to be above [MaterialApp]
      /// At the top of the widget tree, to
      /// accomodate for navigations in the app
      MultiProvider(
        providers: [
          Provider(
            create: (_) => FirebaseAuthService(),
          ),
          ChangeNotifierProvider(
            create: (_) => Auth(),
          ),
          // ChangeNotifierProvider.va(
          //   create: (_) => new GoogleSignInProvider(),
          // ),
          ChangeNotifierProxyProvider<Auth, Products>(
            create: (_) => new Products(),
            update: (ctx, auth, previousProducts) => new Products(
              auth.token,
              auth.userId,
              previousProducts.busy,
              previousProducts.items,
            ),
          ),
          // ChangeNotifierProvider(
          //   create: (_) => new Cart(),
          // ),
          // ChangeNotifierProxyProvider<Auth, Orders>(
          //   create: (_) => new Orders(),
          //   update: (ctx, auth, previousOrders) => new Orders(
          //     auth.token,
          //     auth.userId,
          //     previousOrders.items,
          //   ),
          // ),
          StreamProvider(
            create: (context) =>
                context.read<FirebaseAuthService>().onAuthStateChanged,
          ),
        ],
        child: MyApp(),
      ),
    );
