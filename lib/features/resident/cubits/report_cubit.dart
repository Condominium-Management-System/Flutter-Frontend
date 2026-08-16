
import 'package:flutter_bloc/flutter_bloc.dart';
import 'report_state.dart';
import '../repositories/report_repository.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/services/connectivity_service.dart';

class ReportCubit extends Cubit<ReportState> {
  final ReportRepository _reportRepository = getIt<ReportRepository>();
  final ConnectivityService _connectivityService = getIt<ConnectivityService>();

  ReportCubit() : super(ReportInitial());

  Future<void> loadReports({
    String? status,
    String? category,
    int page = 1,
    int limit = 20,
  }) async {
    emit(ReportLoading());

    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const ReportError(message: 'No internet connection.'));
        return;
      }

      final reports = await _reportRepository.getMyReports(
        status: status,
        category: category,
        page: page,
        limit: limit,
      );
      emit(ReportListLoaded(reports: reports));
    } catch (e) {
      emit(ReportError(message: e.toString()));
    }
  }

  Future<void> loadReportDetails(String id) async {
    emit(ReportLoading());

    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const ReportError(message: 'No internet connection.'));
        return;
      }

      final report = await _reportRepository.getReportDetails(id);
      emit(ReportDetailsLoaded(report: report));
    } catch (e) {
      emit(ReportError(message: e.toString()));
    }
  }

  Future<void> createReport({
    required String title,
    required String description,
    required String category,
    required String priority,
    String? photoPath,
  }) async {
    emit(ReportLoading());

    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const ReportError(message: 'No internet connection.'));
        return;
      }

      final report = await _reportRepository.createReport(
        title: title,
        description: description,
        category: category,
        priority: priority,
        photoPath: photoPath,
      );
      emit(ReportCreated(report: report));
    } catch (e) {
      emit(ReportError(message: e.toString()));
    }
  }

  void clearError() {
    if (state is ReportError) {
      emit(ReportInitial());
    }
  }

  void reset() {
    emit(ReportInitial());
  }
}