import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:remottely/router/remottely_app_state.dart';
import 'package:remottely/utils/remottely_icons.dart';
import 'package:remottely/router/inner_router_delegate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:remottely/router/remottely_app_state.dart';
import 'package:remottely/router/inner_router_delegate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:remottely/providers/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:remottely/utils/constants.dart';
import 'package:remottely/providers/drawer_provider.dart';
import 'package:remottely/tiles/drawer_tile.dart';
import 'dart:math' as math;
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:remottely/providers/drawer_provider.dart';

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String text;
  // Function(int) onCountChanged;
  // final int page;

  // DrawerTile(this.icon, this.text, this.onCountChanged, this.page);
  DrawerTile({
    @required this.icon,
    @required this.text,
    // @required this.onCountChanged,
    // @required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Consumer<DrawerProvider>(
        builder: (ctx, drawerProvider, _) => Container(
          height: 60.0,
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                size: 32.0,
                // color: onCountChanged(page) == page ?
                //   Theme.of(context).primaryColor : Colors.grey[700],
              ),
              SizedBox(
                width: 32.0,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16.0,
                  // color: onCountChanged(page) == page ?
                  // Theme.of(context).primaryColor : Colors.grey[700],
                ),
              )
            ],
          ),
        ),

        // InkWell(
        //   onTap: () {
        //     drawerProvider.changeIndex(0);
        //      Navigator.of(context).pop();
        //   },
        //   child: DrawerTile(
        //     icon: Icons.home,
        //     text: "Início",
        //   ),
        // ),
      ),
      // InkWell(
      //   onTap: (){
      //     // onCountChanged(page);
      //     // Navigator.of(context).pop();
      //   },
      //   child: Container(
      //     height: 60.0,
      //     child: Row(
      //       children: <Widget>[
      //         Icon(
      //           icon,
      //           size: 32.0,
      //           // color: onCountChanged(page) == page ?
      //           //   Theme.of(context).primaryColor : Colors.grey[700],
      //         ),
      //         SizedBox(width: 32.0,),
      //         Text(
      //           text,
      //           style: TextStyle(
      //             fontSize: 16.0,
      //             // color: onCountChanged(page) == page ?
      //             // Theme.of(context).primaryColor : Colors.grey[700],
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
