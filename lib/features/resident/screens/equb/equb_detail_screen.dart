
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../resident/cubits/equb_cubit.dart';
import '../../../resident/cubits/equb_state.dart';
import '../../../resident/widgets/common/resident_app_bar.dart';
import '../../../resident/widgets/common/loading_indicator.dart';
import '../../../resident/widgets/common/error_widget.dart';
import '../../../resident/widgets/equb/equb_status_badge.dart';
import '../../../resident/widgets/equb/equb_progress_bar.dart';
import '../../../resident/widgets/equb/equb_member_list.dart';
import '../../../resident/widgets/equb/equb_join_button.dart';
import '../../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class EqubDetailScreen extends StatefulWidget {
  final String equbId;

  const EqubDetailScreen({
    super.key,
    required this.equbId,
  });

  @override
  State<EqubDetailScreen> createState() => _EqubDetailScreenState();
}

class _EqubDetailScreenState extends State<EqubDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EqubCubit>().loadEqubDetails(widget.equbId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResidentAppBar(
        title: 'Equb Details',
        showBackButton: true,
        onNotificationTap: () {},
        onProfileTap: () {},
      ),
      body: BlocConsumer<EqubCubit, EqubState>(
        listener: (context, state) {
          if (state is EqubJoined) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Successfully joined Equb group!'),
                backgroundColor: AppColors.successGreen,
              ),
            );
            context.read<EqubCubit>().loadEqubDetails(widget.equbId);
          }
          if (state is EqubError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.errorRed,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is EqubLoading) {
            return const LoadingIndicator(message: 'Loading Equb details...');
          }

          if (state is EqubError) {
            return ResidentErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<EqubCubit>().loadEqubDetails(widget.equbId);
              },
            );
          }

          if (state is EqubDetailsLoaded) {
            final group = state.group;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          group.name,
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textWhite,
                          ),
                        ),
                      ),
                      EqubStatusBadge(status: group.status),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Stats
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryBlack,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.primaryGold.withOpacity(0.1),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildStatItem(
                            label: 'Members',
                            value: '${group.noMembers}',
                          ),
                        ),
                        Expanded(
                          child: _buildStatItem(
                            label: 'Contribution',
                            value: 'ETB ${group.contributionAmount.toStringAsFixed(0)}',
                          ),
                        ),
                        Expanded(
                          child: _buildStatItem(
                            label: 'Progress',
                            value: '${(group.progress * 100).toInt()}%',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Progress Bar
                  EqubProgressBar(
                    current: group.members.where((m) => m.status == 'active').length,
                    total: group.noMembers,
                  ),
                  const SizedBox(height: 16),

                  // Dates
                  Row(
                    children: [
                      _buildDateItem(
                        label: 'Start Date',
                        value: group.startDate.substring(0, 10),
                      ),
                      const SizedBox(width: 16),
                      _buildDateItem(
                        label: 'End Date',
                        value: group.dueDate.substring(0, 10),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Members
                  Text(
                    'Members',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textWhite,
                    ),
                  ),
                  const SizedBox(height: 8),
                  EqubMemberList(
                    members: group.members,
                  ),
                  const SizedBox(height: 16),

                  // Join Button
                  EqubJoinButton(
                    equbId: group.id,
                    isMember: false, // This should be checked with current user
                    isPending: false,
                    onJoin: () {
                      context.read<EqubCubit>().joinEqub(group.id);
                    },
                    isLoading: state is EqubLoading,
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textWhite,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: AppColors.textGray,
          ),
        ),
      ],
    );
  }

  Widget _buildDateItem({
    required String label,
    required String value,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.secondaryBlack,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.textDark.withOpacity(0.2),
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: AppColors.textGray,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}