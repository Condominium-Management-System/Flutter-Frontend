
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../resident/cubits/iddir_cubit.dart';
import '../../../resident/cubits/iddir_state.dart';
import '../../../resident/widgets/common/resident_app_bar.dart';
import '../../../resident/widgets/common/gold_button.dart';
import '../../../resident/widgets/common/loading_indicator.dart';
import '../../../resident/widgets/common/error_widget.dart';
import '../../../resident/widgets/common/success_dialog.dart';
import '../../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class IddirJoinScreen extends StatefulWidget {
  final String iddirId;

  const IddirJoinScreen({
    super.key,
    required this.iddirId,
  });

  @override
  State<IddirJoinScreen> createState() => _IddirJoinScreenState();
}

class _IddirJoinScreenState extends State<IddirJoinScreen> {
  @override
  void initState() {
    super.initState();
    context.read<IddirCubit>().loadIddirDetails(widget.iddirId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResidentAppBar(
        title: 'Join Iddir',
        showBackButton: true,
        onNotificationTap: () {},
        onProfileTap: () {},
      ),
      body: BlocConsumer<IddirCubit, IddirState>(
        listener: (context, state) {
          if (state is IddirJoined) {
            SuccessDialog.show(
              context,
              title: 'Joined Successfully!',
              message: 'You have successfully joined the Iddir group.',
              buttonText: 'View Group',
              onButtonPressed: () {
                Navigator.pop(context);
              },
            );
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

          if (state is IddirError && state.message != '') {
            return ResidentErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<IddirCubit>().loadIddirDetails(widget.iddirId);
              },
            );
          }

          if (state is IddirDetailsLoaded) {
            final group = state.group;

            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Group Info Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryBlack,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.primaryGold.withOpacity(0.1),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Group Details',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textGray,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildInfoRow(
                          label: 'Name',
                          value: group.name,
                        ),
                        _buildInfoRow(
                          label: 'Members',
                          value: '${group.noMembers} members',
                        ),
                        _buildInfoRow(
                          label: 'Contribution',
                          value: 'ETB ${group.contributionAmount.toStringAsFixed(0)}',
                        ),
                        _buildInfoRow(
                          label: 'Status',
                          value: group.statusLabel,
                          isStatus: true,
                          statusColor: group.isActive
                              ? AppColors.successGreen
                              : AppColors.textDark,
                        ),
                        _buildInfoRow(
                          label: 'Started',
                          value: group.startedDate.substring(0, 10),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Join Confirmation
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primaryGold.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.primaryGold.withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: AppColors.primaryGold,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'By joining this Iddir, you agree to contribute '
                            'ETB ${group.contributionAmount.toStringAsFixed(0)} monthly.',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: AppColors.textGray,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Join Button
                  GoldButton(
                    text: 'Confirm Join',
                    variant: ButtonVariant.primary,
                    size: ButtonSize.large,
                    isLoading: state is IddirLoading,
                    onPressed: () {
                      context.read<IddirCubit>().joinIddir(widget.iddirId);
                    },
                  ),

                  const SizedBox(height: 12),

                  // Cancel Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: AppColors.textDark,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: AppColors.textGray,
                        ),
                      ),
                    ),
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

  Widget _buildInfoRow({
    required String label,
    required String value,
    bool isStatus = false,
    Color? statusColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.textGray,
            ),
          ),
          if (isStatus && statusColor != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: statusColor,
                ),
              ),
            )
          else
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textWhite,
              ),
            ),
        ],
      ),
    );
  }
}