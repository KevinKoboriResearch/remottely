import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remottely/utils/constants.dart';
import 'package:remottely/views/control/auth_screen.dart';
import 'package:remottely/widgets/design/dot_indicator_widget.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remottely/views/control/marketing_page.dart';
// import 'package:remottely/views/control/block_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase/firebase.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/exceptions/check_internet_connection.dart';
import 'package:remottely/views/device/devices_page_list.dart';

class MarketingPage extends StatefulWidget {
  @override
  _MarketingPageState createState() => _MarketingPageState();
}

class _MarketingPageState extends State<MarketingPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    CheckInternet().checkConnection(context);
  }

  @override
  void dispose() {
    CheckInternet().listener.cancel();
    super.dispose();
  }

  final int _numPages = 4;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  final _auth = FirebaseAuth.instance;
  List<Widget> _buildPageDotIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage
          ? DotIndicatorWidget(true)
          : DotIndicatorWidget(false));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: <Widget>[
            PageView(
              physics: ClampingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: <Widget>[
                // //1
                // Center(
                //   child: Padding(
                //     padding: const EdgeInsets.all(16.0),
                //     child: Neumorphic(
                //       style: NeumorphicStyle(
                //         shape: NeumorphicShape.concave,
                //         boxShape: NeumorphicBoxShape.roundRect(
                //           BorderRadius.circular(12),
                //         ),
                //         depth: 3,
                //         lightSource: LightSource.topLeft,
                //         color: Colors.transparent,
                //       ),
                //       child: Container(
                //         height: 200,
                //         padding: EdgeInsets.all(16.0),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: <Widget>[
                //             Text(
                //               'Connect people\naround the world',
                //               style: AppText.kTitleStyle,
                //             ),
                //             SizedBox(height: 15.0),
                //             Text(
                //               'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                //               style: AppText.kSubtitleStyle,
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // //2
                // Center(
                //   child: Padding(
                //     padding: const EdgeInsets.all(16.0),
                //     child: Neumorphic(
                //       style: NeumorphicStyle(
                //         shape: NeumorphicShape.concave,
                //         boxShape: NeumorphicBoxShape.roundRect(
                //           BorderRadius.circular(12),
                //         ),
                //         depth: 3,
                //         lightSource: LightSource.topLeft,
                //         color: Colors.transparent,
                //       ),
                //       child: Container(
                //         height: 200,
                //         padding: EdgeInsets.all(16.0),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: <Widget>[
                //             Text(
                //               'Live your life smarter\nwith us!',
                //               style: AppText.kTitleStyle,
                //             ),
                //             SizedBox(height: 15.0),
                //             Text(
                //               'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                //               style: AppText.kSubtitleStyle,
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // //3
                // Center(
                //   child: Padding(
                //     padding: const EdgeInsets.all(16.0),
                //     child: Neumorphic(
                //       style: NeumorphicStyle(
                //         shape: NeumorphicShape.concave,
                //         boxShape: NeumorphicBoxShape.roundRect(
                //           BorderRadius.circular(12),
                //         ),
                //         depth: 3,
                //         lightSource: LightSource.topLeft,
                //         color: Colors.transparent,
                //       ),
                //       child: Container(
                //         height: 200,
                //         padding: EdgeInsets.all(16.0),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: <Widget>[
                //             Text(
                //               'Connect people\naround the world',
                //               style: AppText.kTitleStyle,
                //             ),
                //             SizedBox(height: 15.0),
                //             Text(
                //               'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                //               style: AppText.kSubtitleStyle,
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // // 4
                AuthScreen(),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    // _currentPage == _numPages - 1
                    //     ? Alignment.center
                    //     : Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {},
                      child: _currentPage == _numPages - 1
                          ? NeumorphicText(
                              'W E L C O M E',
                              style: NeumorphicStyle(
                                depth: 1,
                                color: AppColors.textColor,
                              ),
                              textStyle: NeumorphicTextStyle(
                                fontFamily: 'Astronaut_PersonalUse',
                                fontSize: 16,
                              ),
                            )
                          : NeumorphicText(
                              'R E M O T T E L Y',
                              style: NeumorphicStyle(
                                depth: 1,
                                color: AppColors.textColor,
                              ),
                              textStyle: NeumorphicTextStyle(
                                fontFamily: 'anurati',
                                fontSize: 14,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 41.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _currentPage != 0 && _currentPage != _numPages - 1
                      ? Expanded(
                          child: Align(
                            alignment: FractionalOffset.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: ButtonTheme(
                                minWidth: 50.0,
                                height: 50.0,
                                child: FlatButton(
                                  onPressed: () {
                                    _pageController.previousPage(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease,
                                    );
                                  },
                                  shape: CircleBorder(),
                                  color: Colors.transparent,
                                  child: Icon(
                                    MyFlutterApp.left_open_big,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Text(''),
                  // _currentPage != _numPages - 1
                  //     ? Expanded(
                  //         child: Align(
                  //           alignment: FractionalOffset.bottomRight,
                  //           child: Padding(
                  //             padding: const EdgeInsets.only(right: 20.0),
                  //             child: ButtonTheme(
                  //               minWidth: 50.0,
                  //               height: 50.0,
                  //               child: FlatButton(
                  //                 onPressed: () {
                  //                   _pageController.nextPage(
                  //                     duration: Duration(milliseconds: 500),
                  //                     curve: Curves.ease,
                  //                   );
                  //                 },
                  //                 shape: CircleBorder(),
                  //                 color: Colors.transparent,
                  //                 child: Icon(
                  //                   MyFlutterApp.right_open_big,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       )
                  //     : Text(''),
                ],
              ),
            ),
            // _currentPage != 3
            //     ? Align(
            //         alignment: Alignment.bottomCenter,
            //         child: Padding(
            //           padding: const EdgeInsets.only(bottom: 66.0),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: _buildPageDotIndicator(),
            //           ),
            //         ),
            //       )
            //     : Text(''),
          ],
        ),
      ),
    );
  }
}
