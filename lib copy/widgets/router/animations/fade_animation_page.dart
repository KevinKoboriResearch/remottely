import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FadeAnimationPage extends Page {
  final Widget child;

  FadeAnimationPage({Key key, this.child}) : super(key: key);

  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, animation2) => child,
      // {
      //   var curveTween = CurveTween(curve: Curves.elasticOut);
      //   return FadeTransition(
      //     opacity: animation.drive(curveTween),
      //     child: child,
      //   );
      // },
      transitionDuration: Duration(seconds: 0),
    );
  }
}
