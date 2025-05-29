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
          // backgroundColor: Colors.grey[900],
          backgroundColor: AppColors.borderColor,
          child: const Icon(Icons.add),
        ),
        const SizedBox(width: 10),
        _buildMarketInfoLabel(),
        const SizedBox(width: 5),
        // _buildDurationLabel()
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

  // Widget _buildMarketInfoLabel() {
  //   return Container(
  //     height: 50,
  //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  //     decoration: BoxDecoration(
  //       color: Colors.grey[900],
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //     child: const Center(
  //       child: Text(
  //         "Halal Market Axis",
  //         style: TextStyle(
  //           color: AppColors.textColor,
  //           fontSize: 14,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),

  //     ),

  //   );
  // }

  Widget _buildMarketInfoLabel() {
    return Container(
      width: 200,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.grey[900], borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Container(
            // height: 30,
            // width: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: const Color.fromARGB(255, 34, 78, 34),
            ),
            child: const Icon(
              Icons.ac_unit,
              size: 30,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Halal Market Axis",
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  "FT -85% ",
                  style: TextStyle(
                    color: AppColors.focusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                  //  const SizedBox(width: 2,),
                // Row(
                //   children: [
                //     const Text('85%' ,
                //     style: TextStyle(
                //        color: AppColors.focusColor,
                //         fontSize: 12,
                //         fontWeight: FontWeight.bold,
                //     ),),
                //   ],
                // ) 
              ],
            ),
          ),
        ],
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
                fontSize: 16,
              ),
            ),
            Text(
              accountNotifier.selectedAccount,
              style: const TextStyle(
                color: AppColors.balanceColor,
                fontSize: 14,
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  // height: 30,
                  // width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color.fromARGB(255, 34, 78, 34),
                  ),
                  child: const Icon(
                    Icons.ac_unit,
                    size: 30,
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Text(
                        "Halal Market Axis",
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // const SizedBox(height: 2),
                // const Row(
                //   children: [
                //     Text( "FT - 85%",
                //       style: TextStyle(
                //     color: AppColors.focusColor,
                //     fontSize: 12,
                //     fontWeight: FontWeight.bold,
                //   ),),
                //   ],
                // ),
                const SizedBox(width: 8),
                const Text(
                  "FT - 85%",
                  style: TextStyle(
                    color: AppColors.focusColor, 
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(CupertinoIcons.chevron_down,
                    color: AppColors.border, size: 30)
              ],
            ),
          ),
          const SizedBox(width: 2),
          Container(
            height: 52,
            width: 40,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12)),
            ),
            child: const Icon(Icons.analytics_outlined),
          ),
          const SizedBox(width: 1),
          Container(
            height: 52,
            width: 46,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[900],
            ),
            child: const Center(
              child: Text(
                "5s",
                style: TextStyle(
                  color: AppColors.textColor,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 1,
          ),
          Container(
            height: 52,
            width: 40,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12)),
            ),
            child: const Center(
              child: const Icon(
                Icons.signal_cellular_alt_sharp,
                color: AppColors.textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}