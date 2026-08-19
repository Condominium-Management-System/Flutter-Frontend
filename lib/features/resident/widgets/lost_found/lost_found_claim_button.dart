
import 'package:flutter/material.dart';
import '../../../../shared/theme/colors.dart';
import '../common/gold_button.dart';

class LostFoundClaimButton extends StatelessWidget {
  final String itemId;
  final bool isClaimed;
  final bool isVerified;
  final VoidCallback onClaim;
  final bool isLoading;

  const LostFoundClaimButton({
    super.key,
    required this.itemId,
    required this.isClaimed,
    required this.isVerified,
    required this.onClaim,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isClaimed && isVerified) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        child: Text(
          '✓ Claimed & Verified',
          style: TextStyle(
            color: AppColors.successGreen,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    if (isClaimed) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        child: Text(
          '⏳ Claim Pending Verification',
          style: TextStyle(
            color: AppColors.warningYellow,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    return GoldButton(
      text: 'Claim This Item',
      variant: ButtonVariant.primary,
      size: ButtonSize.medium,
      isLoading: isLoading,
      onPressed: onClaim,
      icon: Icons.check_circle_outline,
    );
  }
}