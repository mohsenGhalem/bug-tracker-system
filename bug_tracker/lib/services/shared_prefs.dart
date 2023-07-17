import 'dart:convert';

import 'package:bug_tracker/home/model/user_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static String _token = '';
  static Future<String> get token async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token') ?? '';
    return _token;
  }

  static setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', value);
  }

  static saveUserInfo(Map<String, dynamic> userJson) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', json.encode(userJson));
  }

  static Future<UserModel> get currentUser async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('user');
    UserModel user = UserModel.fromJson(data!);

    return user;
  }

  static Future<void> signOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAllNamed('/auth');
  }
}
