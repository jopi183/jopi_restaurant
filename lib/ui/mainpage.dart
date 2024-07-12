import 'package:flutter/material.dart';
import 'package:jopi_restaurant/ui/searchpage.dart';
import 'package:provider/provider.dart';
import 'package:jopi_restaurant/provider/restaurant_provider.dart';
import 'package:jopi_restaurant/ui/cardrestaurant.dart';
import 'package:jopi_restaurant/ui/setting_page.dart ';
import 'package:jopi_restaurant/ui/favorite_page.dart';


class MainPage extends StatefulWidget {
  final String username;
  const MainPage({Key? key, required this.username}) : super(key: key);
  static const routeName = '/main';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    RestaurantPage(),
    FavoritePage(),
    SettingPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Restaurant',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
class RestaurantPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(
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
    );
  }
}