import 'package:flutter/material.dart';
import 'package:olymp_trade/model/order_model.dart';
import 'package:olymp_trade/screens/provider/active_order_provider.dart';
import 'package:olymp_trade/screens/provider/icon_provider.dart';
import 'package:olymp_trade/screens/provider/user_provider.dart';
import 'package:olymp_trade/services/order.dart';
import 'package:provider/provider.dart';
import 'dart:convert';


class TradeBottomSection extends StatelessWidget {
  const TradeBottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.black,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _fixedTimeButton("1 min", context),
              const SizedBox(width: 5),
              _fixedTimeButton("AED 0", context),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _orderButton("Down", const Color.fromARGB(255, 228, 73, 86),Icons.arrow_downward, context),
              const SizedBox(width: 5),
              _iconButton(context, Icons.watch_later_outlined),
              const SizedBox(width: 10),
              _orderButton("Up", const Color.fromARGB(255, 34, 175, 93), Icons.arrow_upward, context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _iconButton(BuildContext context, IconData icon) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.all(8),
      height: screenHeight * 0.06,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: Colors.white, size: 24),
    );
  }

  Widget _fixedTimeButton(String text, BuildContext context) {
    final tradeSettings = Provider.of<TradeSettingsProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              if (text == "1 min") {
                tradeSettings.decreaseMinutes();
              } else if (text == "AED 0") {
                tradeSettings.decreaseAmount();
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.remove, color: Colors.white, size: 24),
            ),
          ),
          const SizedBox(width: 5),
          Text(
            text == "1 min" ? "${tradeSettings.minutes} min" : "AED${tradeSettings.amount}",
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: () {
              if (text == "1 min") {
                tradeSettings.increaseMinutes();
              } else if (text == "AED 0") {
                tradeSettings.increaseAmount();
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.add, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
    );
  }


  Widget _orderButton(String label, Color color, IconData icon, BuildContext context) {
  return Expanded(
    child: GestureDetector(
      onTap: () {
        // fetchUserOrder(context);
      
        String direction = label == "Up" ? "Up" : "Down";
        Order order = Order(
          label: label,
          direction: direction,
          amount: Provider.of<TradeSettingsProvider>(context, listen: false).amount,
          time: "${Provider.of<TradeSettingsProvider>(context, listen: false).minutes} min",
        );

        // Add order to the provider
        Provider.of<ActiveOrderProvider>(context, listen: false).addOrder(order);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.black),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

}


