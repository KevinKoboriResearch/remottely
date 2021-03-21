import 'package:flutter/material.dart';
import 'package:remottely/views/control/marketing_page.dart';
import 'package:remottely/views/control/block_page.dart';
import 'package:remottely/views/device/devices_page_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:data_connection_checker/data_connection_checker.dart';

class AuthAppPage extends StatefulWidget {
  @override
  _AuthOrBlockPageState createState() => _AuthOrBlockPageState();
}

class _AuthOrBlockPageState extends State<AuthAppPage> {
  var page;

  @override
  void initState() {
    super.initState();
  }

  start() async {
    await Future.delayed(Duration(milliseconds: 1000))
        .then((value) => FirebaseAuth.instance.authStateChanges());
  }

  @override
  Widget build(BuildContext context) {
    return
        // kIsWeb
        //     ? FutureBuilder(
        //         future: start(),
        //         builder: (ctx, userSnapshot) {
        //           return StreamBuilder(
        //             stream: FirebaseAuth.instance.authStateChanges(),
        //             builder: (ctx, userSnapshot) {
        //               if (userSnapshot.hasData) {
        //                 return DevicesPageList(); //BlockPage(); //DevicesPageList
        //               } else {
        //                 return MarketingPage();
        //               }
        //             },
        //           );
        //         },
        //       )
        //     :
        StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, userSnapshot) {
        if (userSnapshot.hasData) {
          return DevicesPageList(); //BlockPage(); //DevicesPageList
        } else {
          return MarketingPage();
        }
      },
    );
  }
}
