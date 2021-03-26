import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:shop/app/utils/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shop/app/providers/google_sign_in.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final auth = FirebaseAuth.instance.currentUser;
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
                'kevin kobori',//'${auth.displayName}',
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
                // Navigator.of(context).pushReplacementNamed(
                  // AppRoutes.AUTH_HOME,
                // );
              },
            ),
            Divider(height: 4, color: Colors.grey[100]),
            ListTile(
              tileColor: Colors.white,
              leading: Icon(Icons.payment),
              title: Text('Pedidos'),
              onTap: () {
                // Navigator.of(context).pushReplacementNamed(
                  // AppRoutes.ORDERS,
                // );
              },
            ),
            Divider(height: 4, color: Colors.grey[100]),
            ListTile(
              tileColor: Colors.white,
              leading: Icon(Icons.edit),
              title: Text('Gerenciar Produtos'),
              onTap: () {
                // Navigator.of(context).pushReplacementNamed(
                  // AppRoutes.PRODUCTS,
                // );
              },
            ),
            Divider(height: 4, color: Colors.grey[100]),
            ListTile(
              tileColor: Colors.white,
              leading: Icon(Icons.exit_to_app),
              title: Text('Sair'),
              onTap: () {
                // final provider =
                //       Provider.of<GoogleSignInProvider>(context, listen: false);
                //   provider.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
