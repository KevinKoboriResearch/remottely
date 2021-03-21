import 'package:flutter/material.dart';

class AppClipper extends CustomClipper<Path> {
  const AppClipper();

  @override
  Path getClip(Size size) {
    Path path = new Path();

    path.moveTo(0, 0);
    path.lineTo(size.width * 0.84, 0);

    path.lineTo(size.width - 95, 350);
    path.lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class AppClipper2 extends CustomClipper<Path> {
  const AppClipper2();

  @override
  Path getClip(Size size) {
    Path path = new Path();

    path.moveTo(0, 0);
    path.lineTo(size.width * 0.83, 0);

    path.lineTo(size.width - 85, 350);
    path.lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class AppClipper3 extends CustomClipper<Path> {
  final bool roundedBottom;
  AppClipper3({this.roundedBottom = true});

  @override
  Path getClip(Size size) {
    Path path = new Path();

    path.moveTo(0, 0);
    path.lineTo(0, size.height);

    if (roundedBottom) path.quadraticBezierTo(0, size.height, 0, size.height);
    path.lineTo(size.width, size.height);

    if (roundedBottom)
      path.quadraticBezierTo(size.width, size.height, size.width, size.height);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(size.width, 0, size.width, size.width / 2.3);
    path.lineTo(0, 0);
    path.quadraticBezierTo(0, 0, 0, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
