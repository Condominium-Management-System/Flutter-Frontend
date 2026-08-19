
// ignore_for_file: unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../resident/cubits/equb_cubit.dart';
import '../../../resident/cubits/equb_state.dart';
import '../../../resident/widgets/common/resident_app_bar.dart';
import '../../../resident/widgets/common/gold_button.dart';
import '../../../resident/widgets/common/loading_indicator.dart';
import '../../../resident/widgets/common/error_widget.dart';
import '../../../resident/widgets/common/success_dialog.dart';
import '../../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class EqubJoinScreen extends StatefulWidget {
  final String equbId;

  const EqubJoinScreen({
    super.key,
    required this.equbId,
  });

  @override
  State<EqubJoinScreen> createState() => _EqubJoinScreenState();
}

class _EqubJoinScreenState extends State<EqubJoinScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    context.read<EqubCubit>().loadEqubDetails(widget.equbId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResidentAppBar(
        title: 'Join Equb',
        showBackButton: true,
        onNotificationTap: () {},
        onProfileTap: () {},
      ),
      body: BlocConsumer<EqubCubit, EqubState>(
        listener: (context, state) {
          if (state is EqubJoined) {
            SuccessDialog.show(
              context,
              title: 'Joined Successfully!',
              message: 'You have successfully joined the Equb group.',
              buttonText: 'View Group',
              onButtonPressed: () {
                Navigator.pop(context);
              },
            );
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

          if (state is EqubError && state.message != '') {
            return ResidentErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<EqubCubit>().loadEqubDetails(widget.equbId);
              },
            );
          }

          if (state is EqubDetailsLoaded) {
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
                          statusColor: _getStatusColor(group.status),
                        ),
                        _buildInfoRow(
                          label: 'Duration',
                          value: '${group.startDate.substring(0, 10)} - ${group.dueDate.substring(0, 10)}',
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
                            'By joining this Equb, you agree to contribute '
                            'ETB ${group.contributionAmount.toStringAsFixed(0)} regularly.',
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
                    isLoading: state is EqubLoading,
                    onPressed: () {
                      context.read<EqubCubit>().joinEqub(widget.equbId);
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

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return AppColors.warningYellow;
      case 'active':
        return AppColors.successGreen;
      case 'completed':
        return AppColors.infoBlue;
      case 'cancelled':
        return AppColors.errorRed;
      default:
        return AppColors.textGray;
    }
  }
}