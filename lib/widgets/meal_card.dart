import 'package:calories_calculator/models/meal.dart';
import 'package:calories_calculator/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class MealCard extends StatefulWidget {
  final Meal meal;
  final VoidCallback onAddProduct;
  final Function(int) onRemoveProduct;

  const MealCard({
    required this.meal,
    required this.onAddProduct,
    required this.onRemoveProduct,
  });

  @override
  State<MealCard> createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: AppColors.cardBackground,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Row(
                    children: [
                      Container(
                        // margin: EdgeInsets.only(top: 10, left: 10),

                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: AppColors.primaryBackground,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child:
                            const Icon(Icons.wb_sunny, color: Colors.black54),
                      ),
                      const SizedBox(width: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.meal.name,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryText,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          (widget.meal.products.isEmpty)
                              ? Container(
                                  decoration: BoxDecoration(
                                      color: Colors.brown.shade600,
                                      borderRadius: BorderRadius.circular(25)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  child: Text(
                                    "No Products",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                )
                              : Row(
                                  children: [
                                    SizedBox(
                                      height: 25,
                                      child: OutlinedButton(
                                        style: ButtonStyle(
                                            side: MaterialStatePropertyAll(
                                                BorderSide(
                                          color: Colors.brown.shade700,
                                        ))),
                                        onPressed: () {
                                          setState(() {
                                            isEditing = !isEditing;
                                          });
                                        },
                                        child: Text(
                                          isEditing ? "Save" : "Edit",
                                          style: GoogleFonts.poppins(
                                            fontSize: 10.0,
                                            color: AppColors.buttonBackground,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                    const Icon(
                                      Icons.bookmark_border,
                                      color: Colors.black54,
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 75,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(25),
                  ),
                  border: const Border(
                    left: BorderSide(
                      color: AppColors.primaryBackground,
                      width: 7,
                    ),
                    bottom: BorderSide(
                      color: AppColors.primaryBackground,
                      width: 7,
                    ),
                  ),
                  color: Colors.brown.shade700,
                ),
                child: IconButton(
                    onPressed: widget.onAddProduct,
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    )),
              )
            ],
          ),
          if (widget.meal.products.isEmpty)
            const SizedBox(height: 10)
          else
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              padding: const EdgeInsets.only(bottom: 10),
              decoration: const BoxDecoration(
                  color: AppColors.primaryBackground,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  )),
              child: Column(
                children: [
                  ...widget.meal.products.asMap().entries.map((entry) {
                    final product = entry.value;
                    final index = entry.key;
                    return Container(
                      padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5)
                          .copyWith(right: 0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.57,
                            child: Text(
                              product.name,
                              style: const TextStyle(
                                fontFamily: "NunitoSans",
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Color(0xFF5A5A5A),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.15,
                            child: Text(
                              "${product.calories} Cals",
                              style: const TextStyle(
                                fontFamily: "NunitoSans",
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Color(0xFF5A5A5A),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.1,
                            child: IconButton(
                              icon: Icon(
                                isEditing
                                    ? Icons.close
                                    : Icons.arrow_circle_right,
                                color: isEditing
                                    ? Colors.red
                                    : AppColors.buttonBackground,
                              ),
                              onPressed: isEditing
                                  ? () => widget.onRemoveProduct(index)
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.57,
                          child: const Text(
                            "Total",
                            style: TextStyle(
                              fontFamily: "NunitoSans",
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.2,
                          child: Text(
                            "${widget.meal.totalCalories()} Cals",
                            style: const TextStyle(
                              fontFamily: "NunitoSans",
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xFF008000),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
