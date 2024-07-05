import 'package:flutter/material.dart';
import 'package:jopi_restaurant/restaurant.dart';

class RestaurantDetailPage extends StatelessWidget{
  static const routeName = '/detail';
  final Restaurant restaurant;
  
  const RestaurantDetailPage({Key?key, required this.restaurant}):super(key: key);
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: restaurant.id,
              child: Stack(
                children :[
                  Image.network(restaurant.pictureId),
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
                  Text(restaurant.description),
                  Divider(color: Colors.grey),
                  Text(
                    restaurant.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  Text('ID : ${restaurant.id}'),
                  SizedBox(height: 10),
                  Text('City : ${restaurant.city}'),
                  const Divider(color: Colors.grey),
                  Text(
                    'Foods: ',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  ...restaurant.menu.foods.map((food) => Text(food.name)).toList(),
                  const Divider(color: Colors.grey),
                  Text(
                    'Drinks',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  ...restaurant.menu.drinks.map((drink) => Text(drink.name)).toList(),
                ],
              ),
            )
          ],
        ),
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