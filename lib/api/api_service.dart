import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jopi_restaurant/model/restaurant.dart';
import 'package:flutter/material.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String _list = 'list';
  static const String _detail = 'detail/';
  static const String _search = 'search?q=';
  static const String _review = 'review';

  Future<ListRestaurant> fetchRestaurantList() async {
    final response = await http.get(Uri.parse("$_baseUrl$_list"));
    if (response.statusCode == 200) {
      return ListRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  Future<DetailRestaurant> fetchRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl$_detail$id"));
    if (response.statusCode == 200) {
      return DetailRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant details');
    }
  }

  Future<SearchRestaurant> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl$_search$query"));
    if (response.statusCode == 200) {
      return SearchRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Restaurant not found');
    }
  }
}
