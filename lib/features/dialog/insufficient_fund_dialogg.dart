

import 'package:flutter/material.dart';


void showInsufficientFundsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        alignment: Alignment.topRight,
        title: const Text("You don't have enough funds"),
        content: const Text(
          "Deposit to your trading account to open a trade",
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 54,
              width: MediaQuery.of(context).size.width / 3,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 76, 238, 238),
                    Color.fromARGB(255, 74, 231, 43),
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Deposit',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      );
    },
  );
}
