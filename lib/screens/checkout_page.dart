import 'package:flutter/material.dart';
import 'package:project_xanders/model/restaurant.dart';
import 'package:project_xanders/services/firestore_service.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {

  double calculateTotal() {
    double total = 0.0;
    for (var item in Cart.items) {
      total += item.price;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = calculateTotal();

    return Scaffold(
      appBar: AppBar(title: Text('Checkout (${Cart.items.length} items)'),),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: Cart.items.length,
              itemBuilder: (context, index) {
                MenuItem item = Cart.items[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(item.description),
                  trailing: Text('\$${item.price.toStringAsFixed(2)}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text('\$${totalPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              child: Text('Complete Checkout'),
              onPressed: () async {
                    Map<String, dynamic> orderData = {
                  'totalAmount': totalPrice,
                  'items': Cart.items.map((item) => {
                    'name': item.name,
                    'description': item.description,
                    'price': item.price,
                  }).toList(),
                  'timestamp': DateTime.now(),
                };
                try {
                  await FirestoreService().addOrder(orderData);
                  // Clear the cart after successful order placement
                  Cart.items.clear();
                  Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('Order placed successfully!')),
                  );
                  Navigator.of(context).pop();  // Return to the previous screen or any other navigation logic
                } catch (error) {
                  print("Error placing order: $error");
                  Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('Error placing order')),
                  );
                }
              },
            )
          ),
        ],
      ),
    );
  }
}
