import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:ui';
import 'dart:io';
import 'package:remottely/utils/my_flutter_app_icons_2.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:remottely/models/image_model.dart';
import 'package:remottely/models/product_model.dart';
import 'package:remottely/data/firestore/products_collection.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:remottely/utils/constants.dart';
import 'package:remottely/utils/via_cep_service.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/exceptions/http_exception.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:remottely/functions/flushbar.dart';
import 'package:flutter/services.dart';
import 'package:remottely/functions/streams.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:remottely/validators/product_validators.dart';

class ProductFunctions {
  String doubleValueToCurrency(double doubleValue) {
    return NumberFormat.currency(
            customPattern: 'R\$ ###,###.##', locale: 'nl_NL')
        .format(doubleValue);
  }
}
