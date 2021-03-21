import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/utils/constants.dart';
import 'package:remottely/views/control/drawer_page.dart';
import 'package:remottely/widgets/device/devices_page_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remottely/data/firestore/devices_collection.dart';
import 'package:remottely/widgets/layouts/layout_custom_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/widgets/layouts/layout_push.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remottely/data/firestore/notifications_collection.dart';
import 'package:remottely/widgets/user/user_notifications_page_item.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:remottely/utils/my_flutter_app_icons_2.dart';
import 'package:remottely/utils/constants.dart';
import 'dart:ui';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'dart:async';
import 'package:remottely/widgets/layouts/layout_push.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/utils/my_flutter_app_icons_2.dart';
import 'package:remottely/widgets/design/app_clipper.dart';
import 'package:remottely/utils/constants.dart';
import 'package:remottely/widgets/user/user_perfil_desc.dart';
import 'package:remottely/functions/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remottely/data/firestore/device_triggered_collection.dart';
import 'package:remottely/data/firestore/devices_collection.dart';
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
class UserPerfil extends StatefulWidget {
  @override
  _UserPerfilState createState() => _UserPerfilState();
}

class _UserPerfilState extends State<UserPerfil> {
  FirebaseAuth auth = FirebaseAuth.instance;

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
    return Scaffold(
      // backgroundColor: AppColors.astronautCanvasColor,
      // extendBody: true,
      body: 
      Builder(
        builder: (context) {
          return StreamBuilder(
            stream: UsersCollection().userSnapshots(auth.currentUser.uid),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> userSnapshot) {
              if (!userSnapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return LayoutCustomScrollView(
                1,
                UserPerfil(),
                'P E R F I L',
                null,
                UserPerfilPageDesc(userSnapshot),
              );
            },
          );
        },
      ),
    );
  }
}
