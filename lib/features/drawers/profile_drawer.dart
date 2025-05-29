import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olymp_trade/core/constants/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:olymp_trade/features/authentication/authentication_screen.dart';
import 'package:olymp_trade/features/provider/user_provider.dart';
import '../provider/authentication_provider.dart'; 
      
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
     backgroundColor: AppColors.bgColor,
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
                    color: AppColors.textColor,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                    color: AppColors.textColor,
                  ),
                ],
              ),
              const SizedBox(height: 50),
              CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.fillColor,
                child: const Icon(
                  CupertinoIcons.person,
                  color: AppColors.textColor,
                  size: 30,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                userProvider.name.isEmpty
                    ? 'No Name available'
                    : userProvider.name,
                style: const TextStyle(
                  color: AppColors.textColor,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              Text(
                userProvider.email.isEmpty
                    ? 'No Email available'
                    : userProvider.email,
                style: const TextStyle(
                  color: AppColors.textColor,
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
                  color: AppColors.borderColor,
                ),
                child: TextButton(
                  onPressed: (){
                    Provider.of<AuthProvider>(context,listen: false).logout();
                    Provider.of<UserProvider>(context,listen: false);
                    Navigator.pushAndRemoveUntil(
                      context, 
                      MaterialPageRoute(builder: (context)=>const AuthScreen()),
                      (route)=>false);
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                        color: AppColors.textColor,
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






