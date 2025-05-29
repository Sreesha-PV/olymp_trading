import 'package:flutter/material.dart';
import 'package:olymp_trade/core/constants/app_colors.dart';

class StocksPage extends StatelessWidget {
  const StocksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: const Color.fromARGB(255, 24, 23, 23),
        child: ListView(padding: const EdgeInsets.only(left: 15), children: [
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Portfolio',
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_bag_outlined,
                  size: 120,
                  color: AppColors.borderColor,
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You have no Active Positions on',
                style: TextStyle(color: AppColors.drawerContent),
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('this account',
                  style: TextStyle(color: AppColors.drawerContent))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.borderColor,
                    ),
                    child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Explore Assets',
                          style: TextStyle(color: AppColors.textColor),
                        )),
                  ),
                ],
              ))
        ]));
  }
}
