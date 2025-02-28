
// import 'package:flutter/material.dart';
// import 'package:olymp_trade/features/authentication/authentication_service.dart';
// import 'package:olymp_trade/features/authentication/login.dart';
// import 'package:provider/provider.dart';

// class RegistrationScreen extends StatelessWidget {
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   RegistrationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text("Register"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               _buildTextField(
//                 context,
//                 controller: usernameController,
//                 hintText: "Username",
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter username';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 10),
//               _buildTextField(
//                 context,
//                 controller: passwordController,
//                 hintText: 'Password',
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a password';
//                   }
//                   if (value.length < 8) {
//                     return 'Password must be at least 8 characters long';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState?.validate() ?? false) {
//                     final username = usernameController.text;
//                     final password = passwordController.text;

//                     // Access AuthService via Provider
//                     final authService = Provider.of<AuthService>(context, listen: false);

//                     try {
//                       authService.register(username, password);
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text("Registration successful!")),
//                       );

//                       Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => LoginScreen()),
//                     );
//                     } catch (e) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text(e.toString())),
//                       );
//                     }
//                   }
                 
//                 },
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: const Size(50, 50),
//                   backgroundColor: Colors.green,
//                   shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12)),
//                 ),
//                 child: const Text(
//                   "Register",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//               const SizedBox(height: 10,),
//               TextButton(onPressed: (){
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
//               }, child: const Text(
//                 "Already have an account?Login",
//                 style: TextStyle(color: Colors.black,fontSize: 14),
//                 ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(
//     BuildContext context, {
//     required TextEditingController controller,
//     required String hintText,
//     bool obscureText = false,
//     Color textColor = Colors.black,
//     String? Function(String?)? validator,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: TextFormField(
//           controller: controller,
//           obscureText: obscureText,
//           style: TextStyle(color: textColor),
//           decoration: InputDecoration(
//             hintText: hintText,
//             border: InputBorder.none,
//             hintStyle: const TextStyle(color: Colors.black),
//           ),
//           validator: validator,
//         ),
//       ),
//     );
//   }
// }
