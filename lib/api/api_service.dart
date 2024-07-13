import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:jopi_restaurant/model/listrestaurant.dart';
import 'package:jopi_restaurant/model/detailrestaurant.dart';
import 'package:jopi_restaurant/model/searchrestaurant.dart';

class ApiService {

  Future<ListRestaurant> restaurantList() async {
    try {
      final response = await http.get(Uri.parse('https://restaurant-api.dicoding.dev/list'));
      if (response.statusCode == 200) {
        return ListRestaurant.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load list restaurants');
      }
    }on SocketException{
      throw Exception('No Internet Connection');
    } catch (e) {
      rethrow;
    }
  }


  Future<DetailRestaurant> restaurantDetail(String id) async {
    try {
      final response = await http.get(Uri.parse("https://restaurant-api.dicoding.dev/detail/$id"));
      if (response.statusCode == 200) {
        return DetailRestaurant.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load detail restaurants');
      }
    }on SocketException{
      throw Exception('No Internet Connection');
    } catch (e) {
      rethrow;
    }
  }

  Future<SearchRestaurant> searchRestaurant(String query) async {
    try {
      final response = await http.get(Uri.parse("https://restaurant-api.dicoding.dev/search?q=$query"));
      if (response.statusCode == 200) {
        return SearchRestaurant.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load search restaurants');
      }
    }on SocketException{
      throw Exception('No Internet Connection');
    } catch (e) {
      rethrow;
    }
  }
}
