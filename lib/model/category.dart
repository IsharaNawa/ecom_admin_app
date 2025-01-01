import 'package:ecom_admin_app/services/icon_manager.dart';
import 'package:flutter/material.dart';

class Category {
  Category({required this.name, required this.id, required this.categoryIcon});

  final String name, id;
  final Icon categoryIcon;

  static List<Category> CATEGORIES = [
    Category(
      name: "Phones",
      id: "0",
      categoryIcon: Icon(
        IconManager.phoneCategoryIcon,
        size: 40,
      ),
    ),
    Category(
      name: "Laptops",
      id: "1",
      categoryIcon: Icon(
        IconManager.laptopCategoryIcon,
        size: 40,
      ),
    ),
    Category(
      name: "Electronics",
      id: "2",
      categoryIcon: Icon(
        IconManager.electronicsCategoryIcon,
        size: 40,
      ),
    ),
    Category(
      name: "Watches",
      id: "3",
      categoryIcon: Icon(
        IconManager.watchCategoryIcon,
        size: 40,
      ),
    ),
    Category(
      name: "Clothes",
      id: "4",
      categoryIcon: Icon(
        IconManager.clotheCategoryIcon,
        size: 40,
      ),
    ),
    Category(
      name: "Shoes",
      id: "5",
      categoryIcon: Icon(
        IconManager.shoeCategoryIcon,
        size: 40,
      ),
    ),
    Category(
      name: "Books",
      id: "6",
      categoryIcon: Icon(
        IconManager.bookCategoryIcon,
        size: 40,
      ),
    ),
    Category(
      name: "Makeup",
      id: "7",
      categoryIcon: Icon(
        IconManager.makeupCategoryIcon,
        size: 40,
      ),
    ),
  ];
}
