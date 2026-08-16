
import 'package:flutter_bloc/flutter_bloc.dart';
import 'equb_state.dart';
import '../repositories/equb_repository.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/services/connectivity_service.dart';

class EqubCubit extends Cubit<EqubState> {
  final EqubRepository _equbRepository = getIt<EqubRepository>();
  final ConnectivityService _connectivityService = getIt<ConnectivityService>();

  EqubCubit() : super(EqubInitial());

  Future<void> loadMyEqubGroups() async {
    emit(EqubLoading());

    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const EqubError(message: 'No internet connection.'));
        return;
      }

      final groups = await _equbRepository.getMyEqubGroups();
      emit(EqubListLoaded(groups: groups));
    } catch (e) {
      emit(EqubError(message: e.toString()));
    }
  }

  Future<void> loadEqubDetails(String id) async {
    emit(EqubLoading());

    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const EqubError(message: 'No internet connection.'));
        return;
      }

      final group = await _equbRepository.getEqubDetails(id);
      emit(EqubDetailsLoaded(group: group));
    } catch (e) {
      emit(EqubError(message: e.toString()));
    }
  }

  Future<void> joinEqub(String id) async {
    emit(EqubLoading());

    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const EqubError(message: 'No internet connection.'));
        return;
      }

      final success = await _equbRepository.joinEqub(id);
      if (success) {
        emit(EqubJoined());
      } else {
        emit(const EqubError(message: 'Failed to join Equb group.'));
      }
    } catch (e) {
      emit(EqubError(message: e.toString()));
    }
  }

  void clearError() {
    if (state is EqubError) {
      emit(EqubInitial());
    }
  }

  void reset() {
    emit(EqubInitial());
  }
}