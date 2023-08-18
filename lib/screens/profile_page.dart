import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_xanders/screens/orderhistory_page.dart';

class ProfilePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final User user = _auth.currentUser;
    final String email = user?.email ?? 'No Email Found';

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.blue[700],
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue[100], Colors.blue[400]],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email: $email',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    // Add other profile details here if necessary
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Implement the Edit Profile action here
              },
              child: Text('Edit Profile'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue[700],
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // Implement the Change Password action here
              },
              child: Text('Change Password'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue[700],
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => OrderHistoryPage()),
                );
              },
              child: Text('Order History'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue[700],
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () async {
                await _auth.signOut(); // Sign-out using Firebase authentication
                Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false); 
                // Navigate to login and remove all previous routes
              },
              child: Text('Sign Out'),
              style: ElevatedButton.styleFrom(
                primary: Colors.red[700], // Changed the color to indicate sign-out
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
