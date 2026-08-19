
// ignore_for_file: unused_import

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/resident_bloc.dart';
import '../../bloc/resident_state.dart';
import '../../bloc/resident_event.dart';
import '../../widgets/common/resident_app_bar.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/gold_button.dart';
import '../../widgets/common/gold_text_field.dart';
import '../../widgets/profile/profile_avatar.dart';
import '../../widgets/profile/profile_photo_picker.dart';
import '../../../../shared/theme/colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  File? _profileImage;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResidentAppBar(
        title: 'Edit Profile',
        showBackButton: true,
        onNotificationTap: () {},
        onProfileTap: () {},
      ),
      body: BlocConsumer<ResidentBloc, ResidentState>(
        listener: (context, state) {
          if (state is ResidentProfileUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile updated successfully!'),
                backgroundColor: AppColors.successGreen,
              ),
            );
            Navigator.pop(context);
          }
          if (state is ResidentError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.errorRed,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ResidentLoading) {
            return const LoadingIndicator(message: 'Updating profile...');
          }

          // Get current user from state
          final user = state is ResidentProfileLoaded ? state.user : null;

          if (user != null) {
            _nameController.text = user.fullName;
            _phoneController.text = user.phoneNumber;
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Profile Photo
                  ProfilePhotoPicker(
                    onPhotoSelected: (file) {
                      setState(() {
                        _profileImage = file;
                      });
                    },
                    currentPhotoUrl: user?.profilePhoto,
                  ),
                  const SizedBox(height: 24),

                  // Full Name
                  GoldTextField(
                    label: 'Full Name',
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                      if (value.length < 2) {
                        return 'Name must be at least 2 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Phone
                  GoldTextField(
                    label: 'Phone Number',
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone number is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // Save Button
                  GoldButton(
                    text: 'Save Changes',
                    variant: ButtonVariant.primary,
                    size: ButtonSize.large,
                    onPressed: _saveProfile,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _saveProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ResidentBloc>().add(
            ResidentUpdateProfile(
              fullName: _nameController.text.trim(),
              phoneNumber: _phoneController.text.trim(),
              profilePhotoPath: _profileImage?.path,
            ),
          );
    }
  }
}