import 'package:flutter/foundation.dart';
import 'package:remottely/models/image_model.dart';

class ProductModel {
  final String id;
  final String coin;
  final String companyTitle;
  final String description;
  // final bool disabled;
  final List<ImageModel> images;
  final List<String> interested;
  final double price;
  final double promotion;
  // final double quantity;
  final double rating;
  final String subtitle;
  final String title;
  // final String type;//product or service

  ProductModel({
     this.id,
     this.coin,
     this.companyTitle,
     this.description,
    //  this.disabled,
     this.images,
     this.interested,
     this.price,
     this.promotion,
    //  this.quantity,
     this.rating,
     this.subtitle,
     this.title,
    //  this.type,
  });
}
