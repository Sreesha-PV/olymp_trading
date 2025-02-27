import 'package:flutter/material.dart';
import 'package:olymp_trade/features/chart/chart_repo.dart';
import 'package:olymp_trade/features/chart/chart_widget.dart';
import 'package:olymp_trade/features/drawer/account_drawer.dart';
import 'package:olymp_trade/features/drawer/payment_drawer.dart';
import 'package:olymp_trade/features/provider/drawer_provider.dart';
import 'package:olymp_trade/features/provider/selected_index_provider.dart';
import 'package:olymp_trade/features/sections/bottom_section.dart';
import 'package:olymp_trade/features/sections/top_section.dart';
import 'package:olymp_trade/features/sidebar/right_sidebar_section.dart';
import 'package:olymp_trade/features/sidebar/sidebar_section.dart';
import 'package:provider/provider.dart';



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
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
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
        return selectedIndexNotifier.selectedIndex == 0
            ? AccountDrawer(
                selectedIndex: selectedIndexNotifier.selectedIndex,
                onSelect: (index) {
                  selectedIndexNotifier.updateSelectedIndex(index);
                },
              )
            : PaymentDrawer(
                selectedIndex: selectedIndexNotifier.selectedIndex,
                onSelect: (index) {
                  selectedIndexNotifier.updateSelectedIndex(index);
                });
      },
    );
  }
}
