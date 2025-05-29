import 'package:flutter/material.dart';
import 'package:olymp_trade/core/constants/app_colors.dart';

class LegalAgreement extends StatelessWidget {
  const LegalAgreement({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          // color: Colors.grey[600],
          color: AppColors.labelColor,
          fontSize: 14,
        ),
        children: const [
          TextSpan(
            text: 'By pressing Register, you confirm that you are of legal age and accept the '
            ),
          TextSpan(
            text: 'Service Agreement and Privacy Policy',
            style: TextStyle(color: AppColors.focusColor),
          ),
        ],
      ),
    );
  }
}
