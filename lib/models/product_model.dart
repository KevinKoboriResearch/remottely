import 'package:flutter/foundation.dart';
import 'package:remottely/models/image_model.dart';

class ProductModel {
  final String id;
  final String coin;
  final String companyTitle;
  final String description;
  final ImageModel image;
  final List<ImageModel> images;
  final List<String> interested;
  final String price;
  final String pricePromotion;
  final String rating;
  final String subtitle;
  final String title;

  ProductModel({
    @required this.id,
    @required this.coin,
    @required this.companyTitle,
    @required this.description,
    @required this.image,
    @required this.images,
    @required this.interested,
    @required this.price,
    @required this.pricePromotion,
    @required this.rating,
    @required this.subtitle,
    @required this.title,
  });
}
