
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/announcement_cubit.dart';
import '../../cubits/announcement_state.dart';
import '../../widgets/common/resident_app_bar.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/error_widget.dart';
import '../../widgets/common/empty_state_widget.dart';
import '../../widgets/announcements/announcement_card.dart';
import '../../widgets/announcements/pinned_announcement_card.dart';
import '../../../../shared/theme/colors.dart';
import 'announcement_detail_screen.dart';

class AnnouncementListScreen extends StatefulWidget {
  const AnnouncementListScreen({super.key});

  @override
  State<AnnouncementListScreen> createState() => _AnnouncementListScreenState();
}

class _AnnouncementListScreenState extends State<AnnouncementListScreen> {
  String _selectedType = 'all';

  @override
  void initState() {
    super.initState();
    context.read<AnnouncementCubit>().loadAnnouncements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResidentAppBar(
        title: 'Announcements',
        onNotificationTap: () {},
        onProfileTap: () {},
      ),
      body: BlocBuilder<AnnouncementCubit, AnnouncementState>(
        builder: (context, state) {
          if (state is AnnouncementLoading) {
            return const LoadingIndicator(message: 'Loading announcements...');
          }

          if (state is AnnouncementError) {
            return ResidentErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<AnnouncementCubit>().loadAnnouncements();
              },
            );
          }

          if (state is AnnouncementListLoaded) {
            final announcements = state.announcements;
            final pinned = announcements.where((a) => a.isPinned).toList();
            final regular = announcements.where((a) => !a.isPinned).toList();

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
                        _buildFilterChip('Emergency', 'emergency'),
                        const SizedBox(width: 8),
                        _buildFilterChip('Event', 'event'),
                        const SizedBox(width: 8),
                        _buildFilterChip('General', 'general'),
                      ],
                    ),
                  ),
                ),

                // Announcement List
                Expanded(
                  child: announcements.isEmpty
                      ? const EmptyStateWidget(
                          title: 'No Announcements',
                          message: 'There are no announcements at the moment',
                          icon: Icons.announcement_outlined,
                        )
                      : ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          children: [
                            // Pinned Announcements
                            if (pinned.isNotEmpty) ...[
                              const Text(
                                '📌 Pinned',
                                style: TextStyle(
                                  color: AppColors.primaryGold,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ...pinned.map((announcement) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: PinnedAnnouncementCard(
                                    announcement: announcement,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => AnnouncementDetailScreen(
                                            announcementId: announcement.id,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }),
                              if (regular.isNotEmpty) ...[
                                const SizedBox(height: 16),
                                const Text(
                                  'Recent',
                                  style: TextStyle(
                                    color: AppColors.textWhite,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ],
                            ...regular.map((announcement) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: AnnouncementCard(
                                  announcement: announcement,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => AnnouncementDetailScreen(
                                          announcementId: announcement.id,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }),
                          ],
                        ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _selectedType == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedType = value;
        });
        context.read<AnnouncementCubit>().loadAnnouncements(
              type: value == 'all' ? null : value,
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