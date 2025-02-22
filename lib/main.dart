import 'package:flutter/material.dart';
import 'package:olymp_trade/authentication/login.dart';
import 'package:olymp_trade/screens/dashboard_screen.dart';
import 'package:olymp_trade/screens/provider/icon_provider.dart';
import 'package:olymp_trade/screens/provider/order_provider.dart';
import 'package:olymp_trade/screens/provider/tabbar_provider.dart';
import 'package:olymp_trade/screens/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'screens/provider/account_drawer_provider.dart';
import 'screens/provider/drawer_provider.dart';
import 'screens/provider/dropdown_provider.dart';
import 'screens/provider/enable_order_provider.dart';
import 'screens/provider/selected_account_notifier.dart';
import 'screens/provider/selected_index_provider.dart';


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
        ChangeNotifierProvider(
          create: (_) => SelectedIndexNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => DrawerProvider(),
        ),
          ChangeNotifierProvider(
          create: (_) => OrderProvider(),
        ),
          ChangeNotifierProvider(
          create: (_) => TabVisibilityProvider(),
        ),
         ChangeNotifierProvider(
          create: (_) => ProfitabilityProvider(),
        ),
        ChangeNotifierProvider(
          create: (_)=>EnableOrderProvider(),
        ),
         ChangeNotifierProvider(
          create: (_)=>AccountProvider(),
        ),
         ChangeNotifierProvider(
          create: (_)=>SelectedAccountNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_)=>UserProvider()),
        ChangeNotifierProvider(
          create: (_)=>TradeSettingsProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
         theme: ThemeData.dark(),
            // home: LoginScreen(),
            home: TradeScreen(), 
            // home: RegistrationScreen(),
          
      ),
    );
  }
}




