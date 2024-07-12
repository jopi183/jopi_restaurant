import 'dart:convert';
import 'package:jopi_restaurant/model/restaurant.dart';
class DetailRestaurant {
  bool error;
  String message;
  Restaurant restaurant;

  DetailRestaurant({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory DetailRestaurant.fromRawJson(String str) => DetailRestaurant.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DetailRestaurant.fromJson(Map<String, dynamic> json) => DetailRestaurant(
    error: json["error"],
    message: json["message"],
    restaurant: Restaurant.fromJson(json["restaurant"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "restaurant": restaurant.toJson(),
  };
}

