import 'package:flutter/material.dart';
import 'package:remottely/models/current_user_model.dart';
import 'package:flutter/foundation.dart';

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
