
// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/lost_found_cubit.dart';
import '../../cubits/lost_found_state.dart';
import '../../widgets/common/resident_app_bar.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/error_widget.dart';
import '../../widgets/common/empty_state_widget.dart';
import '../../widgets/lost_found/lost_found_card.dart';
import '../../widgets/common/gold_button.dart';
import '../../../../shared/theme/colors.dart';
import 'lost_found_detail_screen.dart';
import 'create_lost_item_screen.dart';
import 'create_found_item_screen.dart';   // ← ADD THIS

class LostFoundListScreen extends StatefulWidget {
  const LostFoundListScreen({super.key});

  @override
  State<LostFoundListScreen> createState() => _LostFoundListScreenState();
}

class _LostFoundListScreenState extends State<LostFoundListScreen> {
  String _selectedType = 'all';

  @override
  void initState() {
    super.initState();
    context.read<LostFoundCubit>().loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResidentAppBar(
        title: 'Lost & Found',
        onNotificationTap: () {},
        onProfileTap: () {},
      ),
      body: BlocBuilder<LostFoundCubit, LostFoundState>(
        builder: (context, state) {
          if (state is LostFoundLoading) {
            return const LoadingIndicator(message: 'Loading items...');
          }

          if (state is LostFoundError) {
            return ResidentErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<LostFoundCubit>().loadItems();
              },
            );
          }

          if (state is LostFoundListLoaded) {
            final items = state.items;

            if (items.isEmpty) {
              return const EmptyStateWidget(
                title: 'No Items',
                message: 'There are no lost or found items reported',
                icon: Icons.search_outlined,
              );
            }

            return Column(
              children: [
                // Type Filter
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      _buildTypeFilter('All', 'all'),
                      const SizedBox(width: 8),
                      _buildTypeFilter('Lost', 'lost'),
                      const SizedBox(width: 8),
                      _buildTypeFilter('Found', 'found'),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          // Navigate to my items
                        },
                        child: Text(
                          'My Items',
                          style: TextStyle(
                            color: AppColors.primaryGold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Items List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: LostFoundCard(
                          item: item,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => LostFoundDetailScreen(
                                  itemId: item.id,
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
          _showCreateOptions(context);
        },
        backgroundColor: AppColors.primaryGold,
        foregroundColor: AppColors.primaryBlack,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTypeFilter(String label, String value) {
    final isSelected = _selectedType == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedType = value;
        });
        context.read<LostFoundCubit>().loadItems(
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

  void _showCreateOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.secondaryBlack,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            ListTile(
              leading: Icon(
                Icons.search_off,
                color: AppColors.errorRed,
              ),
              title: Text(
                'Report Lost Item',
                style: TextStyle(
                  color: AppColors.textWhite,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CreateLostItemScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.search,
                color: AppColors.successGreen,
              ),
              title: Text(
                'Report Found Item',
                style: TextStyle(
                  color: AppColors.textWhite,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CreateFoundItemScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}