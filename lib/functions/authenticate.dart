import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
// import 'package:remottely/views/marketing_page.dart';
// import 'package:provider/provider.dart';
// import 'package:remottely/providers/auth_provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
final LocalAuthentication _localAuthentication = LocalAuthentication();

authenticateUser(BuildContext context) async {
  if(kIsWeb) {
    return true;
  }
  else 
  if (await _isBiometricAvailable()) {
    await _getListOfBiometricTypes();
    bool isAuthenticated = await _authenticateUser(context);
    return isAuthenticated;
  } else {
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(
    //     builder: (context) => PagesTabController(0),
    //   ),
    // );
    return true;
  }
}

Future<bool> _isBiometricAvailable() async {
  bool isAvailable = await _localAuthentication.canCheckBiometrics;
  return isAvailable;
}

Future<void> _getListOfBiometricTypes() async {
  List<BiometricType> listOfBiometrics =
      await _localAuthentication.getAvailableBiometrics();
}

Future<bool> _authenticateUser(BuildContext context) async {
  bool isAuthenticated = await _localAuthentication.authenticateWithBiometrics(
    localizedReason: '"Toque o sensor de digital para prosseguir"',
    useErrorDialogs: true,
    stickyAuth: true,
  );

  return isAuthenticated;
}
