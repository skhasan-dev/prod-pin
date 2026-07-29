import 'package:flutter/material.dart';
import 'package:prod_pin/src/core/index.dart';
import 'package:prod_pin/src/features/category/index.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final bool isFull;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const CategoryCard({
    super.key,
    required this.category,
    required this.isFull,
    required this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (context.isDesktop) {
      return DesktopCategoryCard(
        category: category,
        isFull: isFull,
        onTap: onTap,
        onEdit: onEdit,
        onDelete: onDelete,
      );
    }

    return MobileCategoryCard(
      category: category,
      isFull: isFull,
      onTap: onTap,
    );
  }
}
