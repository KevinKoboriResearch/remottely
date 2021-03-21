import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/utils/my_flutter_app_icons_2.dart';
import 'package:remottely/widgets/design/app_clipper.dart';
import 'package:remottely/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remottely/data/firestore/devices_collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:remottely/widgets/device/device_key_dialog.dart';
import 'package:remottely/functions/flushbar.dart';
import 'package:remottely/widgets/design/button_pop_neumorphic.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:remottely/exceptions/check_internet_connection.dart';
  class DevicesMapsPage extends StatefulWidget {
  @override
  DevicesMapsPageState createState() => DevicesMapsPageState();
}

class DevicesMapsPageState extends State<DevicesMapsPage> {
    @override
  void initState() {
    super.initState();
    // CheckInternet().checkConnection(context);
    _getLastKnowUserLocation();
  }

  @override
  void dispose() {
    // CheckInternet().listener.cancel();
    super.dispose();
  }
  Completer<GoogleMapController> _controller = Completer();
  double zoomVal = 5.0;
  CameraPosition _posicaoCamera = CameraPosition(
      target: LatLng(-15.797707138930033, -47.863976860690684), zoom: 12);
  Marker deviceMaker;
  Marker userMarker;
  List<Marker> deviceMarkers = [];
  final auth = FirebaseAuth.instance;

