import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:remottely/utils/constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/functions/get_initials.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:remottely/exceptions/auth_exception.dart';
import 'package:remottely/functions/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:remottely/exceptions/check_internet_connection.dart';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:remottely/providers/google_sign_in.dart';
import 'package:remottely/utils/remottely_icons.dart';
import 'package:provider/provider.dart';
import 'package:remottely/widgets/dialog.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  bool _isSigningIn;

  GoogleSignInProvider() {
    _isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  Future login(BuildContext context) async {
    // BuildContext context;
    isSigningIn = true;

    final user = await googleSignIn.signIn();
    if (user == null) {
      isSigningIn = false;
      return;
    } else {
      final googleAuth = await user.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      var val = await FirebaseAuth.instance.signInWithCredential(credential);
      if (val.additionalUserInfo.isNewUser) {
        Future<ui.Image> _getImage(String urlImage) async {
          Completer<ui.Image> completer = Completer<ui.Image>();
          NetworkImage(urlImage)
              .resolve(ImageConfiguration())
              .addListener(ImageStreamListener((ImageInfo info, bool _) {
            completer.complete(info.image);
          }));
          return completer.future;
        }

        var userImageProfile = await _getImage(val.user.photoURL);

        final Map<String, dynamic> _authData = {
          'userId': val.user.uid,
          'userEmail': val.user.email,
          'userEmailVerified':
              val.user.emailVerified != null ? val.user.emailVerified : '',
          'userDisplayName':
              val.user.displayName != null ? val.user.displayName : '',
          'userPass': '',
          'username': '',
          'userPhoneNumber':
              val.user.phoneNumber != null ? val.user.phoneNumber : '',
          'userImageProfile': {
            'userImageProfileUrl':
                val.user.photoURL != null ? val.user.photoURL : '',
            'userImageProfileHeight':
                userImageProfile.height != null ? userImageProfile.height : '',
            'userImageProfileWidth':
                userImageProfile.width != null ? userImageProfile.width : '',
          }, //'',
          'userVerified': false,
        };

        await FirebaseFirestore.instance
            .collection('users')
            .doc(val.user.uid)
            .set(_authData);
        print(
            '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ${userImageProfile.toString()} <<<<<<< ' +
                '${val.user.uid}\n ${val.additionalUserInfo.isNewUser}');
      }

      isSigningIn = false;
    }
  }

  void logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
