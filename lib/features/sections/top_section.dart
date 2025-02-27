import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olymp_trade/features/provider/selected_account_provider.dart';
import 'package:provider/provider.dart';

import '../provider/selected_index_provider.dart';

class TopSection extends StatelessWidget {
  const TopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600;
        return Padding(
          padding: isMobile ? const EdgeInsets.all(8.0) : const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: isMobile
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.spaceBetween,
                children: [
                  _buildLeftSection(isMobile, context),
                  _buildCenterSection(isMobile, context),
                  _buildRightSection(isMobile, context),
                ],
              ),
              if (isMobile) _buildMobileAdditionalInfo(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLeftSection(bool isMobile, BuildContext context) {
    return isMobile
        ? CircleAvatar(
            backgroundColor: Colors.grey[850],
            foregroundColor: Colors.white,
            radius: 25,
            child: const Icon(CupertinoIcons.person),
          )
        : Row(
            children: [
              FloatingActionButton(
                onPressed: () {},
                backgroundColor: Colors.grey[900],
                child: const Icon(Icons.add),
              ),
              const SizedBox(width: 10),
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Halal Market Axis",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
  }

  Widget _buildCenterSection(bool isMobile, BuildContext context) {
    if (isMobile) {
      return GestureDetector(
        onTap: () {
          Provider.of<SelectedIndexNotifier>(context, listen: false)
              .updateSelectedIndex(0);
          Scaffold.of(context).openEndDrawer();
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.black,
          ),
          child: Row(
            children: [
              Consumer<SelectedAccountNotifier>(
                builder: (context, accountNotifier, child) {
                  return Text(
                    accountNotifier.selectedAccount,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 163, 185, 179),
                      fontSize: 12,
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
              const Icon(Icons.keyboard_arrow_down, color: Colors.white),
            ],
          ),
        ),
      );
    }
    return Container(); 
  }

  Widget _buildRightSection(bool isMobile, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (!isMobile) _buildAEDAccount(context),
        const SizedBox(width: 10),
        _buildWalletIcon(context, isMobile),
        const SizedBox(width: 10),
        if (!isMobile)
          CircleAvatar(
            backgroundColor: Colors.grey[850],
            foregroundColor: Colors.white,
            radius: 25,
            child: const Icon(CupertinoIcons.person),
          ),
      ],
    );
  }

  Widget _buildAEDAccount(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<SelectedIndexNotifier>(context, listen: false)
            .updateSelectedIndex(0);
        Scaffold.of(context).openEndDrawer();
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.black,
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<SelectedAccountNotifier>(
                  builder: (context, accountNotifier, child) {
                    return Text(
                      accountNotifier.selectedAccount,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 163, 185, 179),
                        fontSize: 12,
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(width: 8),
            const Icon(Icons.keyboard_arrow_down, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletIcon(BuildContext context, bool isMobile) {
    return GestureDetector(
      onTap: () {
        Provider.of<SelectedIndexNotifier>(context, listen: false)
            .updateSelectedIndex(1);
        Scaffold.of(context).openEndDrawer();
      },
      child: Container(
        width: isMobile ? 50 : 100,
        height: 50,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            Color.fromARGB(255, 76, 238, 238),
            Color.fromARGB(255, 74, 231, 43)
          ]),
          borderRadius: BorderRadius.circular(8),
        ),
        child: isMobile
            ? const Icon(
                Icons.wallet,
                color: Colors.black,
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Payments",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildMobileAdditionalInfo() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Halal Market Axis",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8),
            Text(
              "FT - 85%",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}




