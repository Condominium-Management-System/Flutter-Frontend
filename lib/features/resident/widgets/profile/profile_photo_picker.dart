
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePhotoPicker extends StatefulWidget {
  final Function(File?) onPhotoSelected;
  final File? initialPhoto;
  final String? currentPhotoUrl;

  const ProfilePhotoPicker({
    super.key,
    required this.onPhotoSelected,
    this.initialPhoto,
    this.currentPhotoUrl,
  });

  @override
  State<ProfilePhotoPicker> createState() => _ProfilePhotoPickerState();
}

class _ProfilePhotoPickerState extends State<ProfilePhotoPicker> {
  File? _selectedPhoto;

  @override
  void initState() {
    super.initState();
    _selectedPhoto = widget.initialPhoto;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
            if (_selectedPhoto != null) ...[
              const SizedBox(width: 8),
              InkWell(
                onTap: () {
                  setState(() {
                    _selectedPhoto = null;
                    widget.onPhotoSelected(null);
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
        if (_selectedPhoto != null) ...[
          const SizedBox(height: 12),
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primaryGold,
                width: 3,
              ),
            ),
            child: ClipOval(
              child: Image.file(
                _selectedPhoto!,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ] else if (widget.currentPhotoUrl != null && widget.currentPhotoUrl!.isNotEmpty) ...[
          const SizedBox(height: 12),
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primaryGold,
                width: 3,
              ),
              image: DecorationImage(
                image: NetworkImage(widget.currentPhotoUrl!),
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
      maxWidth: 500,
      maxHeight: 500,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedPhoto = File(pickedFile.path);
        widget.onPhotoSelected(_selectedPhoto);
      });
    }
  }
}