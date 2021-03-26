import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:shop/app/utils/constants.dart';

void showFlushbar(BuildContext context, String msgTitle, String msg) {
  Flushbar<bool>(
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
    margin: EdgeInsets.all(12),
    borderRadius: 8,
    backgroundColor: AppColors.accentColor.withOpacity(0.98),
    borderColor: AppColors.astronautCanvasColor,
    title: msgTitle,
    message: msg,
    // duration: Duration(seconds: 7),
  )..show(context);
}
