
import 'package:flutter/material.dart';
import '../../../../shared/theme/colors.dart';
import '../common/gold_button.dart';

class IddirJoinButton extends StatelessWidget {
  final String iddirId;
  final bool isMember;
  final bool isPending;
  final VoidCallback onJoin;
  final bool isLoading;

  const IddirJoinButton({
    super.key,
    required this.iddirId,
    required this.isMember,
    required this.isPending,
    required this.onJoin,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isMember) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        child: Text(
          '✓ You are a member',
          style: TextStyle(
            color: AppColors.successGreen,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    if (isPending) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        child: Text(
          '⏳ Pending Approval',
          style: TextStyle(
            color: AppColors.warningYellow,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    return GoldButton(
      text: 'Join Iddir',
      variant: ButtonVariant.primary,
      size: ButtonSize.medium,
      isLoading: isLoading,
      onPressed: onJoin,
      icon: Icons.person_add,
    );
  }
}