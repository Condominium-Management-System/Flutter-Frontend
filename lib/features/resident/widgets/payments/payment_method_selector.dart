
import 'package:flutter/material.dart';
import '../../../../shared/theme/colors.dart';

class PaymentMethodSelector extends StatelessWidget {
  final String selectedMethod;
  final ValueChanged<String> onMethodSelected;

  const PaymentMethodSelector({
    super.key,
    required this.selectedMethod,
    required this.onMethodSelected,
  });

  @override
  Widget build(BuildContext context) {
    final methods = [
      {'value': 'cbe', 'label': 'CBE', 'icon': Icons.account_balance},
      {'value': 'telebirr', 'label': 'TeleBirr', 'icon': Icons.mobile_friendly},
      {'value': 'cash', 'label': 'Cash', 'icon': Icons.money},
      {'value': 'bank_transfer', 'label': 'Bank Transfer', 'icon': Icons.compare_arrows},
      {'value': 'chapa', 'label': 'Chapa', 'icon': Icons.credit_card},
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: methods.map((method) {
        final isSelected = selectedMethod == method['value'];
        return InkWell(
          onTap: () => onMethodSelected(method['value'] as String),
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
                  method['icon'] as IconData,
                  color: isSelected ? AppColors.primaryBlack : AppColors.textGray,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  method['label'] as String,
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