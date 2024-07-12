import 'package:flutter/material.dart';
import 'package:jopi_restaurant/ui/searchpage.dart';
import 'package:provider/provider.dart';
import 'package:jopi_restaurant/provider/restaurant_provider.dart';
import 'package:jopi_restaurant/ui/cardrestaurant.dart';

class MainPage extends StatefulWidget {
  final String username;
  const MainPage({Key? key, required this.username}) : super(key: key);
  static const routeName = '/main';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JoPi Restaurant'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(
                context,
                SearchPage.routeName,
              );
            },
          ),
        ],
      ),
      body: Consumer<RestaurantProvider>(
        builder: (context, provider, child) {
          if (provider.state == ResultState.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.state == ResultState.hasData) {
            return ListView.builder(
              itemCount: provider.listRestaurant.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = provider.listRestaurant.restaurants[index];
                return CardRestaurant(restaurant: restaurant);
              },
            );
          } else if (provider.state == ResultState.noData) {
            return Center(child: Text(provider.message));
          } else if (provider.state == ResultState.error) {
            return Center(child: Text(provider.message));
          } else {
            return Center(child: Text(''));
          }
        },
      ),
    );
  }
}
