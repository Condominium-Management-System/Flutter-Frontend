
// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/payment_cubit.dart';
import '../../cubits/payment_state.dart';
import '../../widgets/common/resident_app_bar.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/error_widget.dart';
import '../../widgets/common/empty_state_widget.dart';
import '../../widgets/payments/payment_card.dart';
import '../../widgets/payments/payment_status_badge.dart';
import '../../widgets/common/gold_button.dart';
import '../../../../shared/theme/colors.dart';
import 'make_payment_screen.dart';
import 'payment_detail_screen.dart';

class PaymentListScreen extends StatefulWidget {
  const PaymentListScreen({super.key});

  @override
  State<PaymentListScreen> createState() => _PaymentListScreenState();
}

class _PaymentListScreenState extends State<PaymentListScreen> {
  String _selectedStatus = 'all';

  @override
  void initState() {
    super.initState();
    context.read<PaymentCubit>().loadPayments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResidentAppBar(
        title: 'Payments',
        onNotificationTap: () {},
        onProfileTap: () {},
      ),
      body: BlocConsumer<PaymentCubit, PaymentState>(
        listener: (context, state) {
          if (state is PaymentError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.errorRed,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is PaymentLoading) {
            return const LoadingIndicator(message: 'Loading payments...');
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
            final filteredPayments = _selectedStatus == 'all'
                ? state.payments
                : state.payments.where((p) => p.status == _selectedStatus).toList();

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
                        _buildFilterChip('Pending', 'pending'),
                        const SizedBox(width: 8),
                        _buildFilterChip('Approved', 'approved'),
                        const SizedBox(width: 8),
                        _buildFilterChip('Rejected', 'rejected'),
                      ],
                    ),
                  ),
                ),

                // Payment List
                Expanded(
                  child: filteredPayments.isEmpty
                      ? const EmptyStateWidget(
                          title: 'No Payments',
                          message: 'You have no payments in this category',
                          icon: Icons.payments_outlined,
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: filteredPayments.length,
                          itemBuilder: (context, index) {
                            final payment = filteredPayments[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Card(
                                color: AppColors.secondaryBlack,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  title: Text(
                                    'Payment #${payment.id}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Text(
                                    payment.status,
                                    style: const TextStyle(
                                      color: AppColors.textGray,
                                    ),
                                  ),
                                  trailing: PaymentStatusBadge(
                                    status: payment.status,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => PaymentDetailScreen(
                                          paymentId: payment.id,
                                        ),
                                      ),
                                    );
                                  },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const MakePaymentScreen(),
            ),
          );
        },
        backgroundColor: AppColors.primaryGold,
        foregroundColor: AppColors.primaryBlack,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _selectedStatus == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedStatus = value;
        });
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