
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../cubits/lost_found_cubit.dart';
import '../../cubits/lost_found_state.dart';
import '../../widgets/common/resident_app_bar.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/error_widget.dart';
import '../../widgets/lost_found/lost_found_status_badge.dart';
import '../../widgets/lost_found/lost_found_type_badge.dart';
import '../../widgets/lost_found/lost_found_claim_button.dart';
import '../../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class LostFoundDetailScreen extends StatefulWidget {
  final String itemId;

  const LostFoundDetailScreen({
    super.key,
    required this.itemId,
  });

  @override
  State<LostFoundDetailScreen> createState() => _LostFoundDetailScreenState();
}

class _LostFoundDetailScreenState extends State<LostFoundDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LostFoundCubit>().loadItemDetails(widget.itemId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResidentAppBar(
        title: 'Item Details',
        showBackButton: true,
        onNotificationTap: () {},
        onProfileTap: () {},
      ),
      body: BlocConsumer<LostFoundCubit, LostFoundState>(
        listener: (context, state) {
          if (state is LostFoundClaimed) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Item claimed successfully!'),
                backgroundColor: AppColors.successGreen,
              ),
            );
            context.read<LostFoundCubit>().loadItemDetails(widget.itemId);
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

          if (state is LostFoundError) {
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
                  // Badges Row
                  Row(
                    children: [
                      LostFoundTypeBadge(type: item.type),
                      const SizedBox(width: 8),
                      LostFoundStatusBadge(status: item.status),
                      const Spacer(),
                      Text(
                        item.createdAt.substring(0, 10),
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Item Name
                  Text(
                    item.itemName,
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textWhite,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Category
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryGold.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item.categoryLabel,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryGold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Description
                  Text(
                    'Description',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textWhite,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.description,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      color: AppColors.textGray,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Location
                  if (item.location != null) ...[
                    Text(
                      'Location',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textWhite,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.location!,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        color: AppColors.textGray,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Photo
                  if (item.photoUrl != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: item.photoUrl!,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          height: 200,
                          color: AppColors.inputBackground,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          height: 200,
                          color: AppColors.inputBackground,
                          child: const Icon(
                            Icons.broken_image,
                            color: AppColors.textDark,
                            size: 48,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),

                  // Claim Button
                  LostFoundClaimButton(
                    itemId: item.id,
                    isClaimed: item.isClaimed,
                    isVerified: item.claimVerified,
                    onClaim: () {
                      _showClaimDialog(context, item.id);
                    },
                    isLoading: state is LostFoundLoading,
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

  void _showClaimDialog(BuildContext context, String itemId) {
    showDialog(
      context: context,
      builder: (context) {
        final controller = TextEditingController();
        return AlertDialog(
          backgroundColor: AppColors.secondaryBlack,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Claim Item',
            style: TextStyle(
              color: AppColors.textWhite,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Please provide a brief description to claim this item:',
                style: TextStyle(
                  color: AppColors.textGray,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                maxLines: 3,
                style: TextStyle(
                  color: AppColors.textWhite,
                ),
                decoration: InputDecoration(
                  hintText: 'Describe why this item belongs to you...',
                  hintStyle: TextStyle(
                    color: AppColors.textDark,
                  ),
                  filled: true,
                  fillColor: AppColors.inputBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.textGray,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final description = controller.text.trim();
                if (description.isNotEmpty) {
                  Navigator.pop(context);
                  context.read<LostFoundCubit>().claimItem(
                        itemId,
                        claimDescription: description,
                      );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please provide a claim description'),
                      backgroundColor: AppColors.warningYellow,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGold,
                foregroundColor: AppColors.primaryBlack,
              ),
              child: const Text('Submit Claim'),
            ),
          ],
        );
      },
    );
  }
}