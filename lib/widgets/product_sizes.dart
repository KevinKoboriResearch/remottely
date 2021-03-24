import 'package:flutter/material.dart';
import 'package:remottely/widgets/add_size_dialog.dart';
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
class ProductSizes extends FormField<List> {

  ProductSizes(
  {
    BuildContext context,
    List initialValue,
    FormFieldSetter<List> onSaved,
    FormFieldValidator<List> validator,
  }) : super(
    initialValue: initialValue,
    onSaved: onSaved,
    validator: validator,
    builder: (state){
      return SizedBox(
        height: 34,
        child: GridView(
          padding: EdgeInsets.symmetric(vertical: 4),
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 8,
            childAspectRatio: 0.5
          ),
          children: state.value.map(
              (s){
                return GestureDetector(
                  onLongPress: (){
                    state.didChange(state.value..remove(s));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      border: Border.all(
                        color: AppColors.accentColor,
                        width: 3
                      )
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      s,
                      // style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
          ).toList()..add(
            GestureDetector(
              onTap: () async {
                String size = await showDialog(context: context, builder: (context)=>AddSizeDialog());
                if(size != null) state.didChange(state.value..add(size));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    border: Border.all(
                        color: state.hasError ? Colors.red : AppColors.accentColor,
                        width: 3
                    )
                ),
                alignment: Alignment.center,
                child: Text(
                  "+",
                  style: TextStyle(color: AppColors.astratosDarkGreyColor),
                ),
              ),
            )
          ),
        ),
      );
    }
  );

}