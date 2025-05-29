import 'package:flutter/material.dart';
import 'package:olymp_trade/core/constants/app_colors.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final ValueNotifier<bool> isPasswordVisible;

  const PasswordField({
    super.key,
    required this.controller,
    required this.isPasswordVisible,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isPasswordVisible,
      builder: (context, visible, _) {
        return TextFormField(
          controller: controller,
          obscureText: !visible,
          style: const TextStyle(color: AppColors.textColor),
          decoration: InputDecoration(
            hintText: "Password",
            // hintStyle: TextStyle(color: Colors.grey[400]),
            hintStyle: TextStyle(color: AppColors.labelColor),
            filled: true,
            // fillColor: Colors.grey[850],
            fillColor: AppColors.fillColor,
             enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: AppColors.borderColor, width: 2),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: AppColors.focusColor),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: AppColors.error, width: 2),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                visible ? Icons.visibility : Icons.visibility_off,
                color: AppColors.textColor,
              ),
              onPressed: () => isPasswordVisible.value = !visible,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.borderColor),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            } else if (value.length < 8) {
              return 'Password must be at least 8 characters long';
            }
            return null;
          },
        );
      },
    );
  }
}
