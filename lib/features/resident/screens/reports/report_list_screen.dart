
// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/report_cubit.dart';
import '../../cubits/report_state.dart';
import '../../widgets/common/resident_app_bar.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/error_widget.dart';
import '../../widgets/common/empty_state_widget.dart';
import '../../widgets/reports/report_card.dart';
import '../../widgets/common/gold_button.dart';
import '../../../../shared/theme/colors.dart';
import 'report_detail_screen.dart';
import 'create_report_screen.dart';

class ReportListScreen extends StatefulWidget {
  const ReportListScreen({super.key});

  @override
  State<ReportListScreen> createState() => _ReportListScreenState();
}

class _ReportListScreenState extends State<ReportListScreen> {
  String _selectedStatus = 'all';

  @override
  void initState() {
    super.initState();
    context.read<ReportCubit>().loadReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResidentAppBar(
        title: 'My Reports',
        onNotificationTap: () {},
        onProfileTap: () {},
      ),
      body: BlocBuilder<ReportCubit, ReportState>(
        builder: (context, state) {
          if (state is ReportLoading) {
            return const LoadingIndicator(message: 'Loading reports...');
          }

          if (state is ReportError) {
            return ResidentErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<ReportCubit>().loadReports();
              },
            );
          }

          if (state is ReportListLoaded) {
            final reports = state.reports;

            if (reports.isEmpty) {
              return EmptyStateWidget(
                title: 'No Reports',
                message: 'You haven\'t created any reports yet',
                icon: Icons.report_problem_outlined,
                actionLabel: 'Create Report',
                onAction: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CreateReportScreen(),
                    ),
                  );
                },
              );
            }

            return Column(
              children: [
                // Filter Chips
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip('All', 'all'),
                        const SizedBox(width: 8),
                        _buildFilterChip('Reported', 'reported'),
                        const SizedBox(width: 8),
                        _buildFilterChip('In Progress', 'in_progress'),
                        const SizedBox(width: 8),
                        _buildFilterChip('Resolved', 'resolved'),
                      ],
                    ),
                  ),
                ),

                // Report List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: reports.length,
                    itemBuilder: (context, index) {
                      final report = reports[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: ReportCard(
                          report: report,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ReportDetailScreen(
                                  reportId: report.id,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CreateReportScreen(),
            ),
          );
        },
        backgroundColor: AppColors.primaryGold,
        foregroundColor: AppColors.primaryBlack,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _selectedStatus == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedStatus = value;
        });
        context.read<ReportCubit>().loadReports(
              status: value == 'all' ? null : value,
            );
      },
      backgroundColor: AppColors.secondaryBlack,
      selectedColor: AppColors.primaryGold.withOpacity(0.2),
      labelStyle: TextStyle(
        color: isSelected ? AppColors.primaryGold : AppColors.textGray,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
      side: BorderSide(
        color: isSelected ? AppColors.primaryGold : AppColors.textDark,
      ),
    );
  }
}