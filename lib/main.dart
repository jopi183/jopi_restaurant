import 'package:flutter/material.dart';
import 'package:jopi_restaurant/preferences/preferences_helper.dart';
import 'package:jopi_restaurant/provider/preferences_provider.dart';
import 'package:jopi_restaurant/ui/dashboardpage.dart';
import 'package:jopi_restaurant/ui/loginpage.dart';
import 'package:jopi_restaurant/ui/mainpage.dart';
import 'package:jopi_restaurant/ui/detailpage.dart';
import 'package:jopi_restaurant/ui/setting_page.dart';
import 'package:jopi_restaurant/ui/favorite_page.dart';
import 'package:jopi_restaurant/provider/restaurant_provider.dart';
import 'package:jopi_restaurant/api/api_service.dart';
import 'package:provider/provider.dart';
import 'package:jopi_restaurant/ui/searchpage.dart';
import 'package:jopi_restaurant/style/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jopi_restaurant/provider/database_provider.dart';
import 'package:jopi_restaurant/model/db/database_helper.dart';
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider(apiService: ApiService()),
        ),
      ],
      child: MyApp(),
    ),
  );
}




class MyApp extends StatelessWidget {
  const MyApp({Key?key}): super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => SchedulingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences:  SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
      ],
    child: Consumer<PreferencesProvider>(
      builder: (context,provider,child){
        return MaterialApp(
          title: 'JoPi Restaurants',
          theme: provider.themeData,
          builder: (context,child){
            return Theme(
              data: ThemeData(
                brightness :
                  provider.isDarkTheme? Brightness.dark : Brightness.light,
              ),
              child: Material(
                child: child,
              ),
            );
          },
          initialRoute: DashboardPage.routeName,
          routes: {
            DashboardPage.routeName: (context)=>const DashboardPage(),
            LoginPage.routeName: (context)=>  LoginPage(),
            SearchPage.routeName: (context)=>const SearchPage(),
            MainPage.routeName: (context)=> MainPage(
                username: ModalRoute.of(context)?.settings.arguments as String),
            RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
                id: (ModalRoute.of(context)?.settings.arguments as String)
            ),
            SettingPage.routeName: (context)=> SettingPage(),
            FavoritePage.routeName: (context) => FavoritePage(),
          },
        );

      }
    ),
    );
  }
}
