

import 'package:flutter/material.dart';
import 'package:olymp_trade/core/constants/app_colors.dart';
import 'package:olymp_trade/features/authentication/widgets/auth_form.dart';
import 'package:olymp_trade/features/authentication/widgets/toggle_button_section.dart';
import 'package:olymp_trade/features/provider/authentication_provider.dart';
// import 'package:olymp_trade/features/provider/themedata_provider.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    // final themeProvider=Provider.of<ThemeProvider>(context,listen: false);
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Theme"),
      //   actions: [
      //     Switch(
      //       value: themeProvider.isDarkMode, 
      //       onChanged: (value){
      //         themeProvider.toggleTheme(value);
      //       })
      //   ],
      // ),
      backgroundColor: AppColors.cardBackground,
      body: Center(
        child: Container(
          width: screenWidth > 600 ? 400 : screenWidth * 0.85,
          height: screenHeight * 0.75,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(color: AppColors.shadowColor, blurRadius: 5, spreadRadius: 2)
            ],
          ),
          child: Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              return Form(
                key: authProvider.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ToggleButtonsWidget(authProvider: authProvider),
                    const SizedBox(height: 20),
                    AuthForm(authProvider: authProvider),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
