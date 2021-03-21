import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:remottely/utils/constants.dart';
import 'dart:ui';
import 'package:remottely/views/device/devices_history_page_list.dart';
import 'package:remottely/views/device/devices_maps_page.dart';
import 'package:remottely/views/device/devices_maps_web_page.dart';
import 'package:remottely/views/user/user_perfil_page.dart';
import 'package:remottely/views/user/user_notifications_page_list.dart';
import 'package:remottely/views/user/user_friendships_accepted_page_list.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:remottely/functions/urls.dart';
import 'package:remottely/utils/my_flutter_app_icons_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/views/control/auth_app_page.dart';
import 'package:remottely/views/device/devices_manage_page_list.dart';
import 'package:remottely/views/device/devices_page_list.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/utils/constants.dart';
import 'package:remottely/views/control/drawer_page.dart';
import 'package:remottely/widgets/device/devices_page_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remottely/data/firestore/users_collection.dart';
import 'package:remottely/widgets/layouts/layout_custom_scroll_view.dart';
import 'package:remottely/views/device/device_form_page.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:remottely/exceptions/check_internet_connection.dart';

class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  // var usuarioLogado;

  @override
  void initState() {
    super.initState();
    // CheckInternet().checkConnection(context);
  }

  @override
  void dispose() {
    // CheckInternet().listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: StreamBuilder(
        stream: UsersCollection().userSnapshots(auth.currentUser.uid),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot> userSnapshot) {
          if (!userSnapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  color: AppColors.astratosDarkGreyColor,
                  child: Column(children: <Widget>[
                    AppBar(
                      backgroundColor:
                          Colors.transparent, //AppColors.blueColor,
                      elevation: 0,
                      toolbarHeight: 50,
                      centerTitle: true,
                      title: Text(
                        'R E M O T T E L Y',
                        style: TextStyle(
                            color: AppColors.astronautCanvasColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Anurati'),
                      ),
                      automaticallyImplyLeading: false,
                    ),
                    Container(
                      color: Colors.transparent, //AppColors.redColor,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 55,
                                backgroundColor: AppColors.astronautCanvasColor,
                                child: CircleAvatar(
                                  radius: 52,
                                  backgroundColor: Colors.grey[400],
                                  backgroundImage:
                                      userSnapshot.data['userImageProfile']['userImageProfileUrl'] != ''
                                          ? NetworkImage(userSnapshot.data['userImageProfile']['userImageProfileUrl'])
                                          : null,
                                  // usuarioLogado.photoURL != null
                                  //     ? NetworkImage(usuarioLogado.photoURL)
                                  //     : null,
                                  // AssetImage(
                                  //     'assets/logo/remottely_light_center_bg.png'),
                                ),
                              ),
                              Positioned(
                                bottom: 30,
                                left: 30,
                                child: userSnapshot.data['userImageProfile']['userImageProfileUrl'] != null
                                    ? Container()
                                    : NeumorphicIcon(
                                        MyFlutterApp.user_4,
                                        size: 55,
                                        style: NeumorphicStyle(
                                          depth: 1,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Container(
                            child: Center(
                              child: Text(
                                userSnapshot.data['userName'],//usuarioLogado.displayName,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Astronaut_PersonalUse',
                                  color: Colors.grey,
                                  letterSpacing: 1,
                                  wordSpacing: 3,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            color: Colors.grey[800],
                            height: 0,
                            thickness: 1,
                            endIndent: 0,
                          ),
                          ListTile(
                            dense: true,
                            tileColor: Colors.transparent,
                            leading: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: FaIcon(
                                Icons.notifications,
                                size: 18,
                                color: AppColors.astronautCanvasColor,
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Notificações',
                                  style: TextStyle(
                                    color: AppColors.astronautCanvasColor,
                                    fontSize: 16,
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  MyFlutterApp.right_open_big,//angle_double_right,
                                  color: AppColors.astronautCanvasColor,
                                  size: 16,
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => UserNotifications(),
                                ),
                              );
                            },
                          ),
                          Divider(
                            color: Colors.grey[800],
                            height: 8,
                            thickness: 1,
                            endIndent: 0,
                          ),
                          ListTile(
                            dense: true,
                            tileColor: Colors.transparent,
                            leading: Padding(
                              padding:
                                  const EdgeInsets.only(left: 7.0, top: 7.0),
                              child: FaIcon(
                                MyFlutterApp.user_4,
                                size: 14,
                                color: AppColors.astronautCanvasColor,
                              ),
                            ),
                            title: Text(
                              'Perfil',
                              style: TextStyle(
                                color: AppColors.astronautCanvasColor,
                                fontSize: 16,
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => UserPerfil(),
                                ),
                              );
                            },
                          ),
                          ListTile(
                            dense: true,
                            tileColor: Colors.transparent,
                            leading: Padding(
                              padding:
                                  const EdgeInsets.only(left: 5.0, top: 7.0),
                              child: FaIcon(
                                MyFlutterApp.users_2,
                                size: 14,
                                color: AppColors.astronautCanvasColor,
                              ),
                            ),
                            title: Text(
                              'Contatos',
                              style: TextStyle(
                                color: AppColors.astronautCanvasColor,
                                fontSize: 16,
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      UserFriendshipsAcceptedPageList(),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                  ],),
                ),
                SizedBox(height: 4),
                // 1
                ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 7.0, top: 7.0),
                    child: FaIcon(
                      FontAwesomeIcons.key,
                      size: 14,
                    ),
                  ),
                  title: Text(
                    'Chaves',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => DevicesPageList(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 4),
                // 3
                ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 7.0, top: 7.0),
                    child: FaIcon(
                      MyFlutterApp2.history_2,
                      size: 14,
                    ),
                  ),
                  title: Text(
                    'Histórico de Aberturas',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => DevicesHistoryPageList(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 4),
                // 2
                ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 5, top: 7.0),
                    child: FaIcon(
                      Icons.edit,
                      size: 18,
                    ),
                  ),
                  title: Text(
                    'Gerenciar Chaves',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => DevicesManagePageList(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 4),
                // teste
                ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 6.0),
                    child: FaIcon(
                      MyFlutterApp.globe_6,
                      size: 16,
                    ),
                  ),
                  title: Text(
                    'Chaves no Mapa',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => kIsWeb
                            ? DevicesMapsWebPage()
                            : DevicesMapsPage(), //1
                      ),
                    );
                  },
                ),
                // 5
                ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 7.0),
                    child: FaIcon(
                      MyFlutterApp2.dollar,
                      size: 14,
                    ),
                  ),
                  title: Text(
                    'Contratar Serviço',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    launchURL();
                  },
                ),
                SizedBox(height: 4),
                // 6
                ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 6.0),
                    child: FaIcon(
                      MyFlutterApp2.sign_out_alt,
                      size: 14,
                    ),
                  ),
                  title: Text(
                    'Sair',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => AuthAppPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
