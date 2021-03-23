import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:ui';
import 'dart:io';
import 'package:remottely/utils/my_flutter_app_icons_2.dart';
import 'package:remottely/functions/product_functions.dart';

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

class ProductGridItem extends StatefulWidget {
  final snapshotProduct;
  ProductGridItem(this.snapshotProduct);
  @override
  _ProductGridItemState createState() => _ProductGridItemState();
}

class _ProductGridItemState extends State<ProductGridItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6.0),
      child: Column(
        children: [
          Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Hero(
              tag: widget.snapshotProduct.id,
              child: CachedNetworkImage(
                imageUrl: widget.snapshotProduct['images'][0]['url'],
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    Center(child: Icon(Icons.error)),
              ),
            ),
          ),
          Spacer(),
          SizedBox(
            height: 4,
          ),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 24.0),
                child: LayoutBuilder(
                  builder: (context, size) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.snapshotProduct['title'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.snapshotProduct['subtitle'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Row(
                          children: [
                            widget.snapshotProduct['price'] != 0.00
                                ? Text(
                                    ProductFunctions().doubleValueToCurrency(widget
                                            .snapshotProduct[
                                        'price']), //acima de tanto, remover os centavos?
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[500],
                                      decoration:
                                          widget.snapshotProduct['promotion'] !=
                                                  0.00
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
                                    ),
                                  )
                                : Container(width:0.0, height: 0.0),
                            widget.snapshotProduct['promotion'] != 0.00
                                ? Text(
                                    ProductFunctions().doubleValueToCurrency(widget
                                            .snapshotProduct[
                                        'promotion']), //'/${currencyPromotion}', //acima de tanto, remover os centavos?
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.red[800],
                                    ),
                                  )
                                : Container(width:0.0, height: 0.0),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
              Positioned(
                right: 0,
                child: Icon(
                  Icons.bookmark_border,
                  size: 26,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
