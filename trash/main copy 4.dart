import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(UrlHandler());
}

class UrlHandler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: UrlHandlerRouterDelegate(),
      routeInformationParser: UrlHandlerInformationParser(),
    );
  }
}

class NavigationState {
  final String value;
  NavigationState(this.value);
}

final GlobalKey<NavigatorState> _urlHandlerRouterDelegateNavigatorKey =
    GlobalKey<NavigatorState>();

class UrlHandlerRouterDelegate extends RouterDelegate<NavigationState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  String pathStringValue;
  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: [
        MaterialPage(
            child: MyHomePage(
                pathStringValue: pathStringValue, increase: increase)),
      ],
      onPopPage: (_, __) {
        // We don't handle routing logic here, so we just return false
        return false;
      },
    );
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey =>
      _urlHandlerRouterDelegateNavigatorKey;

  // Navigation state to app state
  @override
  Future<void> setNewRoutePath(NavigationState navigationState) {
    // If a value which is not a number has been entered,
    // navigationState.value is null so we just notifyListeners
    // without changing the app state to change the value of the url
    // to its previous value
    if (navigationState.value == null) {
      notifyListeners();
      return null;
    }

    // Get the new pathStringValue, which is navigationState.value//
    pathStringValue = navigationState.value; //(navigationState.value).floor();

    // If the navigationState.value was not a multiple of
    // the url is not equal to pathStringValue*, therefore the url isn't right
    // In that case, we notifyListener in order to get the valid NavigationState
    // from the new app state
    if (pathStringValue != navigationState.value) notifyListeners();
    return null;
  }

  // App state to Navigation state, triggered by notifyListeners()
  @override
  NavigationState get currentConfiguration => NavigationState(pathStringValue);

  bool increase() {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    pathStringValue = getRandomString(5);
    // Navigator.of(context).push(context, route);
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(
    //     builder: (context) => DevicesPageList(),
    //   ),
    // );
    notifyListeners();
    return true;
  }
}

class UrlHandlerInformationParser
    extends RouteInformationParser<NavigationState> {
  // Url to navigation state
  @override
  Future<NavigationState> parseRouteInformation(
      RouteInformation routeInformation) async {
    // final uri = Uri.parse(routeInformation.location);
    // var remaining = uri.pathSegments[1];
    return NavigationState(routeInformation.location
        .substring(1)); //int.tryParse(routeInformation.location.substring(1)));
  }

  // Navigation state to url
  @override
  RouteInformation restoreRouteInformation(NavigationState navigationState) {
    return RouteInformation(location: '/${navigationState.value}');
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.pathStringValue, this.increase}) : super(key: key);
  final String pathStringValue;
  final VoidCallback increase;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('pathStringValueer App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${widget.pathStringValue}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // var valor =
          // if(valor == true){
          widget.increase();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MyHomePage(pathStringValue: widget.pathStringValue, increase: widget.increase),
            ),
          );
          // }
        },
        tooltip: 'pathStringValueer',
        child: Icon(Icons.add),
      ),
    );
  }
}
