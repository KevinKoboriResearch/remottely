import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:remottely/models/image_model.dart';

class ProductModel {
  final String id;
  final String coin;
  final String categoryTitle;
  final String companyTitle;
  final String description;
  final bool enabled;
  // final List<ImageModel> images;
  final List images;
  // final List<String> interested;
  final List interested;
  final double price;
  final double promotion;
  final List rating;
  final List sizes;
  final String subtitle;
  final String title;
  final String type; //product or service

  ProductModel({
    this.id,
    this.coin,
    this.categoryTitle,
    this.companyTitle,
    this.description,
    this.enabled,
    this.images,
    this.interested,
    this.price,
    this.promotion,
    this.rating,
    this.sizes,
    this.subtitle,
    this.title,
    this.type,
  });
}
