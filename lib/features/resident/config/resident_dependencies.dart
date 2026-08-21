 // ignore_for_file: unused_import

import 'package:get_it/get_it.dart';
import 'package:home_axis/features/resident/cubits/lost_found_state.dart';
import '../bloc/resident_bloc.dart';
import '../cubits/dashboard_cubit.dart';
import '../cubits/payment_cubit.dart';
import '../cubits/announcement_cubit.dart';
import '../cubits/report_cubit.dart';
import '../cubits/equb_cubit.dart';
import '../cubits/iddir_cubit.dart';
import '../cubits/lost_found_cubit.dart';
import '../cubits/chat_cubit.dart';
import '../cubits/notification_cubit.dart';
import '../cubits/neighbor_cubit.dart';
import '../repositories/dashboard_repository.dart';
import '../repositories/payment_repository.dart';
import '../repositories/announcement_repository.dart';
import '../repositories/report_repository.dart';
import '../repositories/equb_repository.dart';
import '../repositories/iddir_repository.dart';
import '../repositories/lost_found_repository.dart';
import '../repositories/chat_repository.dart';
import '../repositories/notification_repository.dart';
import '../repositories/neighbor_repository.dart';
import '../repositories/resident_repository.dart';
import '../services/dashboard_api_service.dart';
import '../services/payment_api_service.dart';
import '../services/announcement_api_service.dart';
import '../services/report_api_service.dart';
import '../services/equb_api_service.dart';
import '../services/iddir_api_service.dart';
import '../services/lost_found_api_service.dart';
import '../services/chat_api_service.dart';
import '../services/notification_api_service.dart';
import '../services/neighbor_api_service.dart';
import '../services/resident_api_service.dart';

final GetIt getIt = GetIt.instance;

class ResidentDependencies {
  static void register() {
    // API SERVICES
    getIt.registerLazySingleton<ResidentApiService>(() => ResidentApiService());
    getIt.registerLazySingleton<DashboardApiService>(() => DashboardApiService());
    getIt.registerLazySingleton<PaymentApiService>(() => PaymentApiService());
    getIt.registerLazySingleton<AnnouncementApiService>(() => AnnouncementApiService());
    getIt.registerLazySingleton<ReportApiService>(() => ReportApiService());
    getIt.registerLazySingleton<EqubApiService>(() => EqubApiService());
    getIt.registerLazySingleton<IddirApiService>(() => IddirApiService());
    getIt.registerLazySingleton<LostFoundApiService>(() => LostFoundApiService());
    getIt.registerLazySingleton<ChatApiService>(() => ChatApiService());
    getIt.registerLazySingleton<NotificationApiService>(() => NotificationApiService());
    getIt.registerLazySingleton<NeighborApiService>(() => NeighborApiService());

    // REPOSITORIES
    getIt.registerLazySingleton<ResidentRepository>(() => ResidentRepository());
    getIt.registerLazySingleton<DashboardRepository>(() => DashboardRepository());
    getIt.registerLazySingleton<PaymentRepository>(() => PaymentRepository());
    getIt.registerLazySingleton<AnnouncementRepository>(() => AnnouncementRepository());
    getIt.registerLazySingleton<ReportRepository>(() => ReportRepository());
    getIt.registerLazySingleton<EqubRepository>(() => EqubRepository());
    getIt.registerLazySingleton<IddirRepository>(() => IddirRepository());
    getIt.registerLazySingleton<LostFoundRepository>(() => LostFoundRepository());
    getIt.registerLazySingleton<ChatRepository>(() => ChatRepository());
    getIt.registerLazySingleton<NotificationRepository>(() => NotificationRepository());
    getIt.registerLazySingleton<NeighborRepository>(() => NeighborRepository());
    getIt.registerFactory<ResidentBloc>(() => ResidentBloc());
    getIt.registerFactory<DashboardCubit>(() => DashboardCubit());
    getIt.registerFactory<PaymentCubit>(() => PaymentCubit());
    getIt.registerFactory<AnnouncementCubit>(() => AnnouncementCubit());
    getIt.registerFactory<ReportCubit>(() => ReportCubit());
    getIt.registerFactory<EqubCubit>(() => EqubCubit());
    getIt.registerFactory<IddirCubit>(() => IddirCubit());
    getIt.registerFactory<LostFoundCubit>(() => LostFoundCubit());
    getIt.registerFactory<ChatCubit>(() => ChatCubit());
    getIt.registerFactory<NotificationCubit>(() => NotificationCubit());
    getIt.registerFactory<NeighborCubit>(() => NeighborCubit());
  }
}