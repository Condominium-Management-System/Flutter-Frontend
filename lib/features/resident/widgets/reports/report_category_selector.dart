
import 'package:flutter/material.dart';
import '../../../../shared/theme/colors.dart';

class ReportCategorySelector extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const ReportCategorySelector({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'value': 'plumbing', 'label': 'Plumbing', 'icon': Icons.plumbing},
      {'value': 'electrical', 'label': 'Electrical', 'icon': Icons.electrical_services},
      {'value': 'structural', 'label': 'Structural', 'icon': Icons.construction},
      {'value': 'security', 'label': 'Security', 'icon': Icons.security},
      {'value': 'noise', 'label': 'Noise', 'icon': Icons.volume_up},
      {'value': 'other', 'label': 'Other', 'icon': Icons.more_horiz},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: TextStyle(
            color: AppColors.textWhite,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: categories.map((category) {
            final isSelected = selectedCategory == category['value'];
            return InkWell(
              onTap: () => onCategorySelected(category['value'] as String),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primaryGold : AppColors.secondaryBlack,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected ? AppColors.primaryGold : AppColors.textDark,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      category['icon'] as IconData,
                      color: isSelected ? AppColors.primaryBlack : AppColors.textGray,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      category['label'] as String,
                      style: TextStyle(
                        color: isSelected ? AppColors.primaryBlack : AppColors.textGray,
                        fontSize: 13,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}