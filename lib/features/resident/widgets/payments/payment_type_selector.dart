
import 'package:flutter/material.dart';
import '../../../../shared/theme/colors.dart';

class PaymentTypeSelector extends StatelessWidget {
  final String selectedType;
  final ValueChanged<String> onTypeSelected;

  const PaymentTypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final types = [
      {'value': 'service_charge', 'label': 'Service Charge', 'icon': Icons.apartment},
      {'value': 'equb', 'label': 'Equb', 'icon': Icons.attach_money},
      {'value': 'iddir', 'label': 'Iddir', 'icon': Icons.people_outline},
      {'value': 'guard_fee', 'label': 'Guard Fee', 'icon': Icons.security},
      {'value': 'other', 'label': 'Other', 'icon': Icons.payments_outlined},
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: types.map((type) {
        final isSelected = selectedType == type['value'];
        return InkWell(
          onTap: () => onTypeSelected(type['value'] as String),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
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
                  type['icon'] as IconData,
                  color: isSelected ? AppColors.primaryBlack : AppColors.textGray,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  type['label'] as String,
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
    );
  }
}