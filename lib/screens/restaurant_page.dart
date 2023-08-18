import 'package:flutter/material.dart';
import 'package:project_xanders/model/restaurant.dart';
import 'package:project_xanders/screens/menu_page.dart';
import 'package:project_xanders/services/firestore_service.dart';

class RestaurantPage extends StatefulWidget {
  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  final firestoreService = FirestoreService();
  TextEditingController _searchController = TextEditingController();
  List<Restaurant> allRestaurants = [];
  List<Restaurant> filteredRestaurants = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterRestaurants);
  }

  _filterRestaurants() {
    setState(() {
      String query = _searchController.text.toLowerCase();
      filteredRestaurants = allRestaurants.where((restaurant) {
        return restaurant.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search Restaurants',
            hintStyle: TextStyle(color: Colors.white70),
            prefixIcon: Icon(Icons.search, color: Colors.white),
          ),
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
        ),
      ),
      body: FutureBuilder(
        future: firestoreService.fetchRestaurants(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          allRestaurants = snapshot.data;
          if (filteredRestaurants.isEmpty) {
            filteredRestaurants = allRestaurants;
          }

          return ListView.builder(
            itemCount: filteredRestaurants.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.network(filteredRestaurants[index].image),
                title: Text(filteredRestaurants[index].name),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MenuPage(restaurant: filteredRestaurants[index]),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
