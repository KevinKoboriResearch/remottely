import 'package:flutter/material.dart';
import 'package:remottely/models/current_user_model.dart';
import 'package:flutter/foundation.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:remottely/providers/google_sign_in.dart';
import 'package:provider/provider.dart';
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
class UsersListScreen extends StatelessWidget {
  // final List<User> users;
  // final ValueChanged<User> onTapped;
    final dynamic users;
  final dynamic onTapped;

  UsersListScreen({
    @required this.users,
    @required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  // final provider =
                  //     Provider.of<GoogleSignInProvider>(context, listen: false);
                  // provider.logout();
                },
                child: Text('Logout'),
              ),],),
      body: ListView(
        children: [
          for (var user in users)
            ListTile(
              title: Text(user.username),
              subtitle: Text(user.realName),
              onTap: () => onTapped(user),
            )
        ],
      ),
    );
  }
}
