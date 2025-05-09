import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/tradesettings_provider.dart';

class FixedAmountInputField extends StatelessWidget {
  const FixedAmountInputField({super.key});

  @override
  Widget build(BuildContext context) {
    final tradeSettings = Provider.of<TradeSettingsProvider>(context);
    final controller = TextEditingController(text: "AED ${tradeSettings.amount}");

    return Container(
      height: 50,
      width: 170,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      // padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
      // height: MediaQuery.of(context).size.height * 0.05,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 24, 23, 23),
        border: Border.all(color: Colors.grey[800]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: tradeSettings.decreaseAmount,
            child: const Icon(Icons.remove, color: Colors.white),
          ),
          const SizedBox(width: 5),
          SizedBox(
            width: 80,
            child: TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              textAlign: TextAlign.center,
              decoration: const InputDecoration(border: InputBorder.none),
            ),
          ),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: tradeSettings.increaseAmount,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
