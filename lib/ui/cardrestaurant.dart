import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jopi_restaurant/ui/detailpage.dart';
import 'package:jopi_restaurant/model/listrestaurant.dart';
import 'package:jopi_restaurant/provider/database_provider.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  const CardRestaurant({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    String imageURL = 'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}';
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isBookmarked(restaurant),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
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
                      offset: Offset(0, 3),
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
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                      size: 20,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      restaurant.rating.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                FavoriteButton(restaurant: restaurant),
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
      },
    );
  }
}

class FavoriteButton extends StatefulWidget {
  final Restaurant restaurant;

  const FavoriteButton({required this.restaurant, Key? key}) : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  void _checkIfFavorite() async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    bool favoriteStatus = await provider.isBookmarked(widget.restaurant);
    setState(() {
      isFavorite = favoriteStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
          ),
          onPressed: () {
            if (isFavorite) {
              provider.removeBookmark(widget.restaurant);
            } else {
              provider.addBookmark(widget.restaurant);
            }
            setState(() {
              isFavorite = !isFavorite;
            });
          },
        );
      },
    );
  }
}
