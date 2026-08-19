// ============================================
// FILE: lib/features/resident/widgets/payments/payment_receipt_uploader.dart
// PURPOSE: Payment receipt upload widget
// ============================================

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentReceiptUploader extends StatefulWidget {
  final Function(File?) onFileSelected;
  final File? initialFile;

  const PaymentReceiptUploader({
    super.key,
    required this.onFileSelected,
    this.initialFile,
  });

  @override
  State<PaymentReceiptUploader> createState() => _PaymentReceiptUploaderState();
}

class _PaymentReceiptUploaderState extends State<PaymentReceiptUploader> {
  File? _selectedFile;

  @override
  void initState() {
    super.initState();
    _selectedFile = widget.initialFile;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Receipt (Optional)',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textWhite,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            InkWell(
              onTap: () => _pickImage(ImageSource.camera),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.secondaryBlack,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.primaryGold.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.camera_alt,
                      color: AppColors.primaryGold,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Camera',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppColors.textWhite,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: () => _pickImage(ImageSource.gallery),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.secondaryBlack,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.primaryGold.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.photo_library,
                      color: AppColors.primaryGold,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Gallery',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppColors.textWhite,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_selectedFile != null) ...[
              const SizedBox(width: 8),
              InkWell(
                onTap: () {
                  setState(() {
                    _selectedFile = null;
                    widget.onFileSelected(null);
                  });
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.errorRed.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.errorRed.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    'Remove',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: AppColors.errorRed,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
        if (_selectedFile != null) ...[
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: FileImage(_selectedFile!),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: source,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedFile = File(pickedFile.path);
        widget.onFileSelected(_selectedFile);
      });
    }
  }
}