import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/router/remottely_router_delegate.dart';
import 'package:remottely/router/remottely_route_information_parser.dart';
import 'package:provider/provider.dart';
import 'package:remottely/providers/drawer_provider.dart';

// import './providers/products.dart';
// import './providers/cart.dart';
// import './providers/orders.dart';
// import './providers/auth.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

// final BuildContext context;
// UserRouteInformationParser({this.context});
// getDrawerProvider() {
// return drawerProvider;
// }
// getDrawerProvider().pageIndex = 1;

class _MyAppState extends State<MyApp> {
  UserRouterDelegate _routerDelegate = UserRouterDelegate();
  UserRouteInformationParser _routeInformationParser =
      UserRouteInformationParser();
  @override
  Widget build(BuildContext context) {
    // var drawerProvider = Provider.of<DrawerProvider>(context, listen: false);
    // drawerProvider = _routeInformationParser.getRouteAppStateIndex();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    final Future<FirebaseApp> _init = Firebase.initializeApp();
    return FutureBuilder(
      future: _init,
      builder: (ctx, appSnapshot) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => new DrawerProvider(),
            ),
            // ChangeNotifierProvider(
            //   create: (_) => new Auth(),
            // ),
            // ChangeNotifierProxyProvider<Auth, Products>(
            //   create: (_) => new Products(),
            //   update: (ctx, auth, previousProducts) => new Products(
            //     auth.token,
            //     auth.userId,
            //     previousProducts.items,
            //   ),
            // ),
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
          ],
          child: MaterialApp.router(
            // navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Remottely',
            theme: ThemeData(
              // pageTransitionsTheme: PageTransitionsTheme(builders: {
              //   TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              // }),
              // inputDecorationTheme: InputDecorationTheme(
              //   border: InputBorder.none,
              // ),
              hintColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              textTheme: TextTheme(
                headline1: TextStyle(color: AppColors.astronautOrangeDarkColor),
                headline2: TextStyle(color: AppColors.astronautOrangeDarkColor),
                headline3: TextStyle(color: AppColors.astronautOrangeDarkColor),
                headline4: TextStyle(color: AppColors.astronautOrangeDarkColor),
                headline5: TextStyle(color: AppColors.astronautOrangeDarkColor),
                headline6: TextStyle(color: AppColors.astronautOrangeDarkColor),
                subtitle1: TextStyle(color: AppColors.astronautOrangeDarkColor),
                subtitle2: TextStyle(color: AppColors.astronautOrangeDarkColor),
                bodyText1: TextStyle(
                  fontSize: 16,
                ),
                bodyText2: TextStyle(),
              ).apply(
                bodyColor: AppColors.textColor,
                displayColor: AppColors.astronautOrangeDarkColor,
              ),
              fontFamily: 'Lato',
              accentColor: AppColors.accentColor,
              indicatorColor: AppColors.indicatorColor,
              primaryColor: AppColors.astratosDarkGreyColor,
              canvasColor: AppColors.astronautCanvasColor,
              buttonColor: AppColors.astronautCanvasColor,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
            routerDelegate: _routerDelegate,
            routeInformationParser: _routeInformationParser,
          ),
        );
      },
    );
  }
}
