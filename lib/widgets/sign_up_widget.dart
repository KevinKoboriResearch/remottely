import 'package:flutter/material.dart';
import 'package:remottely/providers/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SignUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Stack(
        fit: StackFit.expand,
        children: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed))
                    return Colors.deepOrange;
                  return Colors
                      .white; //Color(0xffDDDDDD); // Use the component's default.
                },
              ),
            ),
            onPressed: () async {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              await provider.login(context);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 64),
                Text(
                  'R E M O T T E L Y',
                  style: TextStyle(
                    // depth: 1,
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'anurati',
                  ),
                ),
                Spacer(flex: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                          color: Colors.yellow[800]),
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
                    // Icon(RemottelyIcons.google,color: Colors.red,),
                    Text(
                      ' Login', //'Sign In With ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.grey[600]),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'Clique na tela',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
                Spacer(),
              ],
            ),
          ),
          // Center(
          //     child: Padding(
          //   padding: const EdgeInsets.only(top: 64.0),
          //   child: Text(
          //     'Clique na tela',
          //     style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          //   ),
          // )),
        ],
      );
}
