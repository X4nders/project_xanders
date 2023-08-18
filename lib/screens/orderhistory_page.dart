import 'package:flutter/material.dart';
import 'package:project_xanders/services/firestore_service.dart';
import 'package:project_xanders/model/order.dart';

class OrderHistoryPage extends StatefulWidget {
  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  final firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order History"),
      ),
      body: FutureBuilder(
        future: firestoreService.fetchOrderHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          List<Order> orders = snapshot.data;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              Order order = orders[index];
              return ListTile(
                title: Text('Order ID: ${order.id}'),
                subtitle: Text('Total Price: \$${order.totalPrice}'),
                trailing: Text('${order.timestamp}'),
                onTap: () {
                  // Here you can navigate to a detailed view of the order if needed
                },
              );
            },
          );
        },
      ),
    );
  }
} 
