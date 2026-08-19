
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/lost_found_cubit.dart';
import '../../cubits/lost_found_state.dart';
import '../../widgets/common/resident_app_bar.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/error_widget.dart';
import '../../widgets/common/empty_state_widget.dart';
import '../../widgets/lost_found/lost_found_card.dart';
import '../../../../shared/theme/colors.dart';
import 'lost_found_detail_screen.dart';

class MyItemsScreen extends StatefulWidget {
  const MyItemsScreen({super.key});

  @override
  State<MyItemsScreen> createState() => _MyItemsScreenState();
}

class _MyItemsScreenState extends State<MyItemsScreen> {
  String _selectedType = 'all';

  @override
  void initState() {
    super.initState();
    context.read<LostFoundCubit>().loadMyItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResidentAppBar(
        title: 'My Items',
        showBackButton: true,
        onNotificationTap: () {},
        onProfileTap: () {},
      ),
      body: BlocBuilder<LostFoundCubit, LostFoundState>(
        builder: (context, state) {
          if (state is LostFoundLoading) {
            return const LoadingIndicator(message: 'Loading your items...');
          }

          if (state is LostFoundError) {
            return ResidentErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<LostFoundCubit>().loadMyItems();
              },
            );
          }

          if (state is LostFoundMyItemsLoaded) {
            final items = state.items;

            if (items.isEmpty) {
              return const EmptyStateWidget(
                title: 'No Items',
                message: 'You haven\'t reported any lost or found items yet',
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
        if (value == 'all') {
          context.read<LostFoundCubit>().loadMyItems();
        } else {
          // Filter local list - since backend may not support type filter for my-items
          // We'll handle this in the UI by filtering the loaded list
        }
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