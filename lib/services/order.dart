
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:olymp_trade/screens/provider/user_provider.dart';
import 'package:provider/provider.dart';

Future<void> fetchUserOrder(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final String? loggedInUsername = userProvider.loggedInUsername;

    if (loggedInUsername == null) {
      print("No user logged in.");
      return;
    }

    const String mockApiUrl = "https://run.mocky.io/v3/f16734c5-3dbe-4362-8ee1-2152d02662c6"; // Replace with your Mocky API URL

    try {
      final response = await http.get(Uri.parse(mockApiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        // Find the order matching the logged-in username
        final userOrder = data.firstWhere(
          (order) => order['userId'] == loggedInUsername,
          orElse: () => null,
        );

        if (userOrder != null) {
          print("Order Details for ${userOrder['userId']}:");
          print("Order ID: ${userOrder['orderId']}");
          print("Amount: Ð${userOrder['amount']}");
          print("Duration: ${userOrder['minutes']} minutes");
          print("Type: ${userOrder['label']}");
          print("Message: ${userOrder['message']}");
        } else {
          print("No order found for user: $loggedInUsername");
        }
      } else {
        print("Error: Failed to fetch orders");
      }
    } catch (e) {
      print("Network Error: $e");
    }
  }
  
