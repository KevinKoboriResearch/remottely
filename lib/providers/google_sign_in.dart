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
    final user = await googleSignIn.signIn();

    if (user == null) {
      return;
    } else {
      final googleAuth = await user.authentication;
      isSigningIn = true;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      var userInstance =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userInstance.additionalUserInfo.isNewUser) {
        Future<ui.Image> _getImage(String urlImage) async {
          Completer<ui.Image> completer = Completer<ui.Image>();
          NetworkImage(urlImage)
              .resolve(ImageConfiguration())
              .addListener(ImageStreamListener((ImageInfo info, bool _) {
            completer.complete(info.image);
          }));
          return completer.future;
        }

        var userImage = await _getImage(userInstance.user.photoURL);

        final Map<String, dynamic> _authData = {
          'id': userInstance.user.uid,
          'email': userInstance.user.email,
          'emailVerified': userInstance.user.emailVerified != null
              ? userInstance.user.emailVerified
              : '',
          'displayName': userInstance.user.displayName != null
              ? userInstance.user.displayName
              : '',
          'pass': '',
          'phoneNumber': userInstance.user.phoneNumber != null
              ? userInstance.user.phoneNumber
              : '',
          'image': {
            'imageUrl': userInstance.user.photoURL != null
                ? userInstance.user.photoURL
                : '',
            'imageHeight': userImage.height != null ? userImage.height : '',
            'imageWidth': userImage.width != null ? userImage.width : '',
          }, //'',
          'verified': false,
          'companies': [],
        };

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userInstance.user.uid)
            .set(_authData);
        print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ${userImage.toString()} <<<<<<< ' +
            '${userInstance.user.uid}\n ${userInstance.additionalUserInfo.isNewUser}');
      }

      isSigningIn = false;
    }
  }

  void logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
