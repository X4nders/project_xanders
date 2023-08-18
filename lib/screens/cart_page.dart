import 'package:flutter/material.dart';
import 'package:project_xanders/model/restaurant.dart';
import 'package:project_xanders/screens/checkout_page.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: Cart.items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(Cart.items[index].name),
                  subtitle: Text(Cart.items[index].description),
                  trailing: Text('\$${Cart.items[index].price.toString()}'),
                );
              },
            ),
          ),
          // Display the total price here
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
            child: Text(
              'Total: \$${calculateTotal().toStringAsFixed(2)}',  // Fixed to 2 decimal places
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _proceedToCheckout,
              child: Text('Proceed to Checkout'),
            ),
          ),
        ],
      ),
    );
  }

  double calculateTotal() {
    double total = 0.0;
    for (var item in Cart.items) {
      total += item.price;
    }
    return total;
  }

  void _proceedToCheckout() {

  // Check if cart is empty
  if (Cart.items.isEmpty) {
    print("The cart is empty. Add items before checking out.");
    return;
  }

  // Navigate to the CheckoutPage and pass the total amount
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => CheckoutPage(),
    ),
  );
}

  bool processPayment(double amount) {
    print("Processing payment of \$${amount.toStringAsFixed(2)}...");
    return true;
  }
}