
// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/common/resident_bottom_nav.dart';
import '../dashboard/resident_dashboard_screen.dart';
import '../payments/payment_list_screen.dart';
import '../equb/equb_list_screen.dart';
import '../announcements/announcement_list_screen.dart';
import '../profile/profile_screen.dart';

class ResidentHomeScreen extends StatefulWidget {
  const ResidentHomeScreen({super.key});

  @override
  State<ResidentHomeScreen> createState() => _ResidentHomeScreenState();
}

class _ResidentHomeScreenState extends State<ResidentHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    ResidentDashboardScreen(),
    PaymentListScreen(),
    EqubListScreen(),
    AnnouncementListScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: ResidentBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}