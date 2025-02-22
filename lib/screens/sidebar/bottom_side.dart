import 'package:flutter/material.dart';
import 'package:olymp_trade/screens/provider/icon_provider.dart';
import 'package:provider/provider.dart';


class TradeBottomSection extends StatelessWidget {
  const TradeBottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.black, // Matches the Olymp Trade background
      child: Column(
        children: [
          const SizedBox(height: 10),

          // Fixed Time Mode & Amount Selector (with Watch Icon in between)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _fixedTimeButton("1 min", context),
              const SizedBox(width: 2),
              _fixedTimeButton("Ð1", context),
            ],
          ),
          const SizedBox(height: 10),

          // Order Buttons (Down & Up)
          Row(
            children: [
              _orderButton("Down", const Color.fromARGB(255, 228, 73, 86), Icons.arrow_downward),
               const SizedBox(width: 5),
              _iconButton(context,Icons.watch_later_outlined),
              const SizedBox(width: 10),
              _orderButton("Up", const Color.fromARGB(255, 34, 175, 93), Icons.arrow_upward),
            ],
          ),
        ],
      ),
    );
  }

  
Widget _iconButton(BuildContext context, IconData icon) {
  // Get the screen height
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

  // Fixed Time Mode & Amount Selector Button (with - and + icons)
  Widget _fixedTimeButton(String text, BuildContext context) {
    final tradeSettings = Provider.of<TradeSettingsProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18), // Reduced horizontal padding
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Left minus icon
          GestureDetector(
            onTap: () {
              if (text == "1 min") {
                tradeSettings.decreaseMinutes();
              } else if (text == "Ð1") {
                tradeSettings.decreaseAmount();
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.remove, color: Colors.white, size: 24),
            ),
          ),
          const SizedBox(width: 5), // Reduced space
          // Center text (1 min or ₦1)
          Text(
            text == "1 min" ? "${tradeSettings.minutes} min" : "Ð${tradeSettings.amount}",
            style: const TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 5), // Reduced space
          // Right plus icon
          GestureDetector(
            onTap: () {
              if (text == "1 min") {
                tradeSettings.increaseMinutes();
              } else if (text == "Ð1") {
                tradeSettings.increaseAmount();
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
    );
  }

  // Order Button (Up & Down)
  Widget _orderButton(String label, Color color, IconData icon) {
    return Expanded(
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
                style: const TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
