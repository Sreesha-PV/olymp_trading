import 'package:flutter/material.dart';
import 'package:olymp_trade/features/authentication/authentication_screen.dart';
import 'package:olymp_trade/features/provider/account_drawer_provider.dart';
import 'package:olymp_trade/features/provider/active_order_provider.dart';
import 'package:olymp_trade/features/provider/balance_provider.dart';
import 'package:olymp_trade/features/provider/drawer_provider.dart';
import 'package:olymp_trade/features/provider/dropdown_provider.dart';
import 'package:olymp_trade/features/provider/enable_order_provider.dart';
import 'package:olymp_trade/features/provider/orderrequest_provider.dart';
import 'package:olymp_trade/features/provider/trade_history_provider.dart';
import 'package:olymp_trade/features/provider/tradesettings_provider.dart';
import 'package:olymp_trade/features/provider/order_provider.dart';
import 'package:olymp_trade/features/provider/selected_account_provider.dart';
import 'package:olymp_trade/features/provider/selected_index_provider.dart';
import 'package:olymp_trade/features/provider/tabbar_provider.dart';
import 'package:olymp_trade/features/provider/user_provider.dart';
import 'package:olymp_trade/services/account_details_services.dart';
import 'package:olymp_trade/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'features/provider/authentication_provider.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectedIndexNotifier()),
        ChangeNotifierProvider(create: (_) => DrawerProvider()),
        ChangeNotifierProvider(create: (_) => TabVisibilityProvider()),

        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => TradeHistoryProvider()),
        ChangeNotifierProvider(
          create: (context) => ActiveOrderProvider(Provider.of<TradeHistoryProvider>(context, listen: false)),
        ),
        ChangeNotifierProvider(create: (_) => EnableOrderProvider()),
        ChangeNotifierProvider(create: (_) => ProfitabilityProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AccountProvider()),
        ChangeNotifierProvider(create: (_) => SelectedAccountNotifier()),

        ChangeNotifierProvider(create: (_) => OrderRequestProvider()),
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(
            create: (_) => UserProvider(AccountDetailsServices())),
        ChangeNotifierProvider(create: (_) => TradeSettingsProvider()),
        ChangeNotifierProvider(create: (_) => BalanceProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: const AuthScreen(),
        // home: TradeScreen(),
      ),
    );
  }
}




