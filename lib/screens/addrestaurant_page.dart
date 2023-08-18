import 'package:flutter/material.dart';
import 'package:project_xanders/model/restaurant.dart';
import 'package:project_xanders/services/firestore_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddRestaurantPage extends StatefulWidget {
  @override
  _AddRestaurantPageState createState() => _AddRestaurantPageState();
}

class _AddRestaurantPageState extends State<AddRestaurantPage> {
  final formKey = GlobalKey<FormState>();
  String name;
  String description;
  String image;
  File _imageFile;
  List<MenuItem> menuItems = [];

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adding Restaurant')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Restaurant Name'),
                  validator: (val) => val.isEmpty ? 'Enter Restaurant Name' : null,
                  onSaved: (val) => name = val,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Restaurant Description'),
                  validator: (val) => val.isEmpty ? 'Enter Restaurant Description' : null,
                  onSaved: (val) => description = val,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Restaurant Image URL'),
                  validator: (val) => val.length == 0 ? 'Enter Image URL' : null,
                  onSaved: (val) => image = val,
                ),
                if (_imageFile != null)
                  Image.file(_imageFile, height: 150, width: 150),
                SizedBox(height: 10), // adds some spacing between elements
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Pick Image'),
                ),
                ..._buildMenuItems(),

                ElevatedButton(
                  onPressed: addMenuItem,
                  child: Text('Add Menu Item'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submit,
                  child: Text('Add Restaurant'),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildMenuItems() {
    List<Widget> itemFields = [];
    for (int i = 0; i < menuItems.length; i++) {
      itemFields.add(Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Menu Item Name'),
              validator: (val) => val.isEmpty ? 'Enter Menu Item Name' : null,
              onSaved: (val) => menuItems[i].name = val,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Menu Item Description'),
              validator: (val) => val.isEmpty ? 'Enter Menu Item Description' : null,
              onSaved: (val) => menuItems[i].description = val,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Menu Item Price'),
              validator: (val) => val.isEmpty ? 'Enter Menu Item Price' : null,
              onSaved: (val) => menuItems[i].price = double.parse(val),
            ),
          ],
        ),
      ));
    }
    return itemFields;
  }

  void addMenuItem() {
    setState(() {
      menuItems.add(MenuItem());
    });
  }

  void _submit() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      Restaurant restaurant = Restaurant(
        name: name,
        description: description,
        image: image,
        menu: menuItems,
      );
      try {
        await FirestoreService().addRestaurant(restaurant);
        Fluttertoast.showToast(
          msg: 'Restaurant added successfully',
          gravity: ToastGravity.TOP,
        );
        Navigator.of(context).pop();
      } catch (error) {
        Fluttertoast.showToast(
          msg: 'Error adding restaurant: $error',
          gravity: ToastGravity.TOP,
        );
      }
    }
  }
}
