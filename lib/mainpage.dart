import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jopi_restaurant/provider/restaurant_provider.dart';
import 'package:jopi_restaurant/cardrestaurant.dart';

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
              showSearch(context: context, delegate: RestaurantSearchDelegate());
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

class RestaurantSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, provider, child) {
        provider.searchRestaurants(query);
        if (provider.state == ResultState.loading) {
          return Center(child: CircularProgressIndicator());
        } else if (provider.state == ResultState.hasData) {
          return ListView.builder(
            itemCount: provider.searchRestaurant.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = provider.searchRestaurant.restaurants[index];
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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
