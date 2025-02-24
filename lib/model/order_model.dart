 
class Order {
  final String label;
  final String direction; // "Up" or "Down"
  final double amount;
  final String time;

  Order({
    required this.label,
    required this.direction,
    required this.amount,
    required this.time,
  });
}
