import 'package:flutter/material.dart';
import 'package:olymp_trade/features/authentication/authentication_service.dart';
import 'package:olymp_trade/features/trading/trade_screen.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Container(
          width: screenWidth > 600 ? 400 : screenWidth * 0.85,
          height: screenHeight * 0.75,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                spreadRadius: 2,
              )
            ],
          ),
          child: Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              return Form(
                key: authProvider.formKey,  
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildToggleButtons(authProvider),
                    const SizedBox(height: 20),
                    _buildForm(authProvider, context),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButtons(AuthProvider authProvider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          _buildToggleButton("Login", true, authProvider),
          _buildToggleButton("Register", false, authProvider)
     
        ],
      ),
    );
  }

  Widget _buildToggleButton(
    String title,
    bool isSelected,
    AuthProvider authProvider,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          authProvider.isLoggedIn = isSelected;
          authProvider.notifyListeners();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: authProvider.isLoggedIn == isSelected
                ? Colors.grey[800]
                : Colors.grey[850],
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: authProvider.isLoggedIn == isSelected
                  ? Colors.white
                  : Colors.grey[400],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildForm(AuthProvider authProvider, BuildContext context) {
    return Column(
      children: [
        _buildTextField(authProvider.emailController, "Email", isEmail: true),
        const SizedBox(height: 15),
        _buildTextField(authProvider.passwordController, "Password", obscureText: true),
        const SizedBox(height: 15),
        if (authProvider.isLoggedIn) _buildRememberMeCheckBox(authProvider),
        const SizedBox(height: 15),
        _buildSubmitButton(authProvider, context),
        const SizedBox(height: 15),
        if (authProvider.isLoggedIn) ...[
          _buildForgotPasswordLink(context),
          _buildSocialAuthButtons(),
        ] else ...[
          _buildSocialAuthButtons(),
          const SizedBox(height: 15),
          _buildLegalAgreement(),
        ]
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText, {bool obscureText = false, bool isEmail = false}) {
    return TextFormField(
      
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[400]),
        filled: true,
      fillColor: Colors.grey[850],
      
      
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Colors.grey[800]!,width: 2 ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Colors.green,width: 2 ),
    ),
    errorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Colors.red,width: 2),
    ),
    
        suffixIcon: obscureText
            ? const Icon(Icons.visibility_off_outlined, color: Colors.white)
            : null,
          ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $hintText';
        }
        if (isEmail && !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
          return 'Please enter a valid email';
        }
        if (!isEmail && value.length < 8) {
          return 'Password must be at least 8 characters long';
        }
        if (!isEmail && !RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$').hasMatch(value)) {
          return 'Password must include uppercase, lowercase, number, and special character';
        }
        return null;
      },
    );
  }


  Widget _buildRememberMeCheckBox(AuthProvider authProvider) {
    return Row(
      children: [
        Checkbox(
          value: authProvider.rememberMe,
          onChanged: (value) {
            authProvider.toggleRememberMe(value ?? false);
          },
          activeColor: const Color.fromARGB(255, 74, 231, 43),
        ),
        const Text(
          'Do Not Remember me',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(AuthProvider authProvider, BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 76, 238, 238),
            Color.fromARGB(255, 74, 231, 43)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ElevatedButton(
        onPressed: () {
          if (authProvider.formKey.currentState?.validate() ?? false) {
            try {
              if (authProvider.isLoggedIn) {
                authProvider.login(
                  authProvider.emailController.text,
                  authProvider.passwordController.text,
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) =>  TradeScreen()),
                );
              } else {
                authProvider.register(
                  authProvider.emailController.text,
                  authProvider.passwordController.text,
                );
              }
            } catch (e) {
              _showMessage(context, e.toString());
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          minimumSize: const Size(double.infinity, 60),
          shadowColor: Colors.transparent,
        ),
        child: Text(
          authProvider.isLoggedIn ? "Log In" : "Register",
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordLink(context) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
         
        },
        child: const Text(
          'Forgot your Password?',
          style: TextStyle(
            color: Color.fromARGB(255, 74, 231, 43),
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialAuthButtons() {
    return Column(
      children: [
        Text(
          'Or continue with',
          style: TextStyle(color: Colors.grey[600], fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _socialIconButton(icon: Icons.apple, color: Colors.black, onPressed: () {}),
            const SizedBox(width: 20),
            _socialIconButton(icon: Icons.facebook, color: Colors.blue, onPressed: () {}),
            const SizedBox(width: 20),
            _socialIconButton(
              icon: Icons.g_mobiledata_outlined,
              color: Colors.blue, 
              onPressed: () {},),
          ],
        ),
      ],
    );
  }

  Widget _socialIconButton({
    required IconData icon, 
    required Color color,
    required VoidCallback onPressed,}) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.white,
        child: 
        Icon(
          icon,
          color: color,
          size: 30,
        ),
      ),
    );
  }

  Widget _buildLegalAgreement() {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.grey[600], fontSize: 16, fontWeight: FontWeight.bold),
        children: const <TextSpan>[
          TextSpan(
            text: 'By pressing Register, you confirm that you are of legal age and accept the ',
          ),
          TextSpan(
            text: 'Service Agreement and Policy Privacy',
            style: TextStyle(color: Color.fromARGB(255, 74, 231, 43)),
          ),
        ],
      ),
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

}


