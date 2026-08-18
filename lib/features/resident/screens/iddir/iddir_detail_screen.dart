
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../resident/cubits/iddir_cubit.dart';
import '../../../resident/cubits/iddir_state.dart';
import '../../../resident/widgets/common/resident_app_bar.dart';
import '../../../resident/widgets/common/loading_indicator.dart';
import '../../../resident/widgets/common/error_widget.dart';
import '../../../resident/widgets/iddir/iddir_member_list.dart';
import '../../../resident/widgets/iddir/iddir_join_button.dart';
import '../../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class IddirDetailScreen extends StatefulWidget {
  final String iddirId;

  const IddirDetailScreen({
    super.key,
    required this.iddirId,
  });

  @override
  State<IddirDetailScreen> createState() => _IddirDetailScreenState();
}

class _IddirDetailScreenState extends State<IddirDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<IddirCubit>().loadIddirDetails(widget.iddirId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResidentAppBar(
        title: 'Iddir Details',
        showBackButton: true,
        onNotificationTap: () {},
        onProfileTap: () {},
      ),
      body: BlocConsumer<IddirCubit, IddirState>(
        listener: (context, state) {
          if (state is IddirJoined) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Successfully joined Iddir group!'),
                backgroundColor: AppColors.successGreen,
              ),
            );
            context.read<IddirCubit>().loadIddirDetails(widget.iddirId);
          }
          if (state is IddirError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.errorRed,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is IddirLoading) {
            return const LoadingIndicator(message: 'Loading Iddir details...');
          }

          if (state is IddirError) {
            return ResidentErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<IddirCubit>().loadIddirDetails(widget.iddirId);
              },
            );
          }

          if (state is IddirDetailsLoaded) {
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
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: group.isActive
                              ? AppColors.successGreen.withOpacity(0.15)
                              : AppColors.textDark.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          group.statusLabel,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: group.isActive
                                ? AppColors.successGreen
                                : AppColors.textDark,
                          ),
                        ),
                      ),
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
                            label: 'Started',
                            value: group.startedDate.substring(0, 10),
                          ),
                        ),
                      ],
                    ),
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
                  IddirMemberList(
                    members: group.members,
                  ),
                  const SizedBox(height: 16),

                  // Join Button
                  IddirJoinButton(
                    iddirId: group.id,
                    isMember: false,
                    isPending: false,
                    onJoin: () {
                      context.read<IddirCubit>().joinIddir(group.id);
                    },
                    isLoading: state is IddirLoading,
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
}