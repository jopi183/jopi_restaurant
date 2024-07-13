import 'dart:convert';

class ListRestaurant {
  List<Restaurant> restaurants;

  ListRestaurant({required this.restaurants});

  factory ListRestaurant.fromJson(Map<String, dynamic> json) => ListRestaurant(
    restaurants: List<Restaurant>.from(
        json["restaurants"].map((x) => Restaurant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
  };
}

class Restaurant {
  String id;
  String name;
  String city;
  String description;
  String pictureId;
  double rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.city,
    required this.description,
    required this.pictureId,
    required this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    id: json["id"],
    name: json["name"],
    city: json["city"],
    description: json["description"],
    pictureId: json["pictureId"],
    rating: json["rating"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "city": city,
    "description": description,
    "pictureId": pictureId,
    "rating": rating,
  };
}
