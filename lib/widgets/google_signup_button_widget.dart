import 'package:flutter/material.dart';
import 'package:remottely/providers/google_sign_in.dart';
import 'package:remottely/utils/remottely_icons.dart';
import 'package:provider/provider.dart';
import 'package:remottely/widgets/dialog.dart';

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
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue),
              ),
              Text(
                'o',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.red),
              ),
              Text(
                'o',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.yellow[700]),
              ),
              Text(
                'g',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue),
              ),
              Text(
                'l',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.green),
              ),
              Text(
                'e',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.red),
              ),
            ],
          ),
          shape: StadiumBorder(),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          highlightedBorderColor: Colors.black,
          borderSide: BorderSide(color: Colors.black),
          textColor: Colors.black,
          icon: Container(), //Icon(RemottelyIcons.google, color: Colors.red),
          onPressed: () async {
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
            //  CustomDialogBox(title: 'title', descriptions: 'descriptions', text: 'text', img: null);
            // showDialog(
            //     context: context,
            //     builder: (BuildContext context) {
            //       return CustomDialogBox(
            //         title: "Custom Dialog Demo",
            //         descriptions:
            //             "Hii all this is a custom dialog in flutter and  you will be use in your flutter applications",
            //         text: "Yes",
            //       );
            //     });
            await provider.login(context);
          },
        ),
      );
}
