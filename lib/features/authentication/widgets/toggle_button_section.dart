import 'package:flutter/material.dart';
import 'package:olymp_trade/core/constants/app_colors.dart';
import 'package:olymp_trade/features/provider/authentication_provider.dart';


class ToggleButtonsWidget extends StatelessWidget {
  final AuthProvider authProvider;

  const ToggleButtonsWidget({super.key, required this.authProvider});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.fillColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          _buildToggle("Login", !authProvider.isRegistering),
          _buildToggle("Register", authProvider.isRegistering),
        ],
      ),
    );
  }

  Widget _buildToggle(String label, bool selected) {
    return Expanded(
      child: GestureDetector(
        onTap: () => authProvider.toggleAuthMode(),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            // color: selected ? AppColors.borderColor : Colors.grey[850],
             color: selected ? AppColors.borderColor : AppColors.fillColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? AppColors.textColor : AppColors.labelColor,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