  _getLastKnowUserLocation() async {
    Position position = await Geolocator()
        .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      if (position != null) {
        _posicaoCamera = CameraPosition(
            target: LatLng(position.latitude, position.longitude), zoom: 19);
        userMarker = Marker(
          markerId: MarkerId('${auth.currentUser.uid}'),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: InfoWindow(title: auth.currentUser.displayName),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueViolet,
          ),
        );
        _movimentarCamera(_posicaoCamera);
      }
    });
  }

  _movimentarCamera(CameraPosition cameraPosition) async {
    GoogleMapController googleMapController = await _controller.future;
    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          Positioned(
            top: 48,
            left: 16,
            child: buttonPopNeumorphic(context, true),
          ),
          _pageTitle(),
          _googleLogo(),
          _buildContainer(),
        ],
      ),
    );
  }

  Widget _pageTitle() {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 54.0),
        child: NeumorphicText(
          'M A P S',
          style: NeumorphicStyle(
            depth: 1,
            color: AppColors.textColor,
          ),
          textStyle: NeumorphicTextStyle(
            fontFamily: 'Astronaut_PersonalUse',
            fontSize: 32,
          ),
        ),
      ),
    );
  }

  Widget _googleLogo() {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Image(
          height: 38,
          width: 38,
          image: AssetImage(
            "assets/logo/google_logo_white.png",
          ),
          filterQuality: FilterQuality.high,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _posicaoCamera,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: deviceMaker != null
            ? {
                userMarker,
                deviceMaker,
              }
            : userMarker != null
                ? {userMarker}
                : {},
      ),
    );
  }

  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        height: 193,
        child: StreamBuilder(
            stream: DevicesCollection().devicesUserSnapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> devicesSnapshot) {
              if (!devicesSnapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                scrollDirection: Axis.horizontal,
                children: devicesSnapshot.data.docs.map((device) {
                  double test = devicesSnapshot.data.docs.first.id == device.id
                      ? 7.0
                      : 0.0;
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 0.0,
                        left: test,
                        right: 7.0,
                        bottom: 7.0,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          // print(device["deviceLat"].toString());
                          var isLatitude = device["deviceLat"] != '' &&
                                  double.tryParse(device["deviceLat"]) != null
                              ? double.parse(device["deviceLat"]) >= -90 &&
                                      double.parse(device["deviceLat"]) <= 90
                                  ? true
                                  : false
                              : false;
                          var isLongitude = device["deviceLon"] != '' &&
                                  double.tryParse(device["deviceLon"]) != null
                              ? double.parse(device["deviceLon"]) >= -180 &&
                                      double.parse(device["deviceLon"]) <= 180
                                  ? true
                                  : false
                              : false;
                          setState(() {
                            if (isLatitude && isLongitude) {
                              deviceMaker = Marker(
                                markerId: MarkerId(device["deviceTitle"]),
                                position: LatLng(
                                    double.parse(device["deviceLat"]),
                                    double.parse(device["deviceLon"])),
                                infoWindow:
                                    InfoWindow(title: device['deviceTitle']),
                                icon: BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueRed,
                                ),
                              );
                              _gotoLocation(double.parse(device["deviceLat"]),
                                  double.parse(device["deviceLon"]));
                            } else {
                              showFlushbar(
                                context,
                                'I M P O R T A N T E!',
                                'A chave "${device['deviceTitle'].toUpperCase()}" não possui localização válida!',
                              );
                            }
                          });
                        },
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                height: 190,
                                color: AppColors.astratosDarkGreyColor,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: ClipPath(
                                clipper: AppClipper2(),
                                child: FadeInImage(
                                  height: 210,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  placeholder:
                                      AssetImage('assets/logo/logo.png'),
                                  image: NetworkImage(device['deviceImage']['deviceImageUrl']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Neumorphic(
                              style: NeumorphicStyle(
                                shape: NeumorphicShape.concave,
                                boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(12),
                                ),
                                depth: 3,
                                lightSource: LightSource.topLeft,
                                color: Colors.transparent,
                              ),
                              child: Container(
                                height: 190,
                                color: AppColors.astratosDarkGreyColor
                                    .withOpacity(0.8),
                              ),
                            ),
                            Container(
                              height: 190,
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: (MediaQuery.of(context).size.width *
                                            0.7) *
                                        0.80,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            Image(
                                              height: 22.5,
                                              width: 22.5,
                                              image: AssetImage(
                                                "assets/logo/remottely_light.png",
                                              ),
                                              filterQuality: FilterQuality.high,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(width: 6),
                                            Container(
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.6) *
                                                  0.56,
                                              child: Text(
                                                "R E M O T T E L Y",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: AppColors
                                                      .astronautCanvasColor,
                                                  fontFamily: 'Anurati',
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4.0),
                                          child: Icon(
                                            MyFlutterApp.user_friends,
                                            color:
                                                AppColors.astronautCanvasColor,
                                            size: 16,
                                          ),
                                        ),
                                        Container(
                                          width: 28,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              device['deviceUsers']
                                                  .length
                                                  .toString(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors
                                                    .astronautCanvasColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 26),
                                        Text(
                                          device['deviceTitle'].toUpperCase(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color:
                                                AppColors.astronautCanvasColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          device['deviceAdress'].toUpperCase(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color:
                                                AppColors.astronautCanvasColor,
                                            height: 1.4,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Column(
                                    children: [
                                      SizedBox(height: 4),
                                      Container(
                                        width: 30,
                                        height: 10,
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 30,
                                        child: NeumorphicIcon(
                                          MyFlutterApp2.barcode,
                                          size: 20,
                                          style: NeumorphicStyle(
                                            boxShape:
                                                NeumorphicBoxShape.roundRect(
                                              BorderRadius.circular(6),
                                            ),
                                            color:
                                                AppColors.astratosDarkGreyColor,
                                            depth: 1,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 30,
                                        child: NeumorphicIcon(
                                          MyFlutterApp2.barcode,
                                          size: 20,
                                          style: NeumorphicStyle(
                                            boxShape:
                                                NeumorphicBoxShape.roundRect(
                                              BorderRadius.circular(6),
                                            ),
                                            color:
                                                AppColors.astratosDarkGreyColor,
                                            depth: 1,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 40,
                                        child: NeumorphicButton(
                                          onPressed: () {
                                            deviceKeyDialog(context, device);
                                          },
                                          style: NeumorphicStyle(
                                            boxShape:
                                                NeumorphicBoxShape.roundRect(
                                              BorderRadius.circular(4),
                                            ),
                                            color: AppColors.astratosGreyColor
                                                .withOpacity(0.299),
                                            depth: 1,
                                          ),
                                          padding: const EdgeInsets.all(6.0),
                                          child: Icon(
                                            MyFlutterApp.remottely_key,
                                            color: AppColors.accentColor,
                                            size: 28,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
      ),
    );
  }

  Widget myDetailsContainer1(String restaurantName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            restaurantName,
            style: TextStyle(
                color: Color(0xff6200ee),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        SizedBox(height: 5.0),
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
                child: Text(
              "4.1",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStarHalf,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
                child: Text(
              "(946)",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
          ],
        )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
          "American \u00B7 \u0024\u0024 \u00B7 1.6 mi",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
          "Closed \u00B7 Opens 17:00 Thu",
          style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        )),
      ],
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }
}

Marker gramercyMarker = Marker(
  markerId: MarkerId('gramercy'),
  position: LatLng(40.738380, -73.988426),
  infoWindow: InfoWindow(title: 'Gramercy Tavern'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueRed,
  ),
);

Marker bernardinMarker = Marker(
  markerId: MarkerId('bernardin'),
  position: LatLng(40.761421, -73.981667),
  infoWindow: InfoWindow(title: 'Le Bernardin'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueRed,
  ),
);
Marker blueMarker = Marker(
  markerId: MarkerId('bluehill'),
  position: LatLng(40.732128, -73.999619),
  infoWindow: InfoWindow(title: 'Blue Hill'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueRed,
  ),
);

Marker newyork1Marker = Marker(
  markerId: MarkerId('newyork1'),
  position: LatLng(40.742451, -74.005959),
  infoWindow: InfoWindow(title: 'Los Tacos'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueRed,
  ),
);
Marker newyork2Marker = Marker(
  markerId: MarkerId('newyork2'),
  position: LatLng(40.729640, -73.983510),
  infoWindow: InfoWindow(title: 'Tree Bistro'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueRed,
  ),
);
Marker newyork3Marker = Marker(
  markerId: MarkerId('newyork3'),
  position: LatLng(40.719109, -74.000183),
  infoWindow: InfoWindow(title: 'Le Coucou'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueRed,
  ),
);
