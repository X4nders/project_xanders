import 'package:flutter/material.dart';
import 'package:project_xanders/screens/about_page.dart';
import 'package:project_xanders/screens/profile_page.dart';
import 'package:project_xanders/screens/restaurant_page.dart';
import 'package:project_xanders/screens/addrestaurant_page.dart';
import 'package:project_xanders/screens/cart_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "WELCOME TO",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w300,
                color: Colors.white60,
              ),
            ),
            Text(
              "YumYum Food",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 50),
            _buildButton(
              label: "Restaurants",
              icon: Icons.restaurant,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => RestaurantPage())
                );
              }
            ),
            SizedBox(height: 20), // Adds a little spacing between the buttons
            _buildButton(
              label: "Add Restaurant",
              icon: Icons.add,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddRestaurantPage())
                );
              }
            ),
          ],
        ),
      ),
      RestaurantPage(),
      CartPage(),
      ProfilePage(),
      AboutPage(),

    ];

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue[300], Colors.blue[700]],
          ),
        ),
        child: _pages[_currentIndex],  // Use the _pages list here
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white.withOpacity(0.8),
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.blue[800]),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant, color: Colors.blue[800]),
            label: 'Restaurants',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.blue[800]),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.blue[800]),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info, color: Colors.blue[800]),
            label: 'About',
          ),

        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildButton({ IconData icon, String label, Function onTap}) {
    return ElevatedButton.icon(
      onPressed: onTap as void Function(),
      icon: Icon(icon, size: 40, color: Colors.blue[800]),
      label: Text(label, style: TextStyle(fontSize: 20, color: Colors.blue[800])),
      style: ElevatedButton.styleFrom(
        primary: Colors.white.withOpacity(0.8),
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 5,
      ),
    );
  }

}
