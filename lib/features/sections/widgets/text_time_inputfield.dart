import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/tradesettings_provider.dart';

class FixedTimeInputField extends StatelessWidget {
  const FixedTimeInputField({super.key});

  @override
  Widget build(BuildContext context) {
    final tradeSettings = Provider.of<TradeSettingsProvider>(context);
    final controller = TextEditingController(text: "${tradeSettings.minutes} min");
    return Container(
      height: 50,
      width: 170,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 24, 23, 23),
        border: Border.all(color: Colors.grey[800]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: tradeSettings.decreaseMinutes,
            child: const Icon(Icons.remove, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 60,
            child: Center(
              child: TextField(
                controller: controller,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                onChanged: (value) {
                  final parsed = int.tryParse(value.replaceAll(' min', '').trim()) ?? 1;
                  tradeSettings.setMinutes(parsed);
                },
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: tradeSettings.increaseMinutes,
            child: const Icon(Icons.add, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }
}
