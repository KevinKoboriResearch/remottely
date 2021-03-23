// import 'dart:async';
// import 'dart:convert';

import 'package:flutter/material.dart';
class DrawerProvider with ChangeNotifier {
  int pageIndex;

  DrawerProvider({
    this.pageIndex = 3,
  });
  void changeIndex(int index) {
    pageIndex = index;
    notifyListeners();
  }
}
