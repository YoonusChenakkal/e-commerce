import 'package:e_commerce/common/models/category_model.dart';
import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final Category category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            if (category.imageUrl.isNotEmpty)
              CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(category.imageUrl),
              ),
            const SizedBox(width: 8),
            Text(
              category.name,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.blue : Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
