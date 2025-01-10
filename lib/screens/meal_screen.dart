import 'package:calories_calculator/models/meal.dart';
import 'package:calories_calculator/utils/colors.dart';
import 'package:calories_calculator/widgets/meal_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class MealsScreen extends StatefulWidget {
  const MealsScreen({super.key});

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  final List<Meal> meals = [
    Meal("Meal One", icon: Icons.wb_sunny, products: [
      Product("Spicy Bacon Cheese Toast", 312),
      Product("Almond Milk", 312),
    ]),
    Meal("Meal Two", icon: Icons.cloud, products: []),
    Meal("Meal Three", icon: Icons.sunny, products: []),
    Meal("Meal Four", icon: Icons.wb_twilight, products: []),
    Meal("Meal Five", icon: Icons.nightlight_round, products: []),
    Meal("Meal Six", icon: Icons.nightlight_round, products: []),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1EB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Meals",
          style: GoogleFonts.poppins(
            color: AppColors.primaryText,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          const Icon(Icons.favorite_border, color: Colors.black),
          const SizedBox(width: 5),
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) {
          final meal = meals[index];
          return MealCard(
            meal: meal,
            onAddProduct: () {
              showAddProductDialog(context, (String name, int calories) {
                setState(() {
                  meal.products.add(Product(name, calories));
                });
              });
            },
            onRemoveProduct: (productIndex) {
              setState(() {
                meal.products.removeAt(productIndex);
              });
            },
          );
        },
      ),
    );
  }
}

void showAddProductDialog(BuildContext context, Function(String, int) onAdd) {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: const Text(
          "Add Product",
          style: TextStyle(
            fontFamily: "NunitoSans",
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  fillColor: AppColors.primaryBackground,
                  filled: true,
                  labelText: "Name",
                  hintText: "Enter product name",
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Material(
              child: TextField(
                controller: caloriesController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  fillColor: AppColors.primaryBackground,
                  filled: true,
                  labelText: "Calories",
                  hintText: "Enter calories",
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Cancel",
              // style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              final String name = nameController.text.trim();
              final String caloriesText = caloriesController.text.trim();

              if (name.isNotEmpty && caloriesText.isNotEmpty) {
                final int? calories = int.tryParse(caloriesText);
                if (calories != null) {
                  onAdd(name, calories);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please enter valid calories."),
                    ),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("All fields are required."),
                  ),
                );
              }
            },
            child: const Text("Add"),
          ),
        ],
      );
    },
  );
}
