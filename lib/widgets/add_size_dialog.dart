import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:remottely/models/product_model.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:remottely/utils/constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:ui';
import 'dart:io';
import 'package:remottely/utils/my_flutter_app_icons_2.dart';

import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:remottely/validators/product_validators.dart';

import 'package:remottely/styles/product_styles.dart';
import 'package:remottely/widgets/product_sizes.dart';
import 'package:remottely/functions/flushbar.dart';
class AddSizeDialog extends StatelessWidget {

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _controller,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: FlatButton(
                child: Text("Add"),
                textColor: AppColors.accentColor,
                onPressed: (){
                  Navigator.of(context).pop(_controller.text);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
