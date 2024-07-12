import 'package:flutter/material.dart';
import 'package:jopi_restaurant/ui/cardrestaurant.dart';
import 'package:provider/provider.dart';
import 'package:jopi_restaurant/utils/result_state.dart';
import 'package:jopi_restaurant/provider/database_provider.dart';

class FavoritePage extends StatelessWidget {
  static const routeName = '/favorite';
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Restaurants'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<DatabaseProvider>(
          builder: (context, provider, _) {
            if (provider.state == ResultState.loading) {
              return Center(child: CircularProgressIndicator());
            } else if (provider.state == ResultState.hasData) {
              return ListView.builder(
                itemCount: provider.bookmarks.length,
                itemBuilder: (context, index) {
                  return CardRestaurant(restaurant: provider.bookmarks[index]);
                },
              );
            } else {
              return Center(
                child: Text(provider.message ?? 'No favorite restaurants found'),
              );
            }
          },
        ),
      ),
    );
  }
}
