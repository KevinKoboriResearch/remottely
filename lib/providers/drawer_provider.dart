// import 'dart:async';
// import 'dart:convert';

import 'package:flutter/material.dart';
class DrawerProvider with ChangeNotifier {
  int pageIndex;

  DrawerProvider({
    this.pageIndex,
  });
  void changeIndex(int index) {
    pageIndex = index;
    notifyListeners();
  }
}
