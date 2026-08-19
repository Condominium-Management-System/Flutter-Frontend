
// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../cubits/payment_cubit.dart';
import '../../cubits/payment_state.dart';
import '../../widgets/common/resident_app_bar.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/error_widget.dart';
import '../../widgets/common/empty_state_widget.dart';
import '../../widgets/payments/payment_card.dart';
import '../../../../shared/theme/colors.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  String _selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    context.read<PaymentCubit>().loadPayments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResidentAppBar(
        title: 'Payment History',
        showBackButton: true,
        onNotificationTap: () {},
        onProfileTap: () {},
      ),
      body: BlocBuilder<PaymentCubit, PaymentState>(
        builder: (context, state) {
          if (state is PaymentLoading) {
            return const LoadingIndicator(message: 'Loading payment history...');
          }

          if (state is PaymentError) {
            return ResidentErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<PaymentCubit>().loadPayments();
              },
            );
          }

          if (state is PaymentListLoaded) {
            final payments = state.payments;

            return Column(
              children: [
                // Filter Chips
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip('All', 'all'),
                        const SizedBox(width: 8),
                        _buildFilterChip('Approved', 'approved'),
                        const SizedBox(width: 8),
                        _buildFilterChip('Pending', 'pending'),
                        const SizedBox(width: 8),
                        _buildFilterChip('Rejected', 'rejected'),
                      ],
                    ),
                  ),
                ),

                // Payment List
                Expanded(
                  child: payments.isEmpty
                      ? const EmptyStateWidget(
                          title: 'No Payments',
                          message: 'You have no payment history',
                          icon: Icons.history_outlined,
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: payments.length,
                          itemBuilder: (context, index) {
                            final payment = payments[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: GestureDetector(
                                onTap: () {
                                  // Navigate to payment detail
                                },
                                child: Card(
                                  child: ListTile(
                                    title: Text(payment.toString()),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _selectedFilter == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = value;
        });
        context.read<PaymentCubit>().loadPayments(
              status: value == 'all' ? null : value,
            );
      },
      backgroundColor: AppColors.secondaryBlack,
      selectedColor: AppColors.primaryGold.withOpacity(0.2),
      labelStyle: TextStyle(
        color: isSelected ? AppColors.primaryGold : AppColors.textGray,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
      side: BorderSide(
        color: isSelected ? AppColors.primaryGold : AppColors.textDark,
      ),
    );
  }
}