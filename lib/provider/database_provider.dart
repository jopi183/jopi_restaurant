import 'package:flutter/foundation.dart';
import 'package:jopi_restaurant/model/listrestaurant.dart';
import 'package:jopi_restaurant/model/db/database_helper.dart';
import 'package:jopi_restaurant/utils/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getBookmarks();
  }

  late ResultState _state;

  ResultState get state => _state;

  String _message = '';

  String get message => _message;

  List<Restaurant> _bookmarks = [];

  List<Restaurant> get bookmarks => _bookmarks;

  void _getBookmarks() async {
    _bookmarks = await databaseHelper.getBookmarks();
    if (_bookmarks.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addBookmark(Restaurant restaurant) async {
    try {
      await databaseHelper.insertBookmark(restaurant);
      _getBookmarks();
    } catch (e) {
      print('Failed to add restaurant with ID: ${restaurant.id} to bookmarks.');
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isBookmarked(Restaurant restaurant) async {
    final bookmarkedRestaurant = await databaseHelper.getBookmarkById(restaurant.id);
    return bookmarkedRestaurant != null;
  }

  void removeBookmark(Restaurant restaurant) async {
    try {
      await databaseHelper.removeBookmark(restaurant.id);
      _getBookmarks();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
