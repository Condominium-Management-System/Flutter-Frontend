
import 'package:flutter_bloc/flutter_bloc.dart';
import 'iddir_state.dart';
import '../repositories/iddir_repository.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/services/connectivity_service.dart';

class IddirCubit extends Cubit<IddirState> {
  final IddirRepository _iddirRepository = getIt<IddirRepository>();
  final ConnectivityService _connectivityService = getIt<ConnectivityService>();

  IddirCubit() : super(IddirInitial());

  Future<void> loadMyIddirGroups() async {
    emit(IddirLoading());

    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const IddirError(message: 'No internet connection.'));
        return;
      }

      final groups = await _iddirRepository.getMyIddirGroups();
      emit(IddirListLoaded(groups: groups));
    } catch (e) {
      emit(IddirError(message: e.toString()));
    }
  }

  Future<void> loadIddirDetails(String id) async {
    emit(IddirLoading());

    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const IddirError(message: 'No internet connection.'));
        return;
      }

      final group = await _iddirRepository.getIddirDetails(id);
      emit(IddirDetailsLoaded(group: group));
    } catch (e) {
      emit(IddirError(message: e.toString()));
    }
  }

  Future<void> joinIddir(String id) async {
    emit(IddirLoading());

    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const IddirError(message: 'No internet connection.'));
        return;
      }

      final success = await _iddirRepository.joinIddir(id);
      if (success) {
        emit(IddirJoined());
      } else {
        emit(const IddirError(message: 'Failed to join Iddir group.'));
      }
    } catch (e) {
      emit(IddirError(message: e.toString()));
    }
  }

  void clearError() {
    if (state is IddirError) {
      emit(IddirInitial());
    }
  }

  void reset() {
    emit(IddirInitial());
  }
}