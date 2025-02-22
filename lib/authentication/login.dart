import 'package:flutter/material.dart';
import 'package:olymp_trade/screens/dashboard_screen.dart';
import 'package:provider/provider.dart';
import '../screens/provider/user_provider.dart';


class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey=GlobalKey<FormState>();
  final String correctPassword = "password123";

  

  LoginScreen({super.key});  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(
                context,
                controller: usernameController,
                hintText: 'Username',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              _buildTextField(
                context,
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
            const SizedBox(height: 16),  
            ElevatedButton(
              onPressed: () {
                final username = usernameController.text;
                final password = passwordController.text;

                if (password == correctPassword) {
                  
                  Provider.of<UserProvider>(context, listen: false)
                      .login(username, password);
               
                
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TradeScreen()));
                } else {
                 
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Incorrect password")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(50,50),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))
              ),
              child: const Text("Login",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold
              ),),
            ),
          ],
        ),
      ),
    )
    );
  }

  

  Widget _buildTextField(
    BuildContext context, {
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    Color textColor = Colors.black,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            hintStyle: const TextStyle(color: Colors.black),
          ),
          validator: validator,
        ),
      ),
    );
  }
}
