
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_state.dart';
import '../repositories/dashboard_repository.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/services/connectivity_service.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final DashboardRepository _dashboardRepository = getIt<DashboardRepository>();
  final ConnectivityService _connectivityService = getIt<ConnectivityService>();

  DashboardCubit() : super(DashboardInitial());

  Future<void> loadDashboard({bool forceRefresh = false}) async {
    emit(DashboardLoading());

    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const DashboardError(message: 'No internet connection.'));
        return;
      }

      final data = await _dashboardRepository.getDashboard();
      emit(DashboardLoaded(data: data));
    } catch (e) {
      emit(DashboardError(message: e.toString()));
    }
  }

  void clearError() {
    if (state is DashboardError) {
      emit(DashboardInitial());
    }
  }
}