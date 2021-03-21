import 'package:flutter/foundation.dart';

class Device {
  final String id;
  final String deviceProperty;
  final String deviceTitle;
  final String deviceAdress;
  final String deviceLat;
  final String deviceLon;
  final String deviceTriggerUrl;
  final dynamic deviceImage;
  final List<dynamic> deviceManagers;
  final List<dynamic> deviceUsers;
  final bool deviceVerified;

  Device({
    @required this.id,
    @required this.deviceProperty,
    @required this.deviceTitle,
    @required this.deviceAdress,
    @required this.deviceLat,
    @required this.deviceLon,
    @required this.deviceTriggerUrl,
    @required this.deviceImage,
    @required this.deviceManagers,
    @required this.deviceUsers,
    @required this.deviceVerified,
  });
}
