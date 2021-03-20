import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:remottely/widgets/router/user_app_state.dart';
import 'package:remottely/widgets/router/inner_router_delegate.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppShell extends StatefulWidget {
  final UsersAppState appState;

  AppShell({
    @required this.appState,
  });

  @override
  _AppShellState createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final auth = FirebaseAuth.instance;
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
    // if(widget.appState.selectedIndex == 0) {

    _backButtonDispatcher = Router.of(context)
        .backButtonDispatcher
        .createChildBackButtonDispatcher();
    // }
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
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            // icon: Icon(Icons.verified_user, color: Colors.black),
            icon: appState.selectedIndex == 0
                ? Icon(Icons.search, color: Colors.black)
                : Icon(Icons.menu, color: Colors.black),
            label: 'users',
          ),
          // backgroundColor: Colors.yellow[700]),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.black),
            label: 'search',
          ),
          // backgroundColor: Colors.blue),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu, color: Colors.black),
            label: 'shop',
          ),
          // backgroundColor: Colors.grey),
          BottomNavigationBarItem(
            icon: Icon(Icons.car_rental, color: Colors.black),
            label: 'orders',
          ),
          // backgroundColor: Colors.green),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              maxRadius: 16,
              backgroundColor: appState.selectedIndex == 4 ? Colors.black : Colors.transparent,
              child: CircleAvatar(
                maxRadius: 14,
                backgroundImage: NetworkImage(auth.currentUser.photoURL),
              ),
            ),
            label: 'profile',
          ),
          // backgroundColor: Colors.red),
        ],
        currentIndex: appState.selectedIndex,
        onTap: (newIndex) {
          appState.selectedIndex = newIndex;
        },
      ),
      // bottomNavigationBar : new BottomNavigationBar(
      //   currentIndex: appState.selectedIndex,
      //   onTap: (int index) {
      //     setState(() {
      //       appState.selectedIndex = index;
      //     }
      //     );
      //     // _navigateToScreens(index);
      //   },
      //   type: BottomNavigationBarType.fixed,
      //   items: [
      //     new BottomNavigationBarItem(
      //         backgroundColor: Colors.white,
      //         icon: appState.selectedIndex == 0 ? new Image.asset('assets/images/kevinkobori.jpg'):new Image.asset('assets/images/kevinkobori.jpg'),
      //         title: new Text("Route1", style: new TextStyle(
      //             color: const Color(0xFF06244e), fontSize: 10.0))),
      //     new BottomNavigationBarItem(
      //         icon: appState.selectedIndex ==1?new Image.asset('assets/imageskevinkobori.jpg'):new Image.asset('assets/images/kevinkobori.jpg'),
      //         title: new Text("Route2", style: new TextStyle(
      //             color: const Color(0xFF06244e), fontSize: 14.0))),
      //     new BottomNavigationBarItem(
      //         icon: appState.selectedIndex ==2?new Image.asset('assets/images/kevinkobori.jpg'):new Image.asset('assets/images/kevinkobori.jpg'),
      //         title: new Text("Route3", style: new TextStyle(
      //             color: const Color(0xFF06244e), fontSize: 14.0),)),
      //     new BottomNavigationBarItem(
      //         icon: appState.selectedIndex ==3?new Image.asset('assets/images/kevinkobori.jpg'):new Image.asset('assets/images/kevinkobori.jpg'),
      //         title: new Text("Route4", style: new TextStyle(
      //             color: const Color(0xFF06244e), fontSize: 14.0),))
      //   ])
    );
  }
}
