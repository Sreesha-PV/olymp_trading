
import 'package:flutter/material.dart';

// Transaction model class
class Transaction {
  final String title;
  final String amount;
  final IconData directionIcon;
  final Color directionColor;
  final String time;
  final String statusAmount;
  final Color statusColor;

  Transaction({
    required this.title,
    required this.amount,
    required this.directionIcon,
    required this.directionColor,
    required this.time,
    required this.statusAmount,
    required this.statusColor,
  });


  factory Transaction.fromJson(Map<String, dynamic> json) {
    IconData directionIcon = json['directionIcon'] == 'down'
        ? Icons.arrow_downward
        : Icons.arrow_upward;
    Color directionColor = json['directionIcon'] == 'down'
        ? Colors.red
        : Colors.green;
    Color statusColor = json['statusAmount'] == 'Completed'
        ? Colors.green
        : Colors.red;

    return Transaction(
      title: json['title'],
      amount: json['amount'],
      directionIcon: directionIcon,
      directionColor: directionColor,
      time: json['time'],
      statusAmount: json['statusAmount'],
      statusColor: statusColor,
    );
  }
}