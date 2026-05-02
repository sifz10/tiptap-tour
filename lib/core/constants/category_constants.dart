import 'package:flutter/material.dart';
import 'package:tiptap_tour/presentation/theme/app_colors.dart';

enum ExpenseCategory {
  food,
  transport,
  lodging,
  activities,
  shopping,
  emergency,
  entertainment,
  health,
  communication,
  other,
}

extension ExpenseCategoryX on ExpenseCategory {
  String get displayName {
    return switch (this) {
      ExpenseCategory.food => 'Food & Drinks',
      ExpenseCategory.transport => 'Transport',
      ExpenseCategory.lodging => 'Lodging',
      ExpenseCategory.activities => 'Activities',
      ExpenseCategory.shopping => 'Shopping',
      ExpenseCategory.emergency => 'Emergency',
      ExpenseCategory.entertainment => 'Entertainment',
      ExpenseCategory.health => 'Health',
      ExpenseCategory.communication => 'Communication',
      ExpenseCategory.other => 'Other',
    };
  }

  IconData get icon {
    return switch (this) {
      ExpenseCategory.food => Icons.restaurant_rounded,
      ExpenseCategory.transport => Icons.directions_car_rounded,
      ExpenseCategory.lodging => Icons.hotel_rounded,
      ExpenseCategory.activities => Icons.hiking_rounded,
      ExpenseCategory.shopping => Icons.shopping_bag_rounded,
      ExpenseCategory.emergency => Icons.emergency_rounded,
      ExpenseCategory.entertainment => Icons.movie_rounded,
      ExpenseCategory.health => Icons.medical_services_rounded,
      ExpenseCategory.communication => Icons.phone_rounded,
      ExpenseCategory.other => Icons.more_horiz_rounded,
    };
  }

  Color get color {
    return switch (this) {
      ExpenseCategory.food => AppColors.categoryFood,
      ExpenseCategory.transport => AppColors.categoryTransport,
      ExpenseCategory.lodging => AppColors.categoryLodging,
      ExpenseCategory.activities => AppColors.categoryActivities,
      ExpenseCategory.shopping => AppColors.categoryShopping,
      ExpenseCategory.emergency => AppColors.categoryEmergency,
      ExpenseCategory.entertainment => AppColors.primary,
      ExpenseCategory.health => AppColors.success,
      ExpenseCategory.communication => AppColors.info,
      ExpenseCategory.other => AppColors.textSecondaryLight,
    };
  }
}
