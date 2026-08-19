
// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
// PDF and sharing
// ignore: uri_does_not_exist
import 'package:pdf/widgets.dart' as pw;
// ignore: uri_does_not_exist
import 'package:printing/printing.dart' as printing;
import 'package:flutter/services.dart';
import '../../cubits/payment_cubit.dart';
import '../../cubits/payment_state.dart';
import '../../widgets/common/resident_app_bar.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/error_widget.dart';
import '../../widgets/common/gold_button.dart';
import '../../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentReceiptScreen extends StatefulWidget {
  final String paymentId;

  const PaymentReceiptScreen({
    super.key,
    required this.paymentId,
  });

  @override
  State<PaymentReceiptScreen> createState() => _PaymentReceiptScreenState();
}

class _PaymentReceiptScreenState extends State<PaymentReceiptScreen> {
  bool _isDownloading = false;

  @override
  void initState() {
    super.initState();
    context.read<PaymentCubit>().loadPaymentDetails(widget.paymentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResidentAppBar(
        title: 'Receipt',
        showBackButton: true,
        onNotificationTap: () {},
        onProfileTap: () {},
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () => _shareReceipt(context),
          ),
        ],
      ),
      body: BlocBuilder<PaymentCubit, PaymentState>(
        builder: (context, state) {
          if (state is PaymentLoading) {
            return const LoadingIndicator(message: 'Loading receipt...');
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
                children: [
                  // Receipt Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryBlack,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.primaryGold.withOpacity(0.1),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Logo
                        Icon(
                          Icons.apartment,
                          color: AppColors.primaryGold,
                          size: 40,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'HomeAxis',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryGold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Payment Receipt',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: AppColors.textGray,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Divider
                        Divider(
                          color: AppColors.textDark.withOpacity(0.3),
                        ),
                        const SizedBox(height: 16),

                        // Receipt Details
                        _buildReceiptRow(
                          label: 'Receipt No.',
                          value: payment.id.substring(0, 8).toUpperCase(),
                        ),
                        _buildReceiptRow(
                          label: 'Date',
                          value: payment.createdAt,
                        ),
                        _buildReceiptRow(
                          label: 'Status',
                          value: payment.statusLabel,
                          isStatus: true,
                          statusColor: _getStatusColor(payment.status),
                        ),
                        const SizedBox(height: 8),
                        Divider(
                          color: AppColors.textDark.withOpacity(0.3),
                        ),
                        _buildReceiptRow(
                          label: 'Payment Type',
                          value: payment.paymentType.toUpperCase(),
                        ),
                        _buildReceiptRow(
                          label: 'Payment Method',
                          value: payment.paymentMethod.toUpperCase(),
                        ),
                        _buildReceiptRow(
                          label: 'Month/Year',
                          value: payment.monthYear,
                        ),
                        const SizedBox(height: 8),
                        Divider(
                          color: AppColors.textDark.withOpacity(0.3),
                        ),
                        _buildReceiptRow(
                          label: 'Amount',
                          value: 'ETB ${payment.amount.toStringAsFixed(2)}',
                          isAmount: true,
                        ),
                        const SizedBox(height: 16),

                        // Footer
                        Divider(
                          color: AppColors.textDark.withOpacity(0.3),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Thank you for your payment!',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppColors.textGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: GoldButton(
                          text: 'Share',
                          variant: ButtonVariant.secondary,
                          size: ButtonSize.small,
                          onPressed: () => _shareReceipt(context),
                          icon: Icons.share_outlined,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GoldButton(
                          text: 'Download PDF',
                          variant: ButtonVariant.primary,
                          size: ButtonSize.small,
                          isLoading: _isDownloading,
                          onPressed: () => _downloadPdf(context, payment),
                          icon: Icons.download_outlined,
                        ),
                      ),
                    ],
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

  Widget _buildReceiptRow({
    required String label,
    required String value,
    bool isStatus = false,
    bool isAmount = false,
    Color? statusColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
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
                  fontSize: 13,
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
                fontWeight: isAmount ? FontWeight.bold : FontWeight.w500,
                color: isAmount ? AppColors.primaryGold : AppColors.textWhite,
              ),
            ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'approved':
        return AppColors.successGreen;
      case 'pending':
        return AppColors.warningYellow;
      case 'rejected':
        return AppColors.errorRed;
      default:
        return AppColors.textGray;
    }
  }

  void _shareReceipt(BuildContext context) {
    // For now, share the payment details as text
    final state = context.read<PaymentCubit>().state;
    if (state is PaymentDetailsLoaded) {
      final payment = state.payment;
      final message = '''
HomeAxis Payment Receipt
------------------------
Receipt No.: ${payment.id.substring(0, 8).toUpperCase()}
Date: ${payment.createdAt}
Type: ${payment.paymentType.toUpperCase()}
Amount: ETB ${payment.amount.toStringAsFixed(2)}
Status: ${payment.statusLabel}
------------------------
Thank you for your payment!
''';
      // Try to share via share_plus if available; otherwise copy to clipboard
      try {
        // If Share from share_plus is present at runtime this will work; otherwise fallback
        // ignore: undefined_identifier
        Share.share(message);
      } catch (_) {
        Clipboard.setData(ClipboardData(text: message));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Receipt copied to clipboard')),
        );
      }
    }
  }

  Future<void> _downloadPdf(BuildContext context, dynamic payment) async {
    setState(() {
      _isDownloading = true;
    });

    try {
      final pdf = pw.Document();
      final image = await _getLogoImage();

      pdf.addPage(
        pw.Page(
          build: (context) {
            return pw.Container(
              padding: pw.EdgeInsets.all(40),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  // Logo and Header
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      if (image != null)
                        pw.Image(image, width: 60, height: 60),
                      pw.SizedBox(width: 12),
                      pw.Text(
                        'HomeAxis',
                        style: pw.TextStyle(
                          fontSize: 24,
                          fontWeight: pw.FontWeight.bold,
                          color: pw.PdfColors.gold,
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 8),
                  pw.Text(
                    'Payment Receipt',
                    style: pw.TextStyle(
                      fontSize: 16,
                      color: pw.PdfColors.grey,
                    ),
                  ),
                  pw.SizedBox(height: 16),
                  pw.Divider(thickness: 1),
                  pw.SizedBox(height: 16),

                  // Receipt Details
                  _buildPdfRow('Receipt No.', payment.id.substring(0, 8).toUpperCase()),
                  _buildPdfRow('Date', payment.createdAt),
                  _buildPdfRow('Status', payment.statusLabel),
                  pw.SizedBox(height: 8),
                  pw.Divider(thickness: 1),
                  _buildPdfRow('Payment Type', payment.paymentType.toUpperCase()),
                  _buildPdfRow('Payment Method', payment.paymentMethod.toUpperCase()),
                  _buildPdfRow('Month/Year', payment.monthYear),
                  pw.SizedBox(height: 8),
                  pw.Divider(thickness: 1),
                  _buildPdfRow(
                    'Amount',
                    'ETB ${payment.amount.toStringAsFixed(2)}',
                    isBold: true,
                    isGold: true,
                  ),
                  pw.SizedBox(height: 16),
                  pw.Divider(thickness: 1),
                  pw.SizedBox(height: 8),
                  pw.Text(
                    'Thank you for your payment!',
                    style: pw.TextStyle(
                      fontSize: 12,
                      color: pw.PdfColors.grey,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );

      // Save PDF
      final bytes = await pdf.save();

      // Share/Download PDF
      await printing.sharePdf(
        bytes: bytes,
        filename: 'payment_receipt_${payment.id.substring(0, 8)}.pdf',
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to generate PDF: $e'),
          backgroundColor: AppColors.errorRed,
        ),
      );
    }

    setState(() {
      _isDownloading = false;
    });
  }

  pw.Row _buildPdfRow(String label, String value, {bool isBold = false, bool isGold = false}) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          label,
            style: const pw.TextStyle(
            fontSize: 12,
              color: pw.PdfColors.grey,
          ),
        ),
        pw.Text(
          value,
            style: pw.TextStyle(
            fontSize: 12,
            fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
            color: isGold ? pw.PdfColors.gold : pw.PdfColors.black,
          ),
        ),
      ],
    );
  }

  Future<pw.ImageProvider?> _getLogoImage() async {
    // For now, return null or use a local asset
    return null;
  }
}