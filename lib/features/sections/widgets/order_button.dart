import 'package:flutter/material.dart';

class OrderButton extends StatelessWidget {
  const OrderButton({
    super.key,
    required this.label,
    required this.color,
    required this.icon,
    this.onTap,
  });

  final String label;
  final Color color;
  final IconData icon;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(icon, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}
