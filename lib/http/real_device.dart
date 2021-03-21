import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:remottely/utils/constants.dart';

class Device with ChangeNotifier {
  final String id;
  final String property;
  final String title;
  final String description;
  final String location;
  final String triggerUrl;
  final String imageUrl;
  final String userId;
  final String userEmail;
  final String quantity;
  bool isFavorite;

  Device({
    this.id,
    @required this.userId,
    @required this.userEmail,
    @required this.property,
    @required this.title,
    this.description,
    this.location,
    this.triggerUrl,
    this.imageUrl,
    this.quantity,
    this.isFavorite = false,
  });
  void _toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite(String token, String userId) async {
    _toggleFavorite();

    try {
      final url =
          '${AppURLs.DEVICE_API_URL}/userDevices/$userId/$id.json?auth=$token';
      final response = await http.patch(
        url,
        body: json.encode({'isFavorite': isFavorite}),
      );

      if (response.statusCode >= 400) {
        _toggleFavorite();
      }
    } catch (error) {
      _toggleFavorite();
    }
  }
}
