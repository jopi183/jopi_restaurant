import 'package:flutter/material.dart';
import 'package:jopi_restaurant/dashboardpage.dart';
import 'package:jopi_restaurant/loginpage.dart';
import 'package:jopi_restaurant/mainpage.dart';
import 'package:jopi_restaurant/detailpage.dart';
import 'package:jopi_restaurant/model/restaurant.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key?key}): super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
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
          restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant,
        ),
      },
    );
  }
}
