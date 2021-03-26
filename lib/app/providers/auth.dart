import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import '../services/store.dart';
// import '../exceptions/auth_exception.dart';
import '../utils/constants.dart';
class Auth with ChangeNotifier {
  String _userId;
  String _token;
  String _username;
  DateTime _expiryDate;
  Timer _logoutTimer;

  String get userId {
    return isAuth ? _userId : null;
  }

  String get username {
    return _username != null ? _username : null;
  }

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_token != null &&
        _expiryDate != null &&
        _expiryDate.isAfter(DateTime.now())) {
      return _token;
    } else {
      return null;
    }
  }

  // Future<void> _authenticate(
  //     String email, String password, String username, String urlSegment) async {
  //   final url =
  //       'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=${AppKey.detectGoogleApi}';//${AppKey.detectGoogleApi}';//AIzaSyAy-rnrKZAAbtePw0ynMwdQORieCYwKZg8

  //   final response = await http.post(
  //     url,
  //     body: json.encode({
  //       "email": email,
  //       "password": password,
  //       "displayName": username,
  //       "returnSecureToken": true,
  //     }),
  //   );

  //   final responseBody = json.decode(response.body);
  //   if (responseBody["error"] != null) {
  //     throw AuthException(responseBody['error']['message']);
  //   } else {
  //     _token = responseBody["idToken"];
  //     _userId = responseBody["localId"];
  //     _username = responseBody["displayName"];
  //     _expiryDate = DateTime.now().add(
  //       Duration(
  //         seconds: int.parse(responseBody["expiresIn"]),
  //       ),
  //     );

  //     Store.saveMap('userData', {
  //       "token": _token,
  //       "userId": _userId,
  //       "username": _username,
  //       "expiryDate": _expiryDate.toIso8601String(),
  //     });

  //     _autoLogout();
  //     notifyListeners();
  //   }

  //   return Future.value();
  // }

  // Future<void> signup(String email, String password, String username) async {
  //   return _authenticate(email, password, username, "signUp");
  // }

  // Future<void> login(String email, String password) async {
  //   return _authenticate(email, password, null, "signInWithPassword");
  // }

  // Future<void> tryAutoLogin() async {
  //   if (isAuth) {
  //     return Future.value();
  //   }

  //   final userData = await Store.getMap('userData');
  //   if (userData == null) {
  //     return Future.value();
  //   }

  //   final expiryDate = DateTime.parse(userData["expiryDate"]);

  //   if (expiryDate.isBefore(DateTime.now())) {
  //     return Future.value();
  //   }

  //   _userId = userData["userId"];
  //   _token = userData["token"];
  //   _username = userData["username"];
  //   _expiryDate = expiryDate;

  //   _autoLogout();
  //   notifyListeners();
  //   return Future.value();
  // }

  // void logout() {
  //   _token = null;
  //   _userId = null;
  //   _expiryDate = null;
  //   if (_logoutTimer != null) {
  //     _logoutTimer.cancel();
  //     _logoutTimer = null;
  //   }
  //   Store.remove('userData');
  //   notifyListeners();
  // }

  // void _autoLogout() {
  //   if (_logoutTimer != null) {
  //     _logoutTimer.cancel();
  //   }
  //   final timeToLogout = _expiryDate.difference(DateTime.now()).inSeconds;
  //   _logoutTimer = Timer(Duration(seconds: timeToLogout), logout);
  // }
}
