import 'package:flutter/material.dart';
import 'package:olymp_trade/core/constants/app_colors.dart';
import 'package:olymp_trade/features/provider/authentication_provider.dart';


class RememberMeCheckbox extends StatelessWidget {
  final AuthProvider authProvider;

  const RememberMeCheckbox({super.key, required this.authProvider});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: authProvider.rememberMe,
          onChanged: (val) => authProvider.toggleRememberMe(val ?? false),
          activeColor: AppColors.focusColor,
        ),
        const Text(
          'Do Not Remember me',
          style: TextStyle(color: AppColors.textColor),
        ),
      ],
    );
  }
}
