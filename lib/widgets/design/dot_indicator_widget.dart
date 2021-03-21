import 'package:flutter/material.dart';
import 'package:remottely/utils/constants.dart';

class DotIndicatorWidget extends StatelessWidget {
  final bool isActive;
  DotIndicatorWidget(this.isActive);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 1.0,
      width: isActive
          ? MediaQuery.maybeOf(context).size.width * 0.3
          : MediaQuery.maybeOf(context).size.width * 0.05,
      decoration: BoxDecoration(
        color: isActive ? AppColors.accentColor : AppColors.textColor,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
}
