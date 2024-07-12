import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jopi_restaurant/provider/restaurant_provider.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';

  final String id;

  RestaurantDetailPage({required this.id});

  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<RestaurantProvider>(context, listen: false)
        .fetchRestaurantDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Detail'),
      ),
      body: Consumer<RestaurantProvider>(
        builder: (context, provider, child) {
          if (provider.state == ResultState.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.state == ResultState.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Hero(
                    tag: provider.detailRestaurant.restaurant.id,
                    child: Stack(
                      children :[
                        Image.network('https://restaurant-api.dicoding.dev/images/small/${provider.detailRestaurant.restaurant.pictureId}'),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: const FavoriteButton(),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(provider.detailRestaurant.restaurant.description),
                        Divider(color: Colors.grey),
                        Text(
                          provider.detailRestaurant.restaurant.name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const Divider(color: Colors.grey),
                        Text('ID : ${provider.detailRestaurant.restaurant.id}'),
                        SizedBox(height: 10),
                        Text('City : ${provider.detailRestaurant.restaurant.city}'),
                        const Divider(color: Colors.grey),
                        Text(
                          'Foods: ',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        ...provider.detailRestaurant.restaurant.menus.foods.map((food) => Text(food.name)).toList(),
                        const Divider(color: Colors.grey),
                        Text(
                          'Drinks',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        ...provider.detailRestaurant.restaurant.menus.drinks.map((drink) => Text(drink.name)).toList(),
                      ],
                    ),
                  )
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
class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
    );
  }
}