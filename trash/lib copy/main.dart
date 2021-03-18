import 'package:flutter/material.dart';
import 'package:remottely/page/home_page.dart';
import 'package:firebase_core/firebase_core.dart';

import './utils/app_routes.dart';

import './views/auth_home_screen.dart';
import './views/cart.dart';
import './widget/logged_in_widget.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'REMOTTELY',
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: HomePage(),
        // routes: {
        //   AppRoutes.AUTH_HOME: (ctx) => AuthOrHomeScreen(),
        //   AppRoutes.CART: (ctx) => Cart(),
        // }
      );
}
