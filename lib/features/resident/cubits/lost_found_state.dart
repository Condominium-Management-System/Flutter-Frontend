
// ignore_for_file: unused_import

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_axis/features/resident/cubits/lost_found_cubit.dart';
import 'lost_found_state.dart';
import '../repositories/lost_found_repository.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/services/connectivity_service.dart';

class LostFoundCubit extends Cubit<LostFoundState> {
  final LostFoundRepository _lostFoundRepository = getIt<LostFoundRepository>();
  final ConnectivityService _connectivityService = getIt<ConnectivityService>();

  LostFoundCubit() : super(LostFoundInitial());

  Future<void> loadItems({
    String? type,
    String? status,
    String? category,
    String? search,
    int page = 1,
    int limit = 20,
  }) async {
    emit(LostFoundLoading());

    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const LostFoundError(message: 'No internet connection.'));
        return;
      }

      final items = await _lostFoundRepository.getItems(
        type: type,
        status: status,
        category: category,
        search: search,
        page: page,
        limit: limit,
      );
      emit(LostFoundListLoaded(items: items));
    } catch (e) {
      emit(LostFoundError(message: e.toString()));
    }
  }

  Future<void> loadItemDetails(String id) async {
    emit(LostFoundLoading());

    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const LostFoundError(message: 'No internet connection.'));
        return;
      }

      final item = await _lostFoundRepository.getItemDetails(id);
      emit(LostFoundDetailsLoaded(item: item));
    } catch (e) {
      emit(LostFoundError(message: e.toString()));
    }
  }

  Future<void> createLostItem({
    required String itemName,
    required String description,
    required String category,
    required String dateLostFound,
    String? location,
    String? photoPath,
  }) async {
    emit(LostFoundLoading());

    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const LostFoundError(message: 'No internet connection.'));
        return;
      }

      final item = await _lostFoundRepository.createLostItem(
        itemName: itemName,
        description: description,
        category: category,
        dateLostFound: dateLostFound,
        location: location,
        photoPath: photoPath,
      );
      emit(LostFoundCreated(item: item));
    } catch (e) {
      emit(LostFoundError(message: e.toString()));
    }
  }

  Future<void> createFoundItem({
    required String itemName,
    required String description,
    required String category,
    required String dateLostFound,
    String? location,
    String? photoPath,
  }) async {
    emit(LostFoundLoading());

    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const LostFoundError(message: 'No internet connection.'));
        return;
      }

      final item = await _lostFoundRepository.createFoundItem(
        itemName: itemName,
        description: description,
        category: category,
        dateLostFound: dateLostFound,
        location: location,
        photoPath: photoPath,
      );
      emit(LostFoundCreated(item: item));
    } catch (e) {
      emit(LostFoundError(message: e.toString()));
    }
  }

  Future<void> claimItem(String id, {required String claimDescription}) async {
    emit(LostFoundLoading());

    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const LostFoundError(message: 'No internet connection.'));
        return;
      }

      final success = await _lostFoundRepository.claimItem(id, claimDescription: claimDescription);
      if (success) {
        emit(LostFoundClaimed());
      } else {
        emit(const LostFoundError(message: 'Failed to claim item.'));
      }
    } catch (e) {
      emit(LostFoundError(message: e.toString()));
    }
  }

  Future<void> loadMyItems() async {
    emit(LostFoundLoading());

    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const LostFoundError(message: 'No internet connection.'));
        return;
      }

      final items = await _lostFoundRepository.getMyItems();
      emit(LostFoundMyItemsLoaded(items: items));
    } catch (e) {
      emit(LostFoundError(message: e.toString()));
    }
  }

  void clearError() {
    if (state is LostFoundError) {
      emit(LostFoundInitial());
    }
  }

  void reset() {
    emit(LostFoundInitial());
  }
}