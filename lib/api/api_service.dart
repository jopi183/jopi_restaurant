import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:jopi_restaurant/model/restaurant.dart';
import 'package:flutter/material.dart';

Class ApiService{
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String _list = 'list';
  static const String _detail = 'detail/:id';
  static const String _search = 'search?q=<query>';
  static const String _review = 'review';

  Future<Restaurant> headRestaurant() async{
    final response = await http.get(Uri.parse("${_baseUrl} + ${_list}"));
    if (response.statusCode == 200){
      return Restaurant.fromJson(json.decode(response.body));
    }else{
      throw Exception('Failed to load restaurants');
    }
  }

Future<Restaurant> headRestaurant() async{
  final response = await http.get(Uri.parse("${_baseUrl} + ${_list}"));
  if (response.statusCode == 200){
    return Restaurant.fromJson(json.decode(response.body));
  }else{
    throw Exception('Failed to load restaurants');
  }
}


Future <Restaurant> searchRestaurant(String query) async{
    final response = await http.get(Uri.parse("${_baseUrl} + ${_search} + $query"));
    if (response.statusCode == 200){
      return Restaurant.fromJson(json.decode(response.body));
    }else{
      throw Exception('Restaurant not Found');
    }
  }
}