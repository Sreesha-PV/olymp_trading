

import 'package:flutter/material.dart';
import 'package:olymp_trade/features/trading/trade_screen.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});

  final ValueNotifier<bool> isLoginNotifier = ValueNotifier(true);
  final ValueNotifier<bool> rememberMeNotifier = ValueNotifier(false);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? registeredEmail;
  String? registeredPassword;

  @override
  Widget build(BuildContext context) {
    // Get screen width and height
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    _buildToggleButton("Login", true, isLoginNotifier),
                    _buildToggleButton("Register", false, isLoginNotifier),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
           
              _buildForm(isLoginNotifier),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton(
      String title, bool isSelected, ValueNotifier<bool> isLoginNotifier) {
    return Expanded(
      child: ValueListenableBuilder<bool>(
        valueListenable: isLoginNotifier,
        builder: (context, isLogin, child) {
          return GestureDetector(
            onTap: () {
              isLoginNotifier.value = isSelected;
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color:
                    isLogin == isSelected ? Colors.grey[800] : Colors.grey[850],
                borderRadius: BorderRadius.circular(5),
              ),
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color:
                      isLogin == isSelected ? Colors.white : Colors.grey[400],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  
  Widget _buildForm(ValueNotifier<bool> isLoginNotifier) {
    return ValueListenableBuilder<bool>(
      valueListenable: isLoginNotifier,
      builder: (context, isLogin, child) {
        return Column(
          children: [
           
            TextField(
              controller: emailController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Email",
                hintStyle: TextStyle(color: Colors.grey[400]),
                filled: true,
                fillColor: Colors.grey[850],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.grey[700]!),
                ),
              ),
            ),
            const SizedBox(height: 15),

            
            TextField(
              controller: passwordController,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.grey[400]),
                filled: true,
                fillColor: Colors.grey[850],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.grey[700]!),
                ),
                suffixIcon:
                    const Icon(Icons.visibility_off, color: Colors.white),
              ),
            ),
            const SizedBox(height: 15),

           
            if (isLogin)
              Row(
                children: [
                  ValueListenableBuilder<bool>(
                    valueListenable: rememberMeNotifier,
                    builder: (context, isChecked, child) {
                      return Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          rememberMeNotifier.value = value ?? false;
                        },
                        activeColor: Colors.teal,
                      );
                    },
                  ),
                  const Text(
                    'Do Not Remember me',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),

            const SizedBox(height: 15),

            
            Container(
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
                  if (isLogin) {
                    _login(context);
                  } else {
                    _register(isLoginNotifier, context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  minimumSize: const Size(double.infinity, 60),
                  shadowColor: Colors.transparent,
                ),
                child: Text(
                  isLogin ? "Log In" : "Register",
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 15),

           
            if (isLogin)
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    // _showMessage(context, 'Forgot Password functionality.');
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Color.fromARGB(255, 74, 231, 43), fontSize: 14),
                  ),
                ),
              ),
            const SizedBox(height: 15),

            
            if (isLogin)
              const Text(
                'or continue with',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            const SizedBox(height: 15),

            if (isLogin)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _socialIconButton(
                    icon: Icons.apple,
                    color: Colors.black,

                    onPressed: () {},
                  ),
                  const SizedBox(width: 20),
                  _socialIconButton(
                    icon: Icons.facebook,
                    color: Colors.blue,

                    onPressed: () {},
                  ),
                  const SizedBox(width: 20),
                  _socialIconButton(
                    icon: Icons.g_mobiledata_rounded,
                    color: Colors.blue,

                    onPressed: () {},
                  ),
                ],
              ),

            if (!isLogin)
              const Text(
                'Or continue with',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            const SizedBox(height: 15),

            if (!isLogin)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _socialIconButton(
                    icon: Icons.apple,
                    color: Colors.black,
                    onPressed: () {},
                  ),
                  const SizedBox(width: 20),
                  _socialIconButton(
                    icon: Icons.facebook,
                    color: Colors.blue,
                    onPressed: () {},
                  ),
                  const SizedBox(width: 20),
                  _socialIconButton(
                    icon: Icons.g_mobiledata_rounded,
                    color: Colors.blue,
                    onPressed: () {},
                  ),
                ],
              ),

            const SizedBox(height: 15),
          ],
        );
      },
    );
  }

  // Social Media Icon Button
  Widget _socialIconButton({required IconData icon,required Color color, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.white,
        child: Icon(
          icon,
          color: color,
          size: 30,
          // color: Colors.white,
        ),
      ),
    );
  }

  // Register Method
  void _register(ValueNotifier<bool> isLoginNotifier, BuildContext context) {
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      registeredEmail = email;
      registeredPassword = password;

      emailController.clear();
      passwordController.clear();

      _showMessage(context, 'Registration Successful!');
      isLoginNotifier.value = true;
    } else {
      _showMessage(context, 'Please enter both email and password.');
    }
  }

  // Login Method
  void _login(BuildContext context) {
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showMessage(context, 'Please enter both email and password.');
    } else if (registeredEmail == email && registeredPassword == password) {
      _showMessage(context, 'Login Successful!');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TradeScreen()),
      );
    } else {
      _showMessage(context, 'Invalid credentials. Please register first.');
    }
  }

  // Show Snack Bar Message
  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
