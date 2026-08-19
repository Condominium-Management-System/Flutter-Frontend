
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../cubits/report_cubit.dart';
import '../../cubits/report_state.dart';
import '../../widgets/common/resident_app_bar.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/error_widget.dart';
import '../../widgets/reports/report_status_badge.dart';
import '../../widgets/reports/report_priority_badge.dart';
import '../../../../shared/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportDetailScreen extends StatefulWidget {
  final String reportId;

  const ReportDetailScreen({
    super.key,
    required this.reportId,
  });

  @override
  State<ReportDetailScreen> createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ReportCubit>().loadReportDetails(widget.reportId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResidentAppBar(
        title: 'Report Details',
        showBackButton: true,
        onNotificationTap: () {},
        onProfileTap: () {},
      ),
      body: BlocBuilder<ReportCubit, ReportState>(
        builder: (context, state) {
          if (state is ReportLoading) {
            return const LoadingIndicator(message: 'Loading report details...');
          }

          if (state is ReportError) {
            return ResidentErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<ReportCubit>().loadReportDetails(widget.reportId);
              },
            );
          }

          if (state is ReportDetailsLoaded) {
            final report = state.report;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badges Row
                  Row(
                    children: [
                      ReportStatusBadge(status: report.status),
                      const SizedBox(width: 8),
                      ReportPriorityBadge(priority: report.priority),
                      const Spacer(),
                      Text(
                        report.createdAt.substring(0, 10),
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Title
                  Text(
                    report.title,
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textWhite,
                    ),
                  ),
                  const SizedBox(height: 12),

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
                      report.categoryLabel,
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
                    report.description,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      color: AppColors.textGray,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Photo
                  if (report.photoUrl != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: report.photoUrl!,
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

                  // Resolution Notes (if resolved)
                  if (report.isResolved && report.resolutionNotes != null) ...[
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.successGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.successGreen.withOpacity(0.2),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: AppColors.successGreen,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Resolved',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.successGreen,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            report.resolutionNotes!,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: AppColors.textGray,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}