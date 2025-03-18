
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:olymp_trade/features/authentication/authentication_screen.dart';
import 'package:olymp_trade/features/provider/user_provider.dart';

class ProfileDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onSelect;

  const ProfileDrawer({
    super.key,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 360,
      backgroundColor: const Color.fromARGB(255, 26, 25, 25),
      child: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          if (userProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_none),
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                    color: Colors.white,
                  ),
                ],
              ),
              
              const SizedBox(height: 50),
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey[850],
                child: const Icon(
                  CupertinoIcons.person,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                userProvider.name.isEmpty ? 'No Name available' : userProvider.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 5),
              Text(
                userProvider.email.isEmpty ? 'No Email available' : userProvider.email,  
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 15),
              Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[800],
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AuthScreen()));
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
