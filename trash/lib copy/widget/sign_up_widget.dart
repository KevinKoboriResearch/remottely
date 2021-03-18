import 'package:flutter/material.dart';
import 'package:remottely/widget/google_signup_button_widget.dart';

class SignUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Stack(
        fit: StackFit.expand,
        children: [
          // CustomPaint(painter: BackgroundPainter()),
          buildSignUp(),
        ],
      );

  Widget buildSignUp() => Column(
        children: [
          Container(
            height: 50,
          ),
          Center(
            child: Text(
              'REMOTTELY',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Spacer(flex: 2),
          GoogleSignupButtonWidget(),
          SizedBox(height: 12),
          Text(
            'Login to continue',
            style: TextStyle(fontSize: 16),
          ),
          Spacer(),
        ],
      );
}
