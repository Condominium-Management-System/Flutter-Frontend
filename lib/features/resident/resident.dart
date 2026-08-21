
import 'package:flutter/widgets.dart';
import 'package:home_axis/features/resident/screens/home/resident_home_screen.dart';
export 'config/resident_routes.dart';
export 'config/resident_theme.dart';
export 'config/resident_dependencies.dart';
export 'bloc/resident_bloc.dart';
export 'bloc/resident_event.dart';
export 'bloc/resident_state.dart';
export 'cubits/dashboard_cubit.dart';
export 'cubits/dashboard_state.dart';
export 'cubits/payment_cubit.dart';
export 'cubits/payment_state.dart';
export 'cubits/announcement_cubit.dart';
export 'cubits/announcement_state.dart';
export 'cubits/report_cubit.dart';
export 'cubits/report_state.dart';
export 'cubits/equb_cubit.dart';
export 'cubits/equb_state.dart';
export 'cubits/iddir_cubit.dart';
export 'cubits/iddir_state.dart';
export 'cubits/lost_found_cubit.dart';
export 'cubits/lost_found_state.dart';
export 'cubits/chat_cubit.dart';
export 'cubits/chat_state.dart';
export 'cubits/notification_cubit.dart';
export 'cubits/notification_state.dart';
export 'cubits/neighbor_cubit.dart';
export 'cubits/neighbor_state.dart';
export 'models/dashboard_model.dart';
export 'models/payment_model.dart';
export 'models/announcement_model.dart';
export 'models/report_model.dart';
export 'models/equb_model.dart';
export 'models/equb_member_model.dart';
export 'models/iddir_model.dart';
export 'models/iddir_member_model.dart';
export 'models/lost_found_model.dart';
export 'models/chat_model.dart';
export 'models/message_model.dart';
export 'models/notification_model.dart';
export 'models/neighbor_model.dart';
export 'models/transaction_model.dart';
export 'services/resident_api_service.dart';
export 'services/dashboard_api_service.dart';
export 'services/payment_api_service.dart';
export 'services/announcement_api_service.dart';
export 'services/report_api_service.dart';
export 'services/equb_api_service.dart';
export 'services/iddir_api_service.dart';
export 'services/lost_found_api_service.dart';
export 'services/chat_api_service.dart';
export 'services/notification_api_service.dart';
export 'services/neighbor_api_service.dart';
export 'repositories/resident_repository.dart';
export 'repositories/dashboard_repository.dart';
export 'repositories/payment_repository.dart';
export 'repositories/announcement_repository.dart';
export 'repositories/report_repository.dart';
export 'repositories/equb_repository.dart';
export 'repositories/iddir_repository.dart';
export 'repositories/lost_found_repository.dart';
export 'repositories/chat_repository.dart';
export 'repositories/notification_repository.dart';
export 'repositories/neighbor_repository.dart';
export 'validators/payment_validator.dart';
export 'validators/report_validator.dart';
export 'validators/lost_found_validator.dart';
export 'validators/equb_validator.dart';
export 'validators/resident_validators.dart';
export 'widgets/widgets_export.dart';
export 'screens/screens_export.dart';

class ResidentModule {
  static Future<void> initialize() async {
    // Register dependencies
  }

  static Widget get home => const ResidentHomeScreen();
}