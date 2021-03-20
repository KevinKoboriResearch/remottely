import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:universal_platform/universal_platform.dart';

class AppURLs {
  static const BASE_API_URL = 'https://remottely-key-firebase.firebaseio.com';
}

class AppKey {
  static const IOS_GOOGLE_API_KEY =
      'AIzaSyAt6woNZOsFEM23VuhP-tY59I3QAEcwE_0';
  static const ANDROID_GOOGLE_API_KEY =
      'AIzaSyAy-rnrKZAAbtePw0ynMwdQORieCYwKZg8';
  static const WEB_GOOGLE_API_KEY =
      'AIzaSyCQUTrZVXRzlR1WK5Xe0deTawiP0urxfpg';
  static String get detectGoogleApi =>
      kIsWeb ? WEB_GOOGLE_API_KEY : UniversalPlatform.isAndroid ? ANDROID_GOOGLE_API_KEY : IOS_GOOGLE_API_KEY;
}