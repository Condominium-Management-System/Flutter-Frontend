// ignore_for_file: library_prefixes, unused_import, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_axis/features/resident/screens/announcements/announcement_detail_screen.dart';
import 'package:home_axis/features/resident/screens/announcements/announcement_list_screen.dart';
import 'package:home_axis/features/resident/screens/chat/chat_list_screen.dart';
import 'package:home_axis/features/resident/screens/chat/chat_room_screen.dart';
import 'package:home_axis/features/resident/screens/dashboard/resident_dashboard_screen.dart';
import 'package:home_axis/features/resident/screens/equb/equb_detail_screen.dart';
import 'package:home_axis/features/resident/screens/equb/equb_list_screen.dart';
import 'package:home_axis/features/resident/screens/home/resident_home_screen.dart';
import 'package:home_axis/features/resident/screens/iddir/iddir_detail_screen.dart';
import 'package:home_axis/features/resident/screens/iddir/iddir_list_screen.dart';
import 'package:home_axis/features/resident/screens/lost_found/lost_found_detail_screen.dart';
import 'package:home_axis/features/resident/screens/lost_found/lost_found_list_screen.dart';
import 'package:home_axis/features/resident/screens/payments/make_payment_screen.dart';
import 'package:home_axis/features/resident/screens/payments/payment_detail_screen.dart';
import 'package:home_axis/features/resident/screens/payments/payment_list_screen.dart';
import 'package:home_axis/features/resident/screens/reports/create_report_screen.dart';
import 'package:home_axis/features/resident/screens/reports/report_detail_screen.dart';
import 'package:home_axis/features/resident/screens/reports/report_list_screen.dart';
import 'core/di/service_locator.dart' hide getIt;
import 'core/blocs/theme_cubit.dart' as coreTheme;
import 'features/auth/auth.dart';
import 'features/auth/config/auth_routes.dart';
import 'features/auth/config/auth_theme.dart';
import 'features/resident/resident.dart' hide getIt, ProfileScreen, EditProfileScreen, ChangePasswordScreen;
import 'package:home_axis/features/auth/screens/change_password_screen.dart' as auth_change_password;
import 'package:home_axis/features/auth/screens/edit_profile_screen.dart' as auth_edit_profile;
import 'package:home_axis/features/auth/screens/profile_screen.dart' as auth_profile;
import 'package:home_axis/features/resident/screens/profile/change_password_screen.dart' as resident_change_password;
import 'package:home_axis/features/resident/screens/profile/edit_profile_screen.dart' as resident_edit_profile;
import 'package:home_axis/features/resident/screens/profile/profile_screen.dart' as resident_profile;
import 'shared/theme/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize service locator (Core)
  await setupServiceLocator();
  // Register auth dependencies
  AuthDependencies.register();

  // Register resident dependencies  // ← ADD THIS
  ResidentDependencies.register();

  // Initialize theme cubit before runApp
  final themeCubit = await coreTheme.ThemeCubit.create();

  runApp(MyApp(themeCubit: themeCubit));
}

class MyApp extends StatelessWidget {
  final coreTheme.ThemeCubit themeCubit;

