
// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../resident/cubits/equb_cubit.dart';
import '../../../resident/cubits/equb_state.dart';
import '../../../resident/widgets/common/resident_app_bar.dart';
import '../../../resident/widgets/common/loading_indicator.dart';
import '../../../resident/widgets/common/error_widget.dart';
import '../../../resident/widgets/common/empty_state_widget.dart';
import '../../../resident/widgets/equb/equb_card.dart';
import '../../../../shared/theme/colors.dart';
import 'equb_detail_screen.dart';

class EqubListScreen extends StatefulWidget {
  const EqubListScreen({super.key});

  @override
  State<EqubListScreen> createState() => _EqubListScreenState();
}

class _EqubListScreenState extends State<EqubListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EqubCubit>().loadMyEqubGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResidentAppBar(
        title: 'Equb Groups',
        onNotificationTap: () {},
        onProfileTap: () {},
      ),
      body: BlocBuilder<EqubCubit, EqubState>(
        builder: (context, state) {
          if (state is EqubLoading) {
            return const LoadingIndicator(message: 'Loading Equb groups...');
          }

          if (state is EqubError) {
            return ResidentErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<EqubCubit>().loadMyEqubGroups();
              },
            );
          }

          if (state is EqubListLoaded) {
            final groups = state.groups;

            if (groups.isEmpty) {
              return const EmptyStateWidget(
                title: 'No Equb Groups',
                message: 'You are not a member of any Equb group yet',
                icon: Icons.attach_money,
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: groups.length,
              itemBuilder: (context, index) {
                final group = groups[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: EqubCard(
                    equb: group,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EqubDetailScreen(equbId: group.id),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}