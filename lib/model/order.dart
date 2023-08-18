import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_xanders/model/restaurant.dart';

class Order {
  final String id;
  final double totalPrice;
  final DateTime timestamp;
  final List<MenuItem> items;

  Order({
    this.id,
    this.totalPrice,
    this.timestamp,
    this.items,
  });

  factory Order.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    return Order(
      id: doc.id,
      totalPrice: data['totalAmount'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      items: (data['items'] as List)
          .map((item) => MenuItem.fromMap(item))
          .toList(),
    );
  }

}
 