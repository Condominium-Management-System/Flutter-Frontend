
import 'package:flutter/material.dart';
import '../../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../resident/models/equb_model.dart';
import 'equb_status_badge.dart';
import 'equb_progress_bar.dart';

class EqubCard extends StatelessWidget {
  final EqubModel equb;
  final VoidCallback onTap;

  const EqubCard({
    super.key,
    required this.equb,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    equb.name,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textWhite,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                EqubStatusBadge(status: equb.status),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildInfoItem(
                  icon: Icons.people_outline,
                  label: '${equb.noMembers} Members',
                ),
                const SizedBox(width: 16),
                _buildInfoItem(
                  icon: Icons.attach_money,
                  label: 'ETB ${equb.contributionAmount.toStringAsFixed(0)}',
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildInfoItem(
                  icon: Icons.calendar_today,
                  label: _formatDate(equb.startDate),
                ),
                const SizedBox(width: 16),
                _buildInfoItem(
                  icon: Icons.calendar_today,
                  label: _formatDate(equb.dueDate),
                ),
              ],
            ),
            const SizedBox(height: 12),
            EqubProgressBar(
              current: equb.members.where((m) => m.status == 'active').length,
              total: equb.noMembers,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.primaryGold,
          size: 14,
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: AppColors.textGray,
          ),
        ),
      ],
    );
  }

  String _formatDate(String date) {
    // Simple placeholder - will use actual date formatter
    return date.substring(0, 10);
  }
}