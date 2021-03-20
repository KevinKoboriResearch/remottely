import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:remottely/providers/auth.dart';
import 'package:remottely/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:remottely/utils/constants.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/functions/get_initials.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:remottely/exceptions/auth_exception.dart';
// import 'package:remottely/functions/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:remottely/utils/constants.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
// import 'package:remottely/providers/auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final Auth auth = Provider.of(context, listen: false);
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: <Widget>[
            AppBar(
              // elevation: 0,
              // backgroundColor: Colors.white.withOpacity(0.9),
              // centerTitle: true,
              title: Text(
                '',
                style: TextStyle(color: Colors.black),
              ),
              automaticallyImplyLeading: false,
            ),
            Divider(height: 4, color: Colors.grey[100]),
            ListTile(
              tileColor: Colors.white,
              leading: Icon(Icons.shop),
              title: Text('Loja'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(
                  AppRoutes.AUTH_HOME,
                );
              },
            ),
            Divider(height: 4, color: Colors.grey[100]),
            ListTile(
              tileColor: Colors.white,
              leading: Icon(Icons.payment),
              title: Text('Pedidos'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(
                  AppRoutes.ORDERS,
                );
              },
            ),
            Divider(height: 4, color: Colors.grey[100]),
            ListTile(
              tileColor: Colors.white,
              leading: Icon(Icons.edit),
              title: Text('Gerenciar Produtos'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(
                  AppRoutes.PRODUCTS,
                );
              },
            ),
            Divider(height: 4, color: Colors.grey[100]),
            ListTile(
              tileColor: Colors.white,
              leading: Icon(Icons.exit_to_app),
              title: Text('Sair'),
              onTap: () {
                // Provider.of<Auth>(context, listen: false).logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
