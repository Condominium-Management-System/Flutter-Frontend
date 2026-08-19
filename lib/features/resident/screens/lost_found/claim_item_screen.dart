
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../cubits/lost_found_cubit.dart';
import '../../cubits/lost_found_state.dart';
import '../../widgets/common/resident_app_bar.dart';
import '../../widgets/common/gold_button.dart';
import '../../widgets/common/gold_text_field.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/error_widget.dart';
import '../../widgets/common/success_dialog.dart';
import '../../widgets/lost_found/lost_found_type_badge.dart';
import '../../widgets/lost_found/lost_found_status_badge.dart';
import '../../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ClaimItemScreen extends StatefulWidget {
  final String itemId;

  const ClaimItemScreen({
    super.key,
    required this.itemId,
  });

  @override
  State<ClaimItemScreen> createState() => _ClaimItemScreenState();
}

class _ClaimItemScreenState extends State<ClaimItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _claimController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<LostFoundCubit>().loadItemDetails(widget.itemId);
  }

  @override
  void dispose() {
    _claimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResidentAppBar(
        title: 'Claim Item',
        showBackButton: true,
        onNotificationTap: () {},
        onProfileTap: () {},
      ),
      body: BlocConsumer<LostFoundCubit, LostFoundState>(
        listener: (context, state) {
          if (state is LostFoundClaimed) {
            SuccessDialog.show(
              context,
              title: 'Claim Submitted!',
              message: 'Your claim has been submitted for verification.',
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
        builder: (context, state) {
          if (state is LostFoundLoading) {
            return const LoadingIndicator(message: 'Loading item details...');
          }

          if (state is LostFoundError && state.message != '') {
            return ResidentErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<LostFoundCubit>().loadItemDetails(widget.itemId);
              },
            );
          }

          if (state is LostFoundDetailsLoaded) {
            final item = state.item;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Item Preview
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryBlack,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.primaryGold.withOpacity(0.1),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            LostFoundTypeBadge(type: item.type),
                            const SizedBox(width: 8),
                            LostFoundStatusBadge(status: item.status),
                            const Spacer(),
                            Text(
                              item.dateLostFound.substring(0, 10),
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: AppColors.textDark,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          item.itemName,
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textWhite,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.description,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: AppColors.textGray,
                          ),
                        ),
                        if (item.location != null) ...[
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: AppColors.primaryGold,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                item.location!,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: AppColors.textGray,
                                ),
                              ),
                            ],
                          ),
                        ],
                        if (item.photoUrl != null) ...[
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: item.photoUrl!,
                              width: double.infinity,
                              height: 120,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                height: 120,
                                color: AppColors.inputBackground,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                height: 120,
                                color: AppColors.inputBackground,
                                child: const Icon(
                                  Icons.broken_image,
                                  color: AppColors.textDark,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Claim Form
                  Text(
                    'Claim Description',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textWhite,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please provide a detailed description to verify this claim.',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: AppColors.textGray,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Form(
                    key: _formKey,
                    child: GoldTextField(
                      label: 'Claim Description',
                      hintText: 'Describe why this item belongs to you...',
                      controller: _claimController,
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please provide a claim description';
                        }
                        if (value.length < 5) {
                          return 'Description must be at least 5 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Submit Button
                  GoldButton(
                    text: 'Submit Claim',
                    variant: ButtonVariant.primary,
                    size: ButtonSize.large,
                    isLoading: state is LostFoundLoading,
                    onPressed: () {
                      _submitClaim(context);
                    },
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

  void _submitClaim(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LostFoundCubit>().claimItem(
            widget.itemId,
            claimDescription: _claimController.text.trim(),
          );
    }
  }
}