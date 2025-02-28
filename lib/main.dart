import 'package:flutter/material.dart';
import 'package:olymp_trade/features/authentication/authentication_screen.dart';
import 'package:olymp_trade/features/authentication/authentication_service.dart';
import 'package:olymp_trade/features/authentication/login.dart';
import 'package:olymp_trade/features/authentication/registration.dart';
import 'package:olymp_trade/features/provider/account_drawer_provider.dart';
import 'package:olymp_trade/features/provider/active_order_provider.dart';
import 'package:olymp_trade/features/provider/drawer_provider.dart';
import 'package:olymp_trade/features/provider/dropdown_provider.dart';
import 'package:olymp_trade/features/provider/enable_order_provider.dart';
import 'package:olymp_trade/features/provider/icon_provider.dart';
import 'package:olymp_trade/features/provider/order_provider.dart';
import 'package:olymp_trade/features/provider/selected_account_provider.dart';
import 'package:olymp_trade/features/provider/selected_index_provider.dart';
import 'package:olymp_trade/features/provider/tabbar_provider.dart';
import 'package:olymp_trade/features/provider/transaction_history_provider.dart';
import 'package:olymp_trade/features/trading/trade_screen.dart';
import 'package:provider/provider.dart';



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
      ChangeNotifierProvider(create: (_) => ActiveOrderProvider()),
      ChangeNotifierProvider(create: (_) => EnableOrderProvider()),
      ChangeNotifierProvider(create: (_) => ProfitabilityProvider()),
      // ChangeNotifierProvider(create: (_)=>AuthService()),
      ChangeNotifierProvider(create: (_)=>TransactionHistoryProvider()),
      ChangeNotifierProvider(create: (_) => AccountProvider()),
      ChangeNotifierProvider(create: (_) => SelectedAccountNotifier()),
      // ChangeNotifierProvider(create: (_) => UserProvider()),
      
      
      ChangeNotifierProvider(create: (_) => TradeSettingsProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
         theme: ThemeData.dark(),
           home: AuthScreen(),
            // home: TradeScreen(), 
           
      ),
    );
  }
}
