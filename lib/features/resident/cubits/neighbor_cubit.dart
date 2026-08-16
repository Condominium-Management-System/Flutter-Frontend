
import 'package:flutter_bloc/flutter_bloc.dart';
import 'neighbor_state.dart';
import '../repositories/neighbor_repository.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/services/connectivity_service.dart';

class NeighborCubit extends Cubit<NeighborState> {
  final NeighborRepository _neighborRepository = getIt<NeighborRepository>();
  final ConnectivityService _connectivityService = getIt<ConnectivityService>();

  NeighborCubit() : super(NeighborInitial());

  Future<void> loadNeighbors({String? search}) async {
    emit(NeighborLoading());

    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const NeighborError(message: 'No internet connection.'));
        return;
      }

      final neighbors = await _neighborRepository.getNeighbors(search: search);
      emit(NeighborListLoaded(neighbors: neighbors));
    } catch (e) {
      emit(NeighborError(message: e.toString()));
    }
  }

  Future<void> loadNeighborDetails(String id) async {
    emit(NeighborLoading());

    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const NeighborError(message: 'No internet connection.'));
        return;
      }

      final neighbor = await _neighborRepository.getNeighborDetails(id);
      emit(NeighborDetailsLoaded(neighbor: neighbor));
    } catch (e) {
      emit(NeighborError(message: e.toString()));
    }
  }

  void clearError() {
    if (state is NeighborError) {
      emit(NeighborInitial());
    }
  }
}