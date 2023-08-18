import 'package:flutter/material.dart';
import 'dart:io'; 

class Restaurant {
  String uid;
  String name;
  String description;
  String image;
  File imageFile;
  List<MenuItem> menu;

  Restaurant({
    this.uid,
    this.name,
    this.description,
    this.image,
    this.imageFile,
    this.menu = const [],
  });

  Restaurant.fromMap(Map<String, dynamic> data) {
    uid = data['uid'];
    name = data['name'];
    description = data['description'];
    image = data['image'];
    menu = data['menu'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'description': description,
      'image': image,
      'menu': menu
    };
  }
}

class MenuItem {
  String uid;
  String name;
  String description;
  double price;
  int _quantity;

  MenuItem({
    this.uid,
    this.name,
    this.description,
    this.price,
    int quantity = 0,
  }) : _quantity = quantity;

 // Getter and Setter for quantity
  int get quantity => _quantity;

  set quantity(int newQuantity) {
    _quantity = newQuantity;
  }

  MenuItem.fromMap(Map<String, dynamic> data) {
    uid = data['uid'];
    name = data['name'];
    description = data['description'];
    price = data['price'];
  }

    Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'description': description,
      'price': price
    };
  }
}

class Cart {
  static List<MenuItem> items = [];
  static ValueNotifier<List<MenuItem>> itemsNotifier = ValueNotifier<List<MenuItem>>(items);
}

class CartService {
  static addItem(MenuItem item) {   
    Cart.items.add(item);
    Cart.itemsNotifier.value = Cart.items;
  }

  static removeItem(MenuItem item) {  
    Cart.items.remove(item);
    Cart.itemsNotifier.value = Cart.items;
  }

  static List<MenuItem> getItems() {  
    return Cart.items;
  }
}
