import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jopi_restaurant/provider/restaurant_provider.dart';
import 'package:jopi_restaurant/ui/cardrestaurant.dart';
import 'package:jopi_restaurant/model/listrestaurant.dart';
import 'package:jopi_restaurant/model/searchrestaurant.dart';
import 'package:jopi_restaurant/detailpage.dart';

class SearchPage extends StatelessWidget {
  static const routeName = '/search_restaurant';

  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search Restaurants...',
            border: InputBorder.none,
          ),
          onSubmitted: (query) {
            Provider.of<RestaurantProvider>(context, listen: false)
                .searchRestaurants(query);
          },
        ),
      ),
      body: Consumer<RestaurantProvider>(
        builder: (context, provider, child) {
          if (provider.state == ResultState.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.state == ResultState.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              itemCount: provider.searchRestaurant.restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = provider.searchRestaurant.restaurants[index];
                String imageURL = 'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}';
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RestaurantDetailPage.routeName,
                      arguments: restaurant.id,
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                          child: Image.network(
                            imageURL,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                            errorBuilder: (ctx, error, _) => const Icon(Icons.error),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  restaurant.name,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Kota: ' + restaurant.city,
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                      size: 20,
                                    ),
                                    Text(
                                      restaurant.rating.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
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

  Widget _buildList(ListRestaurant listRestaurant) {
    return ListView.builder(
      itemCount: listRestaurant.restaurants.length,
      itemBuilder: (context, index) {
        var restaurant = listRestaurant.restaurants[index];
        return CardRestaurant(
            restaurant: restaurant);
      },
    );
  }

  Widget _buildSearchResults(SearchRestaurant? searchRestaurant) {
    if (searchRestaurant != null) {
      return ListView.builder(
        itemCount: searchRestaurant.restaurants.length,
        itemBuilder: (context, index) {
          var restaurant = searchRestaurant.restaurants[index];
          return ListTile(
            title: Text(restaurant.name),
            subtitle: Text(restaurant.city),
            onTap: () {},
          );
        },
      );
    } else {
      return Center(child: Text('No search results found'));
    }
  }
}