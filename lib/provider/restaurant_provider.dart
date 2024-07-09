import 'package:flutter/cupertino.dart';
import 'package:jopi_restaurant/api/api_service.dart';
import 'package:jopi_restaurant/model/listrestaurant.dart';
import 'package:jopi_restaurant/model/detailrestaurant.dart';
import 'package:jopi_restaurant/model/searchrestaurant.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchAllRestaurants();
    _searchRestaurant = SearchRestaurant(error: false, founded: 0, restaurants: []); // Berikan nilai awal pada _searchRestaurant
  }

  late ListRestaurant _listRestaurant;
  late SearchRestaurant _searchRestaurant; // Berikan nilai awal pada _searchRestaurant
  late DetailRestaurant _detailRestaurant;
  String _message = '';
  ResultState _state = ResultState.loading;

  String get message => _message;
  ListRestaurant get listRestaurant => _listRestaurant;
  SearchRestaurant get searchRestaurant => _searchRestaurant;
  DetailRestaurant get detailRestaurant => _detailRestaurant;
  ResultState get state => _state;

  Future<void> _fetchAllRestaurants() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantList = await apiService.restaurantList();
      if (restaurantList.restaurants.isEmpty) {
        _state = ResultState.noData;
        _message = 'No data available';
      } else {
        _state = ResultState.hasData;
        _listRestaurant = restaurantList;
      }
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Failed to load restaurants';
      notifyListeners();
    }
  }

  Future<void> fetchRestaurantDetail(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantDetail = await apiService.restaurantDetail(id);
      _state = ResultState.hasData;
      _detailRestaurant = restaurantDetail;
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Failed to load detail restaurant ';
      notifyListeners();
    }
  }

  Future<void> searchRestaurants(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final searchResult = await apiService.searchRestaurant(query);
      _searchRestaurant = searchResult;
      if (_searchRestaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        _message = 'No restaurants found';
      } else {
        _state = ResultState.hasData;
      }
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Failed to search restaurants';
      notifyListeners();
    }
  }
}
