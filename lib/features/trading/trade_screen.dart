import 'package:flutter/material.dart';
import 'package:olymp_trade/core/constants/app_colors.dart';
import 'package:olymp_trade/features/chart/chart_repo.dart';
import 'package:olymp_trade/features/chart/chart_widget.dart';
import 'package:olymp_trade/features/drawers/account_drawer.dart';
import 'package:olymp_trade/features/drawers/payment_drawer.dart';
import 'package:olymp_trade/features/provider/drawer_provider.dart';
import 'package:olymp_trade/features/provider/selected_index_provider.dart';
import 'package:olymp_trade/features/sections/bottom_section/bottom_section.dart';
import 'package:olymp_trade/features/sections/top_sections/top_section.dart';
import 'package:olymp_trade/features/sidebar/right_sidebar_section.dart';
import 'package:olymp_trade/features/sidebar/sidebar_section.dart';
import 'package:provider/provider.dart';
import '../drawers/profile_drawer.dart';

class TradeScreen extends StatelessWidget {
  final String balance;
  final String accountType;

  TradeScreen({
    super.key,
    this.balance = "AED 0.00",
    this.accountType = "AED Account",
  });

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // final themeProvider=Provider.of<ThemeProvider>(context,listen: false);
    return Scaffold(
      // appBar: AppBar(
      //   title: Icon(Icons.dark_mode_outlined),
      //   actions: [
      //     Switch(
      //       value: themeProvider.isDarkMode, 
      //       onChanged: (value){
      //         themeProvider.toggleTheme(value);
      //       })
      //   ],
      // ),
      key: scaffoldKey,
      backgroundColor: AppColors.background,
      drawer: _buildDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600;
          return Column(
            children: [
              Expanded(
                child: isMobile
                    ? _buildMobileLayout(context)
                    : _buildWebLayout(context),
              ),
              if (isMobile) _buildMobileBottomSidebar(context),
            ],
          );
        },
      ),
      endDrawer: _buildEndDrawer(),
    );
  }

  Widget _buildDrawer() {
    return Consumer<DrawerProvider>(
      builder: (context, drawerProvider, child) {
        return drawerProvider.selectedDrawer;
      },
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        const TopSection(),
        Expanded(
          child: CandleChartWidget(
            repository: BinanceRepository(),
            initialThemeIsDark: false,
          ),
        ),
        const TradeBottomSection(),
      ],
    );
  }

  Widget _buildWebLayout(BuildContext context) {
    return Row(
      children: [
        Sidebar(
          onItemSelected: (drawerContent) {
            Provider.of<DrawerProvider>(context, listen: false)
                .updateDrawerContent(drawerContent);
            scaffoldKey.currentState?.openDrawer();
          },
        ),
        Expanded(
          child: Column(
            children: [
              const TopSection(),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: CandleChartWidget(
                        repository: BinanceRepository(),
                        initialThemeIsDark: false,
                      ),
                    ),
                    const RightSidebarSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileBottomSidebar(BuildContext context) {
    return Sidebar(
      onItemSelected: (drawerContent) {
        Provider.of<DrawerProvider>(context, listen: false)
            .updateDrawerContent(drawerContent);
        scaffoldKey.currentState?.openDrawer();
      },
    );
  }

  Widget _buildEndDrawer() {
    return Consumer<SelectedIndexNotifier>(
      builder: (context, selectedIndexNotifier, child) {
        switch (selectedIndexNotifier.selectedIndex) {
          case 0:
            return AccountDrawer(
              selectedIndex: selectedIndexNotifier.selectedIndex,
              onSelect: (index) {
                selectedIndexNotifier.updateSelectedIndex(index);
              },
            );
          case 1:
            return PaymentDrawer(
              selectedIndex: selectedIndexNotifier.selectedIndex,
              onSelect: (index) {
                selectedIndexNotifier.updateSelectedIndex(index);
              },
            );
          case 2:
            return ProfileDrawer(
              selectedIndex: selectedIndexNotifier.selectedIndex,
              onSelect: (index) {
                selectedIndexNotifier.updateSelectedIndex(index);
              },
            );
          default:
            return AccountDrawer(
              selectedIndex: selectedIndexNotifier.selectedIndex,
              onSelect: (index) {
                selectedIndexNotifier.updateSelectedIndex(index);
              },
            );
        }
      },
    );
  }
}


