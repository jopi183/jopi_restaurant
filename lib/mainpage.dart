import 'package:flutter/material.dart';
import 'package:jopi_restaurant/model/restaurant.dart';
import 'package:jopi_restaurant/detailpage.dart';
class MainPage extends StatelessWidget{
  final String username;
  const MainPage({Key?key,required this.username}):super(key: key);
  static const routeName = '/main';
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar (
          title: Text('JoPi Restaurant'),
          actions:[
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: (){},
            ),
          ]
      ),
      body: FutureBuilder<String> (
        future:
          DefaultAssetBundle.of(context).loadString('assets/local_restaurant.json'),
        builder: (context,snapshot){
          final List<Restaurant> restaurants = parseRestaurant(snapshot.data);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Mau makan apa hari ini, $username ?',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: restaurants.length,
                  itemBuilder: (context, index) {
                    return _buildRestaurantItem(context, restaurants[index]);
                  },
                ),
              ),
            ],
          );
        },
          ),
    );

  }
}
Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant){
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(
        context,
        RestaurantDetailPage.routeName,
        arguments: restaurant,
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
              restaurant.pictureId,
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
}

