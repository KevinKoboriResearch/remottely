import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
// import 'package:remottely/views/marketing_page.dart';
// import 'package:provider/provider.dart';
// import 'package:remottely/providers/auth_provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:remottely/views/device/devices_page_list.dart';
import 'package:remottely/views/control/auth_app_page.dart';
import 'package:flutter/material.dart';
import 'package:remottely/functions/authenticate.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:remottely/views/device/devices_page_list.dart';
import 'package:remottely/views/control/auth_app_page.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:remottely/exceptions/check_internet_connection.dart';
class BlockPage extends StatefulWidget {
  @override
  _BlockPageState createState() => _BlockPageState();
}

class _BlockPageState extends State<BlockPage> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    // CheckInternet().checkConnection(context);
    authenticate();
  }

  @override
  void dispose() {
    // CheckInternet().listener.cancel();
    super.dispose();
  }
  authenticate() async {
    bool isAuthenticated = await authenticateUser(context);
    if (isAuthenticated) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => DevicesPageList(),
        ),
      );
    }
    // if (await _isBiometricAvailable()) {
    //   await _getListOfBiometricTypes();
    //   await _authenticateUser();
    // } else {
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(
    //       builder: (context) => DevicesPageList(),
    //     ),
    //   );
    // }
  }

  // Future<bool> _isBiometricAvailable() async {
  //   bool isAvailable = await _localAuthentication.canCheckBiometrics;
  //   return isAvailable;
  // }

  // Future<void> _getListOfBiometricTypes() async {
  //   List<BiometricType> listOfBiometrics =
  //       await _localAuthentication.getAvailableBiometrics();
  // }

  // Future<void> _authenticateUser() async {
  //   bool isAuthenticated =
  //       await _localAuthentication.authenticateWithBiometrics(
  //     localizedReason: '"Toque o sensor de digital para prosseguir"',
  //     useErrorDialogs: true,
  //     stickyAuth: true,
  //   );

  //   if (isAuthenticated) {
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (context) => DevicesPageList(),
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NeumorphicButton(
              onPressed: () => authenticate(),
              style: NeumorphicStyle(
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(8),
                ),
                color: AppColors.astronautConvexColor,
                depth: 1,
              ),
              padding: const EdgeInsets.only(
                top: 6.0,
                bottom: 8.0,
                left: 12.0,
                right: 12.0,
              ),
              child: NeumorphicText(
                'A u t e n t i c a r - s e',
                style: NeumorphicStyle(
                  depth: 2,
                  color: AppColors.textColor,
                ),
                textStyle: NeumorphicTextStyle(
                  fontFamily: 'Astronaut_PersonalUse',
                  fontSize: 24,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            NeumorphicButton(
              onPressed: () {
                // Provider.of<Auth>(context, listen: false).logout();
                // MaterialPageRoute(
                //   builder: (context) => MarketingPage(),
                // );
                FirebaseAuth.instance.signOut();
              },
              style: NeumorphicStyle(
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(8),
                ),
                color: AppColors.astronautConvexColor,
                depth: 1,
              ),
              padding: const EdgeInsets.only(
                top: 10.0,
                bottom: 12.0,
                left: 12.0,
                right: 12.0,
              ),
              child: NeumorphicText(
                'S a i r',
                style: NeumorphicStyle(
                  depth: 2,
                  color: AppColors.astronautOrangeColor,
                ),
                textStyle: NeumorphicTextStyle(
                  fontFamily: 'Astronaut_PersonalUse',
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
