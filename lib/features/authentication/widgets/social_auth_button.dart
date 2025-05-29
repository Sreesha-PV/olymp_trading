import 'package:flutter/material.dart';
import 'package:olymp_trade/core/constants/app_colors.dart';

class SocialAuthButtons extends StatelessWidget {
  const SocialAuthButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Or continue with',
          style: TextStyle(
            // color: Colors.grey[600],
            color: AppColors.buttonDisabled,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _iconButton(Icons.apple, AppColors.background),
            const SizedBox(width: 20),
            _iconButton(Icons.facebook, AppColors.fbIcon),
            const SizedBox(width: 20),
            _iconButton(Icons.g_mobiledata_outlined, AppColors.success),
          ],
        ),
      ],
    );
  }

  
  Widget _iconButton(IconData icon, Color color) {
    return GestureDetector(
      onTap: () {}, 
      child: CircleAvatar(
        radius: 30,
        backgroundColor: AppColors.textColor,
        child: Icon(icon, color: color, size: 30),
      ),
    );
  }
}
