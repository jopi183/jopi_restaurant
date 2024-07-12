import 'package:flutter/cupertino.dart';
import 'package:jopi_restaurant/preferences/preferences_helper.dart';
import 'package:jopi_restaurant/style/styles.dart';
class PreferencesProvider extends ChangeNotifier{
  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  bool _isDailyNewsActive = false;
  bool get isDailyNewsActive => _isDailyNewsActive;

  PreferencesHelper preferencesHelper;
  PreferencesProvider({required this.preferencesHelper}){
    _getTheme();
    _getDailyNewsPreferences();
  }

  get themeData => _isDarkTheme ? darkTheme : lightTheme;

  void _getTheme() async{
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }

  void _getDailyNewsPreferences() async{
    _isDailyNewsActive = await preferencesHelper.isDailyNewsActive;
    notifyListeners();
  }

  void enableDarkTheme(bool value){
    preferencesHelper.setDarkTheme(value);
    _getTheme();
  }

  void enbableDailyNews(bool value){
    preferencesHelper.setDailyNews(value);
    _getDailyNewsPreferences();
  }
}