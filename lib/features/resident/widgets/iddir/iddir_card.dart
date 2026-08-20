
import 'package:flutter/material.dart';
import '../../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../resident/models/iddir_model.dart';

class IddirCard extends StatelessWidget {
  final IddirModel iddir;
  final VoidCallback onTap;

  const IddirCard({
    super.key,
    required this.iddir,
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
            color: iddir.isActive
                ? AppColors.successGreen.withOpacity(0.2)
                : AppColors.textDark.withOpacity(0.2),
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
                    iddir.name,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textWhite,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: iddir.isActive
                        ? AppColors.successGreen.withOpacity(0.15)
                        : AppColors.textDark.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    iddir.statusLabel,
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: iddir.isActive ? AppColors.successGreen : AppColors.textDark,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildInfoItem(
                  icon: Icons.people_outline,
                  label: '${iddir.noMembers} Members',
                ),
                const SizedBox(width: 16),
                _buildInfoItem(
                  icon: Icons.attach_money,
                  label: 'ETB ${iddir.contributionAmount.toStringAsFixed(0)}',
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildInfoItem(
              icon: Icons.calendar_today,
              label: 'Started: ${_formatDate(iddir.startedDate)}',
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