import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/report_cubit.dart';
import '../../cubits/report_state.dart';
import '../../widgets/common/resident_app_bar.dart';
import '../../widgets/common/gold_button.dart';
import '../../widgets/common/gold_text_field.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/success_dialog.dart';
import '../../widgets/reports/report_category_selector.dart';
import '../../widgets/reports/report_priority_selector.dart';
import '../../widgets/reports/report_photo_picker.dart';
import '../../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateReportScreen extends StatefulWidget {
  const CreateReportScreen({super.key});

  @override
  State<CreateReportScreen> createState() => _CreateReportScreenState();
}

class _CreateReportScreenState extends State<CreateReportScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedCategory = 'plumbing';
  String _selectedPriority = 'medium';
  File? _photoFile;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResidentAppBar(
        title: 'Create Report',
        showBackButton: true,
        onNotificationTap: () {},
        onProfileTap: () {},
      ),
      body: BlocListener<ReportCubit, ReportState>(
        listener: (context, state) {
          if (state is ReportCreated) {
            SuccessDialog.show(
              context,
              title: 'Report Submitted!',
              message: 'Your report has been submitted successfully.',
              buttonText: 'Done',
              onButtonPressed: () {
                Navigator.pop(context);
              },
            );
          }
          if (state is ReportError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.errorRed,
              ),
            );
          }
        },
        child: BlocBuilder<ReportCubit, ReportState>(
          builder: (context, state) {
            if (state is ReportLoading) {
              return const LoadingIndicator(
                message: 'Submitting report...',
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      'Report Details',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textWhite,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Title Field
                    GoldTextField(
                      label: 'Title',
                      hintText: 'Enter a brief title',
                      controller: _titleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Title is required';
                        }
                        if (value.length < 3) {
                          return 'Title must be at least 3 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Description Field
                    GoldTextField(
                      label: 'Description',
                      hintText: 'Describe the issue in detail',
                      controller: _descriptionController,
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Description is required';
                        }
                        if (value.length < 10) {
                          return 'Please provide more details';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Category Selector
                    ReportCategorySelector(
                      selectedCategory: _selectedCategory,
                      onCategorySelected: (category) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                    ),
                    const SizedBox(height: 20),

                    // Priority Selector
                    ReportPrioritySelector(
                      selectedPriority: _selectedPriority,
                      onPrioritySelected: (priority) {
                        setState(() {
                          _selectedPriority = priority;
                        });
                      },
                    ),
                    const SizedBox(height: 20),

                    // Photo Picker
                    ReportPhotoPicker(
                      onPhotoSelected: (file) {
                        setState(() {
                          _photoFile = file;
                        });
                      },
                    ),
                    const SizedBox(height: 30),

                    // Submit Button
                    GoldButton(
                      text: 'Submit Report',
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
      context.read<ReportCubit>().createReport(
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim(),
            category: _selectedCategory,
            priority: _selectedPriority,
            photoPath: _photoFile?.path,
          );
    }
  }
}
