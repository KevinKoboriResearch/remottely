import 'dart:async';

import 'package:flutter/material.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:remottely/functions/flushbar.dart';

class CheckInternet {
  StreamSubscription<DataConnectionStatus> listener;
  var internetStatus = "Unknown";
  var contentmessage = "Unknown";

  checkConnection(BuildContext context) async {
    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          break;
        case DataConnectionStatus.disconnected:
          // internetStatus = "You are disconnected to the Internet.";
          // contentmessage = "Please check your internet connection";
          internetStatus = "Você estâ desconectado da internet.";
          contentmessage = "Por favor, verifique sua conexão com a internet";
          showFlushbar(
            context,
            '$internetStatus',
            '$contentmessage',
          );
          break;
      }
    });
    return await DataConnectionChecker().connectionStatus;
  }
}
