import 'package:flutter/material.dart';
import 'package:olymp_trade/core/constants/app_colors.dart';

class MarketDrawer extends StatelessWidget {
  const MarketDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 340,
      backgroundColor: AppColors.bgColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  const Text(
                    'Market',
                    style: TextStyle(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  const SizedBox(width: 130),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.info_outline,
                    ),
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
            ),
            const SizedBox(height: 20),
            Card(
              color: AppColors.borderColor,
              child: const ListTile(
                title: Text(
                  'My Purchases & Rewards',
                  style: TextStyle(
                      color: AppColors.textColor, fontWeight: FontWeight.bold),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: AppColors.textColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 12),
              child: Container(
                height: 260,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 66, 65, 65),
                    Color.fromARGB(255, 59, 51, 65),
                    Color.fromARGB(255, 191, 141, 233),
                  ]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 150,
                      ),
                      const Row(
                        children: [
                          Text(
                            'Trading Conditions',
                            style: TextStyle(
                                color: AppColors.textColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Features that provide more ',
                            style: TextStyle(
                                color: AppColors.labelColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('beneficial trading conditions',
                              style: TextStyle(
                                  color:AppColors.labelColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 12),
              child: Container(
                height: 260,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 66, 65, 65),
                    Color.fromARGB(255, 29, 74, 158),
                  ]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 150,
                      ),
                      const Row(
                        children: [
                          Text(
                            'Signals',
                            style: TextStyle(
                                color: AppColors.textColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Algorithm-based recommendations',
                            style: TextStyle(
                                color: AppColors.labelColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('on when to open trades',
                              style: TextStyle(
                                  color: AppColors.labelColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 12),
              child: Container(
                height: 260,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 66, 65, 65),
                        Color.fromARGB(255, 160, 97, 140)
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 130,
                      ),
                      const Row(
                        children: [
                          Text(
                            'Strategies',
                            style: TextStyle(
                                color: AppColors.textColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Ready-to-use sets of tools that ',
                            style: TextStyle(
                                color:AppColors.labelColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('make it easier to spot entry and exit',
                              style: TextStyle(
                                  color:AppColors.labelColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16))
                        ],
                      ),
                      Row(
                        children: [
                          Text('points',
                              style: TextStyle(
                                  color: AppColors.labelColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 12),
              child: Container(
                height: 260,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(255, 66, 65, 65),
                      Color.fromARGB(255, 118, 224, 127),
                    ]),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 130,
                      ),
                      const Row(
                        children: [
                          Text(
                            'Indicators',
                            style: TextStyle(
                                color: AppColors.textColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Ready-to-use sets of tools that ',
                            style: TextStyle(
                                color: AppColors.labelColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('make it easier to spot entry and exit',
                              style: TextStyle(
                                  color: AppColors.labelColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16))
                        ],
                      ),
                      Row(
                        children: [
                          Text('points',
                              style: TextStyle(
                                  color: AppColors.labelColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
