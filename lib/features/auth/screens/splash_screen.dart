
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../../../shared/theme/colors.dart';
import '../config/auth_routes.dart';
import '../../resident/config/resident_routes.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Check auth status after a delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.read<AuthBloc>().add(AuthCheckStatus());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          Navigator.pushReplacementNamed(context, ResidentRoutes.home);
        } else if (state is AuthUnauthenticated) {
          Navigator.pushReplacementNamed(context, AuthRoutes.login);
        } else if (state is AuthError) {
          Navigator.pushReplacementNamed(context, AuthRoutes.login);
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primaryBlack,
                AppColors.primaryBlack.withOpacity(0.9),
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primaryGold,
                      width: 3,
                    ),
                  ),
                  child: Icon(
                    Icons.apartment,
                    color: AppColors.primaryGold,
                    size: 48,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'HomeAxis',  
                  style: GoogleFonts.inter(
                    color: AppColors.primaryGold,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Smart Living, Golden Standards',
                  style: GoogleFonts.inter(
                    color: AppColors.textGray,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primaryGold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}