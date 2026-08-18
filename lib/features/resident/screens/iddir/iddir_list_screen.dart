
// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../resident/cubits/iddir_cubit.dart';
import '../../../resident/cubits/iddir_state.dart';
import '../../../resident/widgets/common/resident_app_bar.dart';
import '../../../resident/widgets/common/loading_indicator.dart';
import '../../../resident/widgets/common/error_widget.dart';
import '../../../resident/widgets/common/empty_state_widget.dart';
import '../../../resident/widgets/iddir/iddir_card.dart';
import '../../../../shared/theme/colors.dart';
import 'iddir_detail_screen.dart';

class IddirListScreen extends StatefulWidget {
  const IddirListScreen({super.key});

  @override
  State<IddirListScreen> createState() => _IddirListScreenState();
}

class _IddirListScreenState extends State<IddirListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<IddirCubit>().loadMyIddirGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResidentAppBar(
        title: 'Iddir Groups',
        onNotificationTap: () {},
        onProfileTap: () {},
      ),
      body: BlocBuilder<IddirCubit, IddirState>(
        builder: (context, state) {
          if (state is IddirLoading) {
            return const LoadingIndicator(message: 'Loading Iddir groups...');
          }

          if (state is IddirError) {
            return ResidentErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<IddirCubit>().loadMyIddirGroups();
              },
            );
          }

          if (state is IddirListLoaded) {
            final groups = state.groups;

            if (groups.isEmpty) {
              return const EmptyStateWidget(
                title: 'No Iddir Groups',
                message: 'You are not a member of any Iddir group yet',
                icon: Icons.people_outline,
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: groups.length,
              itemBuilder: (context, index) {
                final group = groups[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: IddirCard(
                    iddir: group,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => IddirDetailScreen(iddirId: group.id),
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