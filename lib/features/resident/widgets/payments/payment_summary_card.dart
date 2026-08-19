// ============================================
// FILE: lib/features/resident/widgets/payments/payment_summary_card.dart
// PURPOSE: Payment summary card widget
// ============================================

import 'package:flutter/material.dart';
import '../../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentSummaryCard extends StatelessWidget {
  final double totalAmount;
  final int pendingCount;
  final int approvedCount;
  final int rejectedCount;

  const PaymentSummaryCard({
    super.key,
    required this.totalAmount,
    required this.pendingCount,
    required this.approvedCount,
    required this.rejectedCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondaryBlack,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primaryGold.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Summary',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textWhite,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(
                  label: 'Total',
                  value: 'ETB ${totalAmount.toStringAsFixed(2)}',
                  color: AppColors.textWhite,
                ),
              ),
              Expanded(
                child: _buildSummaryItem(
                  label: 'Pending',
                  value: pendingCount.toString(),
                  color: AppColors.warningYellow,
                ),
              ),
              Expanded(
                child: _buildSummaryItem(
                  label: 'Approved',
                  value: approvedCount.toString(),
                  color: AppColors.successGreen,
                ),
              ),
              Expanded(
                child: _buildSummaryItem(
                  label: 'Rejected',
                  value: rejectedCount.toString(),
                  color: AppColors.errorRed,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem({
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.normal,
            color: AppColors.textGray,
          ),
        ),
      ],
    );
  }
}