
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/payment_cubit.dart';
import '../../cubits/payment_state.dart';
import '../../widgets/common/resident_app_bar.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/error_widget.dart';
import '../../widgets/payments/payment_status_badge.dart';
import '../../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentDetailScreen extends StatefulWidget {
  final String paymentId;

  const PaymentDetailScreen({
    super.key,
    required this.paymentId,
  });

  @override
  State<PaymentDetailScreen> createState() => _PaymentDetailScreenState();
}

class _PaymentDetailScreenState extends State<PaymentDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PaymentCubit>().loadPaymentDetails(widget.paymentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResidentAppBar(
        title: 'Payment Details',
        showBackButton: true,
        onNotificationTap: () {},
        onProfileTap: () {},
      ),
      body: BlocBuilder<PaymentCubit, PaymentState>(
        builder: (context, state) {
          if (state is PaymentLoading) {
            return const LoadingIndicator(message: 'Loading payment details...');
          }

          if (state is PaymentError) {
            return ResidentErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<PaymentCubit>().loadPaymentDetails(widget.paymentId);
              },
            );
          }

          if (state is PaymentDetailsLoaded) {
            final payment = state.payment;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status Badge
                  Row(
                    children: [
                      PaymentStatusBadge(status: payment.status),
                      const Spacer(),
                      Text(
                        payment.createdAt,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Amount
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryBlack,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.primaryGold.withOpacity(0.1),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Amount',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: AppColors.textGray,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'ETB ${payment.amount.toStringAsFixed(2)}',
                          style: GoogleFonts.inter(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Details
                  _buildDetailItem(
                    label: 'Payment Type',
                    value: payment.paymentType.toUpperCase(),
                  ),
                  _buildDetailItem(
                    label: 'Payment Method',
                    value: payment.paymentMethod.toUpperCase(),
                  ),
                  _buildDetailItem(
                    label: 'Month/Year',
                    value: payment.monthYear,
                  ),
                  if (payment.txRef != null)
                    _buildDetailItem(
                      label: 'Transaction Reference',
                      value: payment.txRef!,
                    ),
                  if (payment.adminNotes != null)
                    _buildDetailItem(
                      label: 'Admin Notes',
                      value: payment.adminNotes!,
                    ),
                  if (payment.approvedBy != null) ...[
                    _buildDetailItem(
                      label: 'Approved By',
                      value: payment.approvedBy!,
                    ),
                    _buildDetailItem(
                      label: 'Approval Date',
                      value: payment.approvalDate!,
                    ),
                  ],
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildDetailItem({
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.textGray,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.textWhite,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}