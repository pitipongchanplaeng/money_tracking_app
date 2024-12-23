// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:money_tracking_app_6419410030/models/money.dart';
import 'package:money_tracking_app_6419410030/models/users.dart';
import 'package:money_tracking_app_6419410030/utils/env.dart';

class CallApi {
  static Future<List<User>> CheckLoginApi(User user) async {
    final responseData = await http.post(
      Uri.parse("${Env.baseUrl}/money_tracking_api_6419410030/apis/check_login_api.php"),
      body: jsonEncode(user.toJson()),
      headers: {"Content-Type": "application/json"},
    );
    if (responseData.statusCode == 200) {
      //แปลงข้อมูลที่ส่งกลับมาจาก JSON เพื่อใช้ในแอปฯ
      final responseDataDecode = jsonDecode(responseData.body);
      List<User> data = await responseDataDecode
          .map<User>((json) => User.fromJson(json))
          .toList();
      //ส่งค่าข้อมูลที่ได้ไปยังจุดที่เรียกใช้เมธอด
      return data;
    } else {
      throw Exception('Failed to .... login');
    }
  }

  static Future<List<User>> RegisterAPI(User user) async {
    final responseData = await http.post(
      Uri.parse(
          "${Env.baseUrl}/money_tracking_api_6419410030/apis/insert_newuser_api.php"),
      body: jsonEncode(user.toJson()),
      headers: {"Content-Type": "application/json"},
    );
    if (responseData.statusCode == 200) {
      //แปลงข้อมูลที่ส่งกลับมาจาก JSON เพื่อใช้ในแอปฯ
      final responseDataDecode = jsonDecode(responseData.body);
      List<User> data = await responseDataDecode
          .map<User>((json) => User.fromJson(json))
          .toList();
      //ส่งค่าข้อมูลที่ได้ไปยังจุดที่เรียกใช้เมธอด
      return data;
    } else {
      throw Exception('Failed to .... login');
    }
  }

  static Future<List<Money>> getMoneyAPI(String? userId) async {
    final responseData = await http.post(
      Uri.parse("${Env.baseUrl}/money_tracking_api_6419410030/apis/get_money_api.php"),
      body: jsonEncode(
        {"userId": userId},
      ),
      headers: {"Content-Type": "application/json"},
    );

    if (responseData.statusCode == 200) {
      // แปลงข้อมูล JSON เป็น List<Money>
      // print(responseData.body);
      final responseDataDecode = jsonDecode(responseData.body);
      List<Money> data = responseDataDecode
          .map<Money>((json) => Money.fromJson(json))
          .toList();
      return data;
    } else {
      throw Exception('Failed to fetch money data');
    }
  }

  static Future<List<Money>> AddMoneyApi(Money money) async {
    final responseData = await http.post(
      Uri.parse("${Env.baseUrl}/money_tracking_api_6419410030/apis/add_money_api.php"),
      body: jsonEncode(money.toJson()),
      headers: {"Content-Type": "application/json"},
    );
    if (responseData.statusCode == 200) {
      //แปลงข้อมูลที่ส่งกลับมาจาก JSON เพื่อใช้ในแอปฯ
      final responseDataDecode = jsonDecode(responseData.body);
      List<Money> data = await responseDataDecode
          .map<Money>((json) => Money.fromJson(json))
          .toList();
      //ส่งค่าข้อมูลที่ได้ไปยังจุดที่เรียกใช้เมธอด
      return data;
    } else {
      throw Exception('Failed to .... login');
    }
  }
}