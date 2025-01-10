import 'package:flutter/material.dart';

class Meal {
  final String name;
  final IconData icon;
  final List<Product> products;

  Meal(this.name, {required this.icon, required this.products});

  int totalCalories() {
    return products.fold(0, (total, product) => total + product.calories);
  }
}

class Product {
  final String name;
  final int calories;

  Product(this.name, this.calories);
}
