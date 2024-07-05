import 'dart:convert';

Restaurants restaurantsFromJson(String str) => Restaurants.fromJson(json.decode(str));
String restaurantsToJson(Restaurants data) => json.encode(data.toJson());

class Restaurants {
  List<Restaurant> restaurants;
  Restaurants({
    required this.restaurants,
  });

  factory Restaurants.fromJson(Map<String, dynamic> json) => Restaurants(
    restaurants: List<Restaurant>.from(
        json["restaurants"].map((x) => Restaurant.fromJson(x))),
  );
  Map<String, dynamic> toJson() => {
    "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
  };
}

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final Menus menu;
  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menu,
  });

  factory Restaurant.fromJson(Map<String, dynamic> restaurant) => Restaurant(
    id: restaurant['id'],
    name: restaurant['name'],
    description: restaurant['description'],
    pictureId: restaurant['pictureId'],
    city: restaurant['city'],
    rating: restaurant['rating'].toDouble(),
    menu: Menus.fromJson(restaurant["menus"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "pictureId": pictureId,
    "city": city,
    "rating": rating,
    "menus": menu.toJson(),
  };
}

class Menus {
  List<Drink> foods;
  List<Drink> drinks;
  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
    foods: List<Drink>.from(json["foods"].map((x) => Drink.fromJson(x))),
    drinks: List<Drink>.from(json["drinks"].map((x) => Drink.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
    "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
  };
}

class Drink {
  String name;
  Drink({
    required this.name,
  });

  factory Drink.fromJson(Map<String, dynamic> json) => Drink(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}

List<Restaurant> parseRestaurant(String? json) {
  if (json == null) {
    return [];
  }
  final List parsed = jsonDecode(json)['restaurants'] as List;
  return parsed.map((json) => Restaurant.fromJson(json as Map<String, dynamic>)).toList();
}
