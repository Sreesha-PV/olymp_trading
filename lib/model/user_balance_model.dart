class User {
  final String username;
  final String balance;
  final String accountType;

  User({required this.username, required this.balance, required this.accountType});
}

final List<User> mockUsers = [
  User(username: "admin", balance: "AED 5,000.00", accountType: "AED Account"),
  User(username: "user1", balance: "USD 2,500.00", accountType: "USDT Account"),
  User(username: "user2", balance: "EUR 3,000.00", accountType: "EUR Account"),
];
