import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:olymp_trade/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:olymp_trade/features/model/user_model.dart';

class AccountDetailsServices {
  Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print('Retrieved token: $token');
    return token ?? '';
  }

  Future<UserData?> getUserData() async {
    try {
      // var uri = Uri.http('192.168.4.30:8080', '/api/v1/client/account/details');
      // var uri = Uri.parse('https://bo.zebacus.com/backend/api/v1/client/account/details');
      
      
      var uri = Uri.parse(ApiUrl.user);
      var authToken = await getToken();

      if (authToken.isEmpty) {
        print('Authorization token is missing.');
        throw Exception('Authorization token is missing');
      }

      var headers = {"Authorization": "Bearer $authToken"};

      final response = await http.get(uri, headers: headers);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print('Decoded response data: $data');

        UserData userData = UserData.fromJson(data);

        if (userData.userId != null && userData.userUuid != null) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setInt('user_id', userData.userId!);
          await prefs.setString('user_uuid', userData.userUuid!);

          print('User ID saved: ${userData.userId}');
          print('User UUID saved: ${userData.userUuid}');

          return userData;
        } else {
          print('User ID or User UUID is missing in the response.');
          throw Exception('Invalid user data: User ID or UUID is missing');
        }
      } else if (response.statusCode == 401) {
        print('Unauthorized request. Please log in again.');
        throw Exception('Unauthorized');
      } else {
        print('Failed to load user data. Response: ${response.body}');
        throw Exception(
            'Failed to load user data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
  }

  Future<String> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_id') ?? '';
  }

  Future<String> getUserUuid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_uuid') ?? '';
  }
}