  const MyApp({super.key, required this.themeCubit});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: themeCubit),
        // AUTH PROVIDERS
        BlocProvider<AuthBloc>(
          create: (context) => getIt<AuthBloc>()..add(AuthCheckStatus()),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => getIt<LoginCubit>(),
        ),
        BlocProvider<RegisterCubit>(
          create: (context) => getIt<RegisterCubit>(),
        ),
        BlocProvider<ForgotPasswordCubit>(
          create: (context) => getIt<ForgotPasswordCubit>(),
        ),
        BlocProvider<ResetPasswordCubit>(
          create: (context) => getIt<ResetPasswordCubit>(),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => getIt<ProfileCubit>(),
        ),

        // RESIDENT PROVIDERS
        BlocProvider<ResidentBloc>(
          create: (context) => getIt<ResidentBloc>(),
        ),
        BlocProvider<DashboardCubit>(
          create: (context) => getIt<DashboardCubit>(),
        ),
        BlocProvider<PaymentCubit>(
          create: (context) => getIt<PaymentCubit>(),
        ),
        BlocProvider<AnnouncementCubit>(
          create: (context) => getIt<AnnouncementCubit>(),
        ),
        BlocProvider<ReportCubit>(
          create: (context) => getIt<ReportCubit>(),
        ),
        BlocProvider<EqubCubit>(
          create: (context) => getIt<EqubCubit>(),
        ),
        BlocProvider<IddirCubit>(
          create: (context) => getIt<IddirCubit>(),
        ),
        BlocProvider<LostFoundCubit>(
          create: (context) => getIt<LostFoundCubit>(),
        ),
        BlocProvider<ChatCubit>(
          create: (context) => getIt<ChatCubit>(),
        ),
        BlocProvider<NotificationCubit>(
          create: (context) => getIt<NotificationCubit>(),
        ),
        BlocProvider<NeighborCubit>(
          create: (context) => getIt<NeighborCubit>(),
        ),
      ],
      child: BlocBuilder<coreTheme.ThemeCubit, ThemeMode>(
        bloc: themeCubit,
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'HomeAxis',
            debugShowCheckedModeBanner: false,
            theme: AuthTheme.lightTheme,
            darkTheme: AuthTheme.darkTheme,
            themeMode: themeMode,
            home: const SplashScreen(),
            onGenerateRoute: (settings) {
              switch (settings.name) {
            // AUTH ROUTES
            case AuthRoutes.login:
              return MaterialPageRoute(
                builder: (_) => const LoginScreen(),
              );
            case AuthRoutes.register:
              return MaterialPageRoute(
                builder: (_) => const RegisterScreen(),
              );
            case AuthRoutes.forgotPassword:
              return MaterialPageRoute(
                builder: (_) => const ForgotPasswordScreen(),
              );
            case AuthRoutes.resetPassword:
              final token = settings.arguments as String? ?? '';
              return MaterialPageRoute(
                builder: (_) => ResetPasswordScreen(token: token),
              );
            case AuthRoutes.profile:
              return MaterialPageRoute(
                builder: (_) => const ProfileScreen(),
              );
            case AuthRoutes.editProfile:
              return MaterialPageRoute(
                builder: (_) => const EditProfileScreen(),
              );
            case AuthRoutes.changePassword:
              return MaterialPageRoute(
                builder: (_) => const ChangePasswordScreen(),
              );

            // RESIDENT ROUTES
            case ResidentRoutes.home:
              return MaterialPageRoute(
                builder: (_) => const ResidentHomeScreen(),
              );
            case ResidentRoutes.dashboard:
              return MaterialPageRoute(
                builder: (_) => const ResidentDashboardScreen(),
              );

            // Payments
            case ResidentRoutes.payments:
              return MaterialPageRoute(
                builder: (_) => const PaymentListScreen(),
              );
            case ResidentRoutes.makePayment:
              return MaterialPageRoute(
                builder: (_) => const MakePaymentScreen(),
              );
            case ResidentRoutes.paymentDetail:
              final id = settings.arguments as String? ?? '';
              return MaterialPageRoute(
                builder: (_) => PaymentDetailScreen(paymentId: id),
              );

            // Announcements
            case ResidentRoutes.announcements:
              return MaterialPageRoute(
                builder: (_) => const AnnouncementListScreen(),
              );
            case ResidentRoutes.announcementDetail:
              final id = settings.arguments as String? ?? '';
              return MaterialPageRoute(
                builder: (_) => AnnouncementDetailScreen(announcementId: id),
              );

            // Reports
            case ResidentRoutes.reports:
              return MaterialPageRoute(
                builder: (_) => const ReportListScreen(),
              );
            case ResidentRoutes.createReport:
              return MaterialPageRoute(
                builder: (_) => const CreateReportScreen(),
              );
            case ResidentRoutes.reportDetail:
              final id = settings.arguments as String? ?? '';
              return MaterialPageRoute(
                builder: (_) => ReportDetailScreen(reportId: id),
              );

            // Equb
            case ResidentRoutes.equbList:
              return MaterialPageRoute(
                builder: (_) => const EqubListScreen(),
              );
            case ResidentRoutes.equbDetail:
              final id = settings.arguments as String? ?? '';
              return MaterialPageRoute(
                builder: (_) => EqubDetailScreen(equbId: id),
              );

            // Iddir
            case ResidentRoutes.iddirList:
              return MaterialPageRoute(
                builder: (_) => const IddirListScreen(),
              );
            case ResidentRoutes.iddirDetail:
              final id = settings.arguments as String? ?? '';
              return MaterialPageRoute(
                builder: (_) => IddirDetailScreen(iddirId: id),
              );

            // Lost & Found
            case ResidentRoutes.lostFound:
              return MaterialPageRoute(
                builder: (_) => const LostFoundListScreen(),
              );
            case ResidentRoutes.lostFoundDetail:
              final id = settings.arguments as String? ?? '';
              return MaterialPageRoute(
                builder: (_) => LostFoundDetailScreen(itemId: id),
              );

            // Chat
            case ResidentRoutes.chatList:
              return MaterialPageRoute(
                builder: (_) => const ChatListScreen(),
              );
            case ResidentRoutes.chatRoom:
              final id = settings.arguments as String? ?? '';
              return MaterialPageRoute(
                builder: (_) => ChatRoomScreen(chatId: id),
              );

            // Profile (Resident)
            case ResidentRoutes.profile:
              return MaterialPageRoute(
                builder: (_) => const ProfileScreen(),
              );
            case ResidentRoutes.editProfile:
              return MaterialPageRoute(
                builder: (_) => const EditProfileScreen(),
              );
            case ResidentRoutes.changePassword:
              return MaterialPageRoute(
                builder: (_) => const ChangePasswordScreen(),
              );

            default:
              return null;
          }
            },
          );
        },
      ),
    );
  }
}
 
