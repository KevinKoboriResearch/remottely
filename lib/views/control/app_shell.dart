import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:remottely/widgets/router/user_app_state.dart';
import 'package:remottely/widgets/router/inner_router_delegate.dart';

class AppShell extends StatefulWidget {
  final UsersAppState appState;

  AppShell({
    @required this.appState,
  });

  @override
  _AppShellState createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  InnerRouterDelegate _routerDelegate;
  ChildBackButtonDispatcher _backButtonDispatcher;

  void initState() {
    super.initState();
    _routerDelegate = InnerRouterDelegate(widget.appState);
  }

  @override
  void didUpdateWidget(covariant AppShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    _routerDelegate.appState = widget.appState;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Defer back button dispatching to the child router
    _backButtonDispatcher = Router.of(context)
        .backButtonDispatcher
        .createChildBackButtonDispatcher();
  }

  @override
  Widget build(BuildContext context) {
    var appState = widget.appState;

    // Claim priority, If there are parallel sub router, you will need
    // to pick which one should take priority;
    _backButtonDispatcher.takePriority();

    return Scaffold(
      body: Router(
        routerDelegate: _routerDelegate,
        backButtonDispatcher: _backButtonDispatcher,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.verified_user, color: Colors.white),
              label: 'users',
              backgroundColor: Colors.yellow[700]),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.white),
              label: 'search',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu, color: Colors.white),
              label: 'shop',
              backgroundColor: Colors.grey),
          BottomNavigationBarItem(
              icon: Icon(Icons.car_rental, color: Colors.white),
              label: 'orders',
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle, color: Colors.white),
              label: 'profile',
              backgroundColor: Colors.red),
        ],
        currentIndex: appState.selectedIndex,
        onTap: (newIndex) {
          appState.selectedIndex = newIndex;
        },
      ),
    );
  }
}
