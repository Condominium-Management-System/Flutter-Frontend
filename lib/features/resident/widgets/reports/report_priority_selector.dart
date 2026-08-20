
import 'package:flutter/material.dart';
import '../../../../shared/theme/colors.dart';

class ReportPrioritySelector extends StatelessWidget {
  final String selectedPriority;
  final ValueChanged<String> onPrioritySelected;

  const ReportPrioritySelector({
    super.key,
    required this.selectedPriority,
    required this.onPrioritySelected,
  });

  @override
  Widget build(BuildContext context) {
    final priorities = [
      {'value': 'low', 'label': 'Low', 'color': AppColors.successGreen},
      {'value': 'medium', 'label': 'Medium', 'color': AppColors.primaryGold},
      {'value': 'high', 'label': 'High', 'color': AppColors.warningYellow},
      {'value': 'emergency', 'label': 'Emergency', 'color': AppColors.errorRed},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Priority',
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
          children: priorities.map((priority) {
            final isSelected = selectedPriority == priority['value'];
            final color = priority['color'] as Color;
            return InkWell(
              onTap: () => onPrioritySelected(priority['value'] as String),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? color : AppColors.secondaryBlack,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected ? color : AppColors.textDark,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      priority['label'] as String,
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