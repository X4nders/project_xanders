import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_xanders/model/restaurant.dart';
import 'package:project_xanders/model/order.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addRestaurant(Restaurant restaurant) async {
    DocumentReference restaurantRef = await _firestore.collection('restaurants').add({
      'name': restaurant.name,
      'description': restaurant.description,
      'image': restaurant.image,
    });

    if (restaurant.menu != null) {
      for (var menuItem in restaurant.menu) {
        restaurantRef.collection('menu').add({
          'name': menuItem.name,
          'description': menuItem.description,
          'price': menuItem.price,
        });
      }
    }
  }

  Future<List<Restaurant>> fetchRestaurants() async {
    QuerySnapshot restaurantSnapshot = await _firestore.collection('restaurants').get();

    List<Restaurant> restaurants = [];

    for (var restaurantDoc in restaurantSnapshot.docs) {
      List<MenuItem> menu = [];
      var menuSnapshot = await restaurantDoc.reference.collection('menu').get();

      for (var menuItemDoc in menuSnapshot.docs) {
        menu.add(MenuItem(
          name: menuItemDoc['name'],
          description: menuItemDoc['description'],
          price: menuItemDoc['price'].toDouble(),
        ));
      }

      restaurants.add(Restaurant(
        name: restaurantDoc['name'],
        description: restaurantDoc['description'],
        image: restaurantDoc['image'],
        menu: menu,
      ));
    }

    return restaurants;

  }

  Future<void> addOrder(Map<String, dynamic> orderData) async {
    await _firestore.collection('orders').add(orderData);
  }

  Future<List<Order>> fetchOrderHistory() async {
  QuerySnapshot orderSnapshot = await _firestore.collection('orders').get();

  List<Order> orders = [];

  for (var orderDoc in orderSnapshot.docs) {
    orders.add(Order.fromFirestore(orderDoc));
    
  }

  return orders;
}

}
