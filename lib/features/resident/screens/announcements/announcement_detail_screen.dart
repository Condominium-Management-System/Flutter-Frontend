
// ignore_for_file: depend_on_referenced_packages

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/announcement_cubit.dart';
import '../../cubits/announcement_state.dart';
import '../../widgets/common/resident_app_bar.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/error_widget.dart';
import '../../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AnnouncementDetailScreen extends StatefulWidget {
  final String announcementId;

  const AnnouncementDetailScreen({
    super.key,
    required this.announcementId,
  });

  @override
  State<AnnouncementDetailScreen> createState() => _AnnouncementDetailScreenState();
}

class _AnnouncementDetailScreenState extends State<AnnouncementDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AnnouncementCubit>().loadAnnouncementDetails(widget.announcementId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResidentAppBar(
        title: 'Announcement',
        showBackButton: true,
        onNotificationTap: () {},
        onProfileTap: () {},
      ),
      body: BlocBuilder<AnnouncementCubit, AnnouncementState>(
        builder: (context, state) {
          if (state is AnnouncementLoading) {
            return const LoadingIndicator(message: 'Loading announcement...');
          }

          if (state is AnnouncementError) {
            return ResidentErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<AnnouncementCubit>().loadAnnouncementDetails(
                      widget.announcementId,
                    );
              },
            );
          }

          if (state is AnnouncementDetailsLoaded) {
            final announcement = state.announcement;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Type Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getTypeColor(announcement.announcementType).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      announcement.typeLabel,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: _getTypeColor(announcement.announcementType),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Title
                  Text(
                    announcement.title,
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textWhite,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Metadata
                  Row(
                    children: [
                      Text(
                        'By ${announcement.createdByRole}',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: AppColors.textGray,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        announcement.createdAt,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Image
                  if (announcement.imageUrl != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: announcement.imageUrl!,
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
                  const SizedBox(height: 16),

                  // Body
                  Text(
                    announcement.body,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: AppColors.textGray,
                      height: 1.6,
                    ),
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

  Color _getTypeColor(String type) {
    switch (type) {
      case 'emergency':
        return AppColors.errorRed;
      case 'event':
        return AppColors.infoBlue;
      case 'celebration':
        return AppColors.successGreen;
      case 'mourning':
        return AppColors.textDark;
      case 'shop_alert':
        return AppColors.warningYellow;
      default:
        return AppColors.primaryGold;
    }
  }
}