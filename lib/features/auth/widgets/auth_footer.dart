
// ignore_for_file: unused_import, depend_on_referenced_packages

import 'package:flutter/material.dart';
import '../../../shared/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthFooter extends StatelessWidget {
  const AuthFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Terms of Service',
            style: TextStyle(
              color: AppColors.textDark,
              fontSize: 11,
              decoration: TextDecoration.underline,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '|',
              style: TextStyle(
                color: AppColors.textDark,
                fontSize: 11,
              ),
            ),
          ),
          Text(
            'Privacy Policy',
            style: TextStyle(
              color: AppColors.textDark,
              fontSize: 11,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}