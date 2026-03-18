import 'package:flutter/material.dart';

enum RecipeCategory {
  breakfast,
  lunch,
  dinner,
  dessert,
  snacks,
  drinks,
  vegetarian,
  international,
}

extension RecipeCategoryExt on RecipeCategory {
  String get label {
    switch (this) {
      case RecipeCategory.breakfast: return 'Breakfast';
      case RecipeCategory.lunch: return 'Lunch';
      case RecipeCategory.dinner: return 'Dinner';
      case RecipeCategory.dessert: return 'Dessert';
      case RecipeCategory.snacks: return 'Snacks';
      case RecipeCategory.drinks: return 'Drinks';
      case RecipeCategory.vegetarian: return 'Vegetarian';
      case RecipeCategory.international: return 'International';
    }
  }

  IconData get icon {
    switch (this) {
      case RecipeCategory.breakfast: return Icons.egg_alt_rounded;
      case RecipeCategory.lunch: return Icons.lunch_dining_rounded;
      case RecipeCategory.dinner: return Icons.dinner_dining_rounded;
      case RecipeCategory.dessert: return Icons.cake_rounded;
      case RecipeCategory.snacks: return Icons.cookie_rounded;
      case RecipeCategory.drinks: return Icons.local_cafe_rounded;
      case RecipeCategory.vegetarian: return Icons.eco_rounded;
      case RecipeCategory.international: return Icons.public_rounded;
    }
  }

  int get colorIndex {
    switch (this) {
      case RecipeCategory.breakfast: return 0;
      case RecipeCategory.lunch: return 1;
      case RecipeCategory.dinner: return 2;
      case RecipeCategory.dessert: return 3;
      case RecipeCategory.snacks: return 4;
      case RecipeCategory.drinks: return 5;
      case RecipeCategory.vegetarian: return 6;
      case RecipeCategory.international: return 7;
    }
  }
}

enum DifficultyLevel { easy, medium, hard }

extension DifficultyExt on DifficultyLevel {
  String get label {
    switch (this) {
      case DifficultyLevel.easy: return 'Easy';
      case DifficultyLevel.medium: return 'Medium';
      case DifficultyLevel.hard: return 'Hard';
    }
  }
}

class Recipe {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final RecipeCategory category;
  final DifficultyLevel difficulty;
  final int prepMinutes;
  final int cookMinutes;
  final int servings;
  final double rating;
  final int reviewCount;
  final List<String> ingredients;
  final List<String> steps;
  final List<String> tags;
  final int calories;
  final bool isFeatured;
  bool isFavorite;
  final IconData? icon;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.difficulty,
    required this.prepMinutes,
    required this.cookMinutes,
    required this.servings,
    required this.rating,
    required this.reviewCount,
    required this.ingredients,
    required this.steps,
    required this.tags,
    required this.calories,
    this.isFeatured = false,
    this.isFavorite = false,
    this.icon,
  });

  int get totalMinutes => prepMinutes + cookMinutes;
}
