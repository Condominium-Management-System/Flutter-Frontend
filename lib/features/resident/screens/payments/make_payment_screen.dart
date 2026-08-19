
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/payment_cubit.dart';
import '../../cubits/payment_state.dart';
import '../../widgets/common/resident_app_bar.dart';
import '../../widgets/common/gold_button.dart';
import '../../widgets/common/gold_text_field.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/success_dialog.dart';
import '../../widgets/payments/payment_type_selector.dart';
import '../../widgets/payments/payment_method_selector.dart';
import '../../widgets/payments/payment_receipt_uploader.dart';
import '../../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class MakePaymentScreen extends StatefulWidget {
  const MakePaymentScreen({super.key});

  @override
  State<MakePaymentScreen> createState() => _MakePaymentScreenState();
}

class _MakePaymentScreenState extends State<MakePaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedType = 'service_charge';
  String _selectedMethod = 'cbe';
  final _amountController = TextEditingController();
  final _monthController = TextEditingController();
  File? _receiptFile;

  @override
  void dispose() {
    _amountController.dispose();
    _monthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResidentAppBar(
        title: 'Make Payment',
        showBackButton: true,
        onNotificationTap: () {},
        onProfileTap: () {},
      ),
      body: BlocListener<PaymentCubit, PaymentState>(
        listener: (context, state) {
          if (state is PaymentCreated) {
            SuccessDialog.show(
              context,
              title: 'Payment Submitted!',
              message: 'Your payment has been submitted successfully and is pending approval.',
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
        child: BlocBuilder<PaymentCubit, PaymentState>(
          builder: (context, state) {
            if (state is PaymentLoading) {
              return const LoadingIndicator(
                message: 'Submitting payment...',
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment Details',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textWhite,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Payment Type
                    Text(
                      'Payment Type',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textWhite,
                      ),
                    ),
                    const SizedBox(height: 8),
                    PaymentTypeSelector(
                      selectedType: _selectedType,
                      onTypeSelected: (type) {
                        setState(() {
                          _selectedType = type;
                        });
                      },
                    ),
                    const SizedBox(height: 20),

                    // Amount
                    GoldTextField(
                      label: 'Amount',
                      hintText: 'Enter amount in ETB',
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Amount is required';
                        }
                        final amount = double.tryParse(value);
                        if (amount == null || amount <= 0) {
                          return 'Please enter a valid amount';
                        }
                        return null;
                      },
                      prefixIcon: Icons.attach_money,
                    ),
                    const SizedBox(height: 16),

                    // Month/Year
                    GoldTextField(
                      label: 'Month/Year',
                      hintText: 'MM-YYYY (e.g., 12-2024)',
                      controller: _monthController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Month/Year is required';
                        }
                        final regex = RegExp(r'^(0[1-9]|1[0-2])-(20[2-9][0-9])$');
                        if (!regex.hasMatch(value)) {
                          return 'Invalid format. Use MM-YYYY';
                        }
                        return null;
                      },
                      prefixIcon: Icons.calendar_today,
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
                      text: 'Submit Payment',
                      variant: ButtonVariant.primary,
                      size: ButtonSize.large,
                      onPressed: _submitPayment,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _submitPayment() {
    if (_formKey.currentState?.validate() ?? false) {
      final amount = double.parse(_amountController.text.trim());
      final monthYear = _monthController.text.trim();

      context.read<PaymentCubit>().makePayment(
            paymentType: _selectedType,
            amount: amount,
            paymentMethod: _selectedMethod,
            monthYear: monthYear,
            receiptPath: _receiptFile?.path,
          );
    }
  }
}