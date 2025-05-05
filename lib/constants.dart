class ApiUrl{
  static const String baseUrl = 'https://bo.zebacus.com/backend/api/v1/';
  static const String wsUrl = 'wss://bo.zebacus.com/notifier/ws/1023';

  static const String register = '$baseUrl/client/account/register';
  static const String loginUrl = '$baseUrl/client/auth/login';
  static const String user = '$baseUrl/client/account/details';
  static const String balance = '$baseUrl/wallets/balance';
  static const String order = '$baseUrl/orders'; 
  static String ordersByStatus(int status) => '$baseUrl/orders?status=$status';
}

























