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
        ? GestureDetector(
           onTap: (){
             Provider.of<SelectedIndexNotifier>(context, listen: false)
              .updateSelectedIndex(2);
          Scaffold.of(context).openEndDrawer();
           },
          child: CircleAvatar(
              backgroundColor: Colors.grey[850],
              foregroundColor: Colors.white,
              radius: 25,
              child: const Icon(CupertinoIcons.person),
            ),
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
          GestureDetector(
            onTap: (){
              Provider.of<SelectedIndexNotifier>(context, listen: false)
              .updateSelectedIndex(2);
          Scaffold.of(context).openEndDrawer();
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey[850],
              foregroundColor: Colors.white,
              radius: 25,
              child: const Icon(CupertinoIcons.person),
            ),
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











import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:olymp_trade/core/constants/app_colors.dart';
import 'package:olymp_trade/features/provider/balance_provider.dart';
import 'package:olymp_trade/features/provider/selected_account_provider.dart';
import 'package:olymp_trade/features/provider/selected_index_provider.dart';

class TopSection extends StatelessWidget {
  const TopSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Load balance on widget mount
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BalanceProvider>(context, listen: false).loadBalance(context);
    });

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        return Padding(
          padding: EdgeInsets.all(isMobile ? 8.0 : 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildLeftSection(context, isMobile),
                  _buildCenterSection(context, isMobile),
                  _buildRightSection(context, isMobile),
                ],
              ),
              if (isMobile) _buildMobileAdditionalInfo(),
            ],
          ),
        );
      },
    );
  }


  Widget _buildLeftSection(BuildContext context, bool isMobile) {
    if (isMobile) {
      return GestureDetector(
        onTap: () {
          context.read<SelectedIndexNotifier>().updateSelectedIndex(2);
          Scaffold.of(context).openEndDrawer();
        },
        child: CircleAvatar(
          backgroundColor: AppColors.fillColor,
          foregroundColor: AppColors.textColor,
          radius: 25,
          child: const Icon(CupertinoIcons.person),
        ),
      );
    }

    return Row(
      children: [
        FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.grey[900],
          child: const Icon(Icons.add),
        ),
        const SizedBox(width: 10),
        _buildMarketInfoLabel(),
      ],
    );
  }

  /// Center: Account + Balance Selector (only for mobile)
  Widget _buildCenterSection(BuildContext context, bool isMobile) {
    if (!isMobile) return const SizedBox.shrink();

    return GestureDetector(
      onTap: () {
        context.read<SelectedIndexNotifier>().updateSelectedIndex(0);
        Scaffold.of(context).openEndDrawer();
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            _buildAccountInfo(context, isMobile),
            const SizedBox(width: 8),
            const Icon(Icons.keyboard_arrow_down, color: AppColors.textColor),
          ],
        ),
      ),
    );
  }

  /// Right: Payments, Avatar, and AED Account (non-mobile)
  Widget _buildRightSection(BuildContext context, bool isMobile) {
    return Row(
      children: [
        if (!isMobile) _buildAEDAccountSelector(context),
        const SizedBox(width: 10),
        _buildWalletButton(context, isMobile),
        const SizedBox(width: 10),
        if (!isMobile) _buildProfileAvatar(context),
      ],
    );
  }

  Widget _buildMarketInfoLabel() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Text(
          "Halal Market Axis",
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildAccountInfo(BuildContext context, bool isMobile) {
    return Consumer<SelectedAccountNotifier>(
      builder: (context, accountNotifier, child) {
        return Column(
          crossAxisAlignment:
              isMobile ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              accountNotifier.selectedBalance,
              style: const TextStyle(
                color: AppColors.textColor,
                fontSize: 18,
              ),
            ),
            Text(
              accountNotifier.selectedAccount,
              style: const TextStyle(
                color: AppColors.balanceColor,
                fontSize: 16,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAEDAccountSelector(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<SelectedIndexNotifier>().updateSelectedIndex(0);
        Scaffold.of(context).openEndDrawer();
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            _buildAccountInfo(context, false),
            const SizedBox(width: 8),
            const Icon(Icons.keyboard_arrow_down, color: AppColors.textColor),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletButton(BuildContext context, bool isMobile) {
    return GestureDetector(
      onTap: () {
        context.read<SelectedIndexNotifier>().updateSelectedIndex(1);
        Scaffold.of(context).openEndDrawer();
      },
      child: Container(
        width: isMobile ? 50 : 100,
        height: 50,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 76, 238, 238),
              Color.fromARGB(255, 74, 231, 43),
            ],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: isMobile
            ? const Icon(Icons.wallet, color: AppColors.background)
            : const Center(
                child: Text(
                  "Payments",
                  style: TextStyle(
                    color: AppColors.background,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildProfileAvatar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<SelectedIndexNotifier>().updateSelectedIndex(2);
        Scaffold.of(context).openEndDrawer();
      },
      child: CircleAvatar(
        backgroundColor: AppColors.fillColor,
        foregroundColor: AppColors.textColor,
        radius: 25,
        child: const Icon(CupertinoIcons.person),
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
                color: AppColors.textColor,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Text(
              "FT - 85%",
              style: TextStyle(
                color: AppColors.focusColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
