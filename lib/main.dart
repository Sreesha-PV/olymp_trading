import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'screens/dashboard_screen.dart';
import 'screens/provider/drawer_provider.dart';
import 'screens/provider/selected_index_provider.dart';

void main() {
  runApp(
  ChangeNotifierProvider(
      create: (context) => SelectedIndexNotifier(),
      child: const MyApp(),
    ),
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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
         theme: ThemeData.dark(),
            home:  TradeScreen(),
           
      ),
    );
  }
}





let res = pm.response.json();

if (res.status === "executed") {
  pm.test("Order is executed", () => {
    pm.expect(res.status).to.eql("executed");
    console.log("Execution price: " + res.executionPrice);
    console.log("Profit/Loss: " + res.result);
  });
} else {
  pm.test("Order not yet executed", () => {
    pm.expect(res.status).to.not.eql("executed");
    console.warn("Order is still pending. Check again after some time.");
  });
}

