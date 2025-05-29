import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:olymp_trade/core/constants/app_colors.dart';
import 'package:olymp_trade/features/authentication/widgets/agreement.dart';
import 'package:olymp_trade/features/authentication/widgets/password_field.dart';
import 'package:olymp_trade/features/authentication/widgets/remember_me_checkbox.dart';
import 'package:olymp_trade/features/authentication/widgets/social_auth_button.dart';
import 'package:olymp_trade/features/provider/authentication_provider.dart';
import '../../trading/trade_screen.dart';

class AuthForm extends StatefulWidget {
  final AuthProvider authProvider;

  const AuthForm({super.key, required this.authProvider});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final ValueNotifier<bool> isPasswordVisible = ValueNotifier(false);

  @override
  void dispose() {
    isPasswordVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = widget.authProvider;
    return Column(
      children: [
        if (authProvider.isRegistering)
          _buildTextField(authProvider.usernameController, "Username"),
        const SizedBox(height: 15),
        _buildTextField(authProvider.emailController, "Email", isEmail: true),
        const SizedBox(height: 15),
        PasswordField(
          controller: authProvider.passwordController,
          isPasswordVisible: isPasswordVisible,
        ),
        if (!authProvider.isRegistering)
          RememberMeCheckbox(authProvider: authProvider),
        const SizedBox(height: 15),
        _buildSubmitButton(authProvider),
        const SizedBox(height: 10),
        const SocialAuthButtons(),
        if (!authProvider.isLoggedIn) ...[
          const SizedBox(height: 15),
          const LegalAgreement(),
        ],
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText,
      {bool isEmail = false}) {
      // return TextFormField(
      return AutoSizeTextField(
      controller: controller,
      style: const TextStyle(color: AppColors.textColor),
      decoration: InputDecoration(
        hintText: hintText,
        // hintStyle: TextStyle(color: Colors.grey[400]),
        hintStyle: TextStyle(color: AppColors.labelColor),
        filled: true,
        fillColor: Colors.grey[850],
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
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
      ),
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return 'Please enter $hintText';
      //   }
      //   if (isEmail &&
      //       !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
      //           .hasMatch(value)) {
      //     return 'Enter a valid email';
      //   }

      //    if (hintText == "Password") {
      //     if (value.length < 8) {
      //       return 'Password must be at least 8 characters long';
      //     }
      //     if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$').hasMatch(value)) {
      //       return 'Password must include uppercase, lowercase, number, and special character';
      //     }
      //   }
      //   return null;
      // },
    );
  }


  Widget _buildSubmitButton(AuthProvider authProvider) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 76, 238, 238),
            Color.fromARGB(255, 74, 231, 43),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ElevatedButton(
        onPressed: () async {
          if (authProvider.formKey.currentState?.validate() ?? false) {
            if (authProvider.isRegistering) {
              try {
                await authProvider.register(
                  authProvider.usernameController.text,
                  authProvider.emailController.text,
                  authProvider.passwordController.text,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Registration successful, please login')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Registration failed: $e')),
                );
              }
            } else {
              try {
                await authProvider.login(
                  authProvider.emailController.text,
                  authProvider.passwordController.text,
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => TradeScreen()),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Login failed: $e')),
                );
              }
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          minimumSize: const Size(double.infinity, 60),
          shadowColor: Colors.transparent,
        ),
        child: Text(
          authProvider.isRegistering ? "Register" : "Login",
          style: const TextStyle(
            fontSize: 20,
            color: AppColors.background,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
