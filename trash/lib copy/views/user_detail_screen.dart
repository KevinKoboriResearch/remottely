import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:remottely/models/user_model.dart';

class UserDetailsScreen extends StatelessWidget {
  final User user;

  UserDetailsScreen({
    @required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Back'),
            ),
            if (user != null) ...[
              Text(user.username, style: Theme.of(context).textTheme.headline6),
              Text(user.realName, style: Theme.of(context).textTheme.subtitle1),
            ],
          ],
        ),
      ),
    );
  }
}
