import 'package:flutter/material.dart';
import 'package:jopi_restaurant/dashboardpage.dart';
import 'package:jopi_restaurant/loginpage.dart';
import 'package:jopi_restaurant/mainpage.dart';
import 'package:jopi_restaurant/detailpage.dart';
import 'package:jopi_restaurant/model/restaurant.dart';
import 'package:jopi_restaurant/provider/restaurant_provider.dart';
import 'package:jopi_restaurant/api/api_service.dart';
import 'package:provider/provider.dart';
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
    return MaterialApp(
      title: 'JoPi Restaurants',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: DashboardPage.routeName,
      routes: {
        DashboardPage.routeName: (context)=>const DashboardPage(),
        LoginPage.routeName: (context)=>  LoginPage(),
        MainPage.routeName: (context)=> MainPage(
            username: ModalRoute.of(context)?.settings.arguments as String),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
          id: (ModalRoute.of(context)?.settings.arguments as String)
        ),
      },
    );
  }
}
