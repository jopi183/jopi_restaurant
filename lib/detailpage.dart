import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jopi_restaurant/provider/restaurant_provider.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final String id;

  RestaurantDetailPage({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Detail'),
      ),
      body: Consumer<RestaurantProvider>(
        builder: (context, provider, child) {
          provider.fetchRestaurantDetail(id);
          if (provider.state == ResultState.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.state == ResultState.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Text(provider.detailRestaurant.restaurant.name),
                  // Add more widgets to display the restaurant details
                ],
              ),
            );
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
