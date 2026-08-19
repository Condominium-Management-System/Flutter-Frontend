
// ignore_for_file: unused_import

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/lost_found_cubit.dart';
import '../../cubits/lost_found_state.dart';
import '../../widgets/common/resident_app_bar.dart';
import '../../widgets/common/gold_button.dart';
import '../../widgets/common/gold_text_field.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/success_dialog.dart';
import '../../widgets/common/error_widget.dart';
import '../../widgets/lost_found/lost_found_category_selector.dart';
import '../../widgets/lost_found/lost_found_photo_picker.dart';
import '../../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateFoundItemScreen extends StatefulWidget {
  const CreateFoundItemScreen({super.key});

  @override
  State<CreateFoundItemScreen> createState() => _CreateFoundItemScreenState();
}

class _CreateFoundItemScreenState extends State<CreateFoundItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _itemNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _dateController = TextEditingController();
  String _selectedCategory = 'other';
  File? _photoFile;

  @override
  void dispose() {
    _itemNameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResidentAppBar(
        title: 'Report Found Item',
        showBackButton: true,
        onNotificationTap: () {},
        onProfileTap: () {},
      ),
      body: BlocListener<LostFoundCubit, LostFoundState>(
        listener: (context, state) {
          if (state is LostFoundCreated) {
            SuccessDialog.show(
              context,
              title: 'Item Reported!',
              message: 'Your found item has been reported successfully.',
              buttonText: 'Done',
              onButtonPressed: () {
                Navigator.pop(context);
              },
            );
          }
          if (state is LostFoundError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.errorRed,
              ),
            );
          }
        },
        child: BlocBuilder<LostFoundCubit, LostFoundState>(
          builder: (context, state) {
            if (state is LostFoundLoading) {
              return const LoadingIndicator(
                message: 'Submitting...',
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
                      'Found Item Details',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textWhite,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Item Name
                    GoldTextField(
                      label: 'Item Name',
                      hintText: 'What item did you find?',
                      controller: _itemNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Item name is required';
                        }
                        if (value.length < 2) {
                          return 'Item name must be at least 2 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Description
                    GoldTextField(
                      label: 'Description',
                      hintText: 'Describe the item in detail',
                      controller: _descriptionController,
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Description is required';
                        }
                        if (value.length < 5) {
                          return 'Please provide more details';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Category Selector
                    LostFoundCategorySelector(
                      selectedCategory: _selectedCategory,
                      onCategorySelected: (category) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                    ),
                    const SizedBox(height: 20),

                    // Location
                    GoldTextField(
                      label: 'Location',
                      hintText: 'Where did you find it?',
                      controller: _locationController,
                    ),
                    const SizedBox(height: 16),

                    // Date
                    GoldTextField(
                      label: 'Date Found',
                      hintText: 'YYYY-MM-DD',
                      controller: _dateController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Date is required';
                        }
                        return null;
                      },
                      prefixIcon: Icons.calendar_today,
                    ),
                    const SizedBox(height: 20),

                    // Photo
                    LostFoundPhotoPicker(
                      onPhotoSelected: (file) {
                        setState(() {
                          _photoFile = file;
                        });
                      },
                    ),
                    const SizedBox(height: 30),

                    // Submit Button
                    GoldButton(
                      text: 'Report Found Item',
                      variant: ButtonVariant.primary,
                      size: ButtonSize.large,
                      onPressed: _submitReport,
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

  void _submitReport() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LostFoundCubit>().createFoundItem(
            itemName: _itemNameController.text.trim(),
            description: _descriptionController.text.trim(),
            category: _selectedCategory,
            dateLostFound: _dateController.text.trim(),
            location: _locationController.text.trim().isEmpty
                ? null
                : _locationController.text.trim(),
            photoPath: _photoFile?.path,
          );
    }
  }
}