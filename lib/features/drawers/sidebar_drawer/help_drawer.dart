import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olymp_trade/core/constants/app_colors.dart';

class HelpDrawer extends StatelessWidget {
  const HelpDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 320,
      backgroundColor: AppColors.bgColor,
      child: ListView(padding: const EdgeInsets.only(left: 15), children: [
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Row(
            children: [
              const Text(
                'Help',
                style: TextStyle(
                    color: AppColors.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              const SizedBox(width: 160),
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                      color: AppColors.fillColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.help_outline),
                          const SizedBox(height: 20),
                          const Text('Support',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14)),
                          Row(
                            children: [
                              Text('We are here for you ',
                                  style: TextStyle(
                                      color: AppColors.labelColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                            ],
                          ),
                          Row(
                            children: [
                              Text('24/7 ',
                                  style: TextStyle(
                                      color: AppColors.labelColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                      color:AppColors.fillColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.info_outline),
                          const SizedBox(height: 20),
                          const Text('Help Center',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14)),
                          Row(
                            children: [
                              Text('Get to know ',
                                  style: TextStyle(
                                      color: AppColors.labelColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                            ],
                          ),
                          Row(
                            children: [
                              Text('the platform ',
                                  style: TextStyle(
                                      color: AppColors.labelColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                      color: AppColors.fillColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.cast_for_education),
                          const SizedBox(height: 20),
                          const Text('Education',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14)),
                          Row(
                            children: [
                              Text('Expand your ',
                                  style: TextStyle(
                                      color: AppColors.labelColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Knowledge ',
                                  style: TextStyle(
                                      color: AppColors.labelColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                      color: AppColors.labelColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(CupertinoIcons.graph_square),
                          const SizedBox(height: 20),
                          const Text('Trading Tutorials',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14)),
                          Row(
                            children: [
                              Text('Learn how ',
                                  style: TextStyle(
                                      color: AppColors.labelColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                            ],
                          ),
                          Row(
                            children: [
                              Text('to open a trade',
                                  style: TextStyle(
                                      color: AppColors.labelColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
