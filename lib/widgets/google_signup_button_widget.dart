import 'package:flutter/material.dart';
import 'package:remottely/providers/google_sign_in.dart';
import 'package:remottely/utils/remottely_icons.dart';
import 'package:provider/provider.dart';

class GoogleSignupButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(4),
        child: OutlineButton.icon(
          label: Row(
            children: [
              Text(
                'Sign In With ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                'G',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),
              ),
              Text(
                'o',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
              ),
              Text(
                'o',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.yellow[700]),
              ),
              Text(
                'g',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),
              ),
              Text(
                'l',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.green),
              ),
              Text(
                'e',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
              ),
            ],
          ),
          shape: StadiumBorder(),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          highlightedBorderColor: Colors.black,
          borderSide: BorderSide(color: Colors.black),
          textColor: Colors.black,
          icon: Container(),//Icon(RemottelyIcons.google, color: Colors.red),
          onPressed: () {
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
            provider.login();
          },
        ),
      );
}
