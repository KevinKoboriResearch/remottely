import 'package:flutter/material.dart';
import 'package:remottely/models/user_model.dart';
import 'package:flutter/foundation.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:remottely/providers/google_sign_in.dart';
import 'package:provider/provider.dart';

class UsersListScreen extends StatelessWidget {
  final List<User> users;
  final ValueChanged<User> onTapped;

  UsersListScreen({
    @required this.users,
    @required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [ElevatedButton(
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.logout();
                },
                child: Text('Logout'),
              ),],),
      body: ListView(
        children: [
          for (var user in users)
            ListTile(
              title: Text(user.username),
              subtitle: Text(user.realName),
              onTap: () => onTapped(user),
            )
        ],
      ),
    );
  }
}
