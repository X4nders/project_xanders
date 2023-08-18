import 'package:flutter/material.dart';
import 'package:project_xanders/model/restaurant.dart';
import 'package:project_xanders/screens/cart_page.dart';

class MenuPage extends StatefulWidget {
  final Restaurant restaurant;

  MenuPage({@required this.restaurant});

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.restaurant.name)),
      body: ListView.builder(
        itemCount: widget.restaurant.menu.length,
        itemBuilder: (context, index) {
          MenuItem menuItem = widget.restaurant.menu[index];
          return ListTile(
            title: Text(menuItem.name),
            subtitle: Text(menuItem.description),
            trailing: Text('\$${menuItem.price.toString()}'),
            onTap: () {
              // Adding menu item to the cart when tapped
              CartService.addItem(menuItem);
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('${menuItem.name} added to cart!'),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_cart),
        onPressed: _goToCart,
      ),
    );
  }

  void _goToCart() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CartPage(),
      ),
    );
  }
}
