
import 'package:flutter/material.dart';
import '../../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../resident/models/iddir_member_model.dart';
import '../../../auth/models/user_model.dart';

class IddirMemberList extends StatelessWidget {
  final List<IddirMemberModel> members;
  final Map<String, UserModel>? users;
  final bool isLoading;

  const IddirMemberList({
    super.key,
    required this.members,
    this.users,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryGold),
          ),
        ),
      );
    }

    if (members.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(24),
        alignment: Alignment.center,
        child: Text(
          'No members yet',
          style: GoogleFonts.inter(
            fontSize: 14,
            color: AppColors.textGray,
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: members.length,
      separatorBuilder: (context, index) => Divider(
        color: AppColors.textDark.withOpacity(0.3),
        height: 1,
      ),
      itemBuilder: (context, index) {
        final member = members[index];
        final userName = users?[member.userId]?.fullName ?? 'Unknown User';

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.primaryGold.withOpacity(0.1),
                child: Icon(
                  Icons.person,
                  color: AppColors.primaryGold,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textWhite,
                      ),
                    ),
                    if (member.totalPaid != null)
                      Text(
                        'Paid: ETB ${member.totalPaid!.toStringAsFixed(2)}',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.textGray,
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: _getStatusColor(member.status).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  member.statusLabel,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: _getStatusColor(member.status),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'active':
        return AppColors.successGreen;
      case 'inactive':
        return AppColors.textDark;
      case 'suspended':
        return AppColors.warningYellow;
      default:
        return AppColors.textGray;
    }
  }
}