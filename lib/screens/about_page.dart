import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  // Function to launch URL (for calling and emailing)
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About YumYum Food'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Card(
              elevation: 5,
              child: ListTile(
                leading: Icon(Icons.fastfood),
                title: Text('About YumYum Food'),
                subtitle: Text('YumYum Food is a leading food delivery application...'),
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                leading: Icon(Icons.business),
                title: Text('Company: YumYum Enterprises'),
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                leading: Icon(Icons.phone),
                title: Text('Contact Info: 6123 4567'),
                trailing: Icon(Icons.arrow_forward),
                onTap: () => _launchURL('tel:61234567'), // To initiate the call
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                leading: Icon(Icons.email),
                title: Text('Email: feedback@yumyumfood.com'),
                trailing: Icon(Icons.arrow_forward),
                onTap: () => _launchURL('mailto:feedback@yumyumfood.com?subject=Feedback&body=Hello, YumYum Food team,'), // To initiate the email
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Developed by: Xanders Cheong (Flutter Developer)'),
              ),
            ),
            SizedBox(height: 20.0),
            Center(child: Text('© 2023 YumYum Food. All rights reserved.')),
          ],
        ),
      ),
    );
  }
}
