
// ignore_for_file: unused_import, duplicate_import

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../resident/cubits/equb_cubit.dart';
import '../../../resident/cubits/payment_cubit.dart';
import '../../../resident/cubits/equb_state.dart';
import '../../../resident/cubits/payment_cubit.dart';
import '../../../resident/cubits/payment_state.dart';
import '../../../resident/widgets/common/resident_app_bar.dart';
import '../../../resident/widgets/common/gold_button.dart';
import '../../../resident/widgets/common/gold_text_field.dart';
import '../../../resident/widgets/common/loading_indicator.dart';
import '../../../resident/widgets/common/error_widget.dart';
import '../../../resident/widgets/common/success_dialog.dart';
import '../../../resident/widgets/payments/payment_method_selector.dart';
import '../../../resident/widgets/payments/payment_receipt_uploader.dart';
import '../../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class EqubContributionScreen extends StatefulWidget {
  final String equbId;

  const EqubContributionScreen({
    super.key,
    required this.equbId,
  });

  @override
  State<EqubContributionScreen> createState() => _EqubContributionScreenState();
}

class _EqubContributionScreenState extends State<EqubContributionScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedMethod = 'cbe';
  final _amountController = TextEditingController();
  File? _receiptFile;
  double _contributionAmount = 0.0;

  @override
  void initState() {
    super.initState();
    context.read<EqubCubit>().loadEqubDetails(widget.equbId);
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResidentAppBar(
        title: 'Make Contribution',
        showBackButton: true,
        onNotificationTap: () {},
        onProfileTap: () {},
      ),
      body: BlocConsumer<PaymentCubit, PaymentState>(
        listener: (context, state) {
          if (state is PaymentCreated) {
            SuccessDialog.show(
              context,
              title: 'Contribution Submitted!',
              message: 'Your Equb contribution has been submitted successfully.',
              buttonText: 'Done',
              onButtonPressed: () {
                Navigator.pop(context);
              },
            );
          }
          if (state is PaymentError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.errorRed,
              ),
            );
          }
        },
        builder: (context, paymentState) {
          return BlocBuilder<EqubCubit, EqubState>(
          builder: (context, equbState) {
            if (equbState is EqubLoading) {
              return const LoadingIndicator(message: 'Loading Equb details...');
            }

            if (equbState is EqubError) {
              return ResidentErrorWidget(
                message: equbState.message,
                onRetry: () {
                  context.read<EqubCubit>().loadEqubDetails(widget.equbId);
                },
              );
            }

            if (equbState is EqubDetailsLoaded) {
              final group = equbState.group;
              _contributionAmount = group.contributionAmount;

              return BlocBuilder<PaymentCubit, PaymentState>(
                builder: (context, paymentState) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Group Info
                          Container(
                            width: double.infinity,
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
                                  'Contributing to',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: AppColors.textGray,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  group.name,
                                  style: GoogleFonts.inter(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textWhite,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    _buildInfoChip(
                                      label: 'Amount',
                                      value: 'ETB ${_contributionAmount.toStringAsFixed(0)}',
                                    ),
                                    const SizedBox(width: 8),
                                    _buildInfoChip(
                                      label: 'Members',
                                      value: '${group.noMembers}',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Amount (Auto-filled, read-only)
                          Text(
                            'Contribution Amount',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textWhite,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(
                              color: AppColors.inputBackground,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.primaryGold.withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              'ETB ${_contributionAmount.toStringAsFixed(2)}',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textWhite,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Payment Method
                          Text(
                            'Payment Method',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textWhite,
                            ),
                          ),
                          const SizedBox(height: 8),
                          PaymentMethodSelector(
                            selectedMethod: _selectedMethod,
                            onMethodSelected: (method) {
                              setState(() {
                                _selectedMethod = method;
                              });
                            },
                          ),
                          const SizedBox(height: 20),

                          // Receipt Upload
                          PaymentReceiptUploader(
                            onFileSelected: (file) {
                              setState(() {
                                _receiptFile = file;
                              });
                            },
                          ),
                          const SizedBox(height: 30),

                          // Submit Button
                          GoldButton(
                            text: 'Submit Contribution',
                            variant: ButtonVariant.primary,
                            size: ButtonSize.large,
                            isLoading: paymentState is PaymentLoading,
                            onPressed: () {
                              _submitContribution(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        );
        },
    ));
  }

  Widget _buildInfoChip({
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryGold.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.primaryGold.withOpacity(0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: ',
            style: GoogleFonts.inter(
              fontSize: 12,
              color: AppColors.textGray,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textWhite,
            ),
          ),
        ],
      ),
    );
  }

  void _submitContribution(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<PaymentCubit>().makePayment(
            paymentType: 'equb',
            amount: _contributionAmount,
            paymentMethod: _selectedMethod,
            equbId: widget.equbId,
            monthYear: _getCurrentMonthYear(),
            receiptPath: _receiptFile?.path,
          );
    }
  }

  String _getCurrentMonthYear() {
    final now = DateTime.now();
    return '${now.month.toString().padLeft(2, '0')}-${now.year}';
  }
}