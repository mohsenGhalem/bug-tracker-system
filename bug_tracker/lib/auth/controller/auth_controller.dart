import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../services/shared_prefs.dart';

enum AuthState {
  login,
  signup,
}

class AuthController extends GetxController {
  Map<String, String> authData = {
    'email': '',
    'password': '',
    'name': '',
    'uid': ''
  };

  final String _url = '127.0.0.1:8000';
  Rx<AuthState> authState = AuthState.login.obs;
  String errorMsg = '';

  void setEmail(String email) {
    authData['email'] = email;
  }

  void setPassword(String password) {
    authData['password'] = password;
  }

  void setName(String name) {
    authData['name'] = name;
  }

  void setAuthState(AuthState state) {
    authState.value = state;
    update();
  }

  Future<bool?> signIn() async {
    try {
      final headers = {
        'Content-Type': 'application/json',
      };
      final response = await http.post(
        Uri.http(
          _url,
          '/signIn',
        ),
        body: jsonEncode(authData),
        headers: headers,
      );
      if (jsonDecode(response.body)['message'] != 'SUCCESS') {
        throw Exception(jsonDecode(response.body)['description']);
      }
      SharedPrefs.setToken(json.decode(response.body)['data']['token']);
      SharedPrefs.saveUserInfo(json.decode(response.body)['data']['info']);
      return true;
    } catch (e) {
      print(e);
      errorMsg = e.toString();
      return false;
    }
  }

  Future<bool> signUp() async {
    try {
      final response = await http.post(Uri.http(_url, '/signup'),
          body: authData,
          headers: {"Access-Control-Allow-Origin": "*", 'Accept': '*/*'});
      if (jsonDecode(response.body)['message'] != 'SUCCESS') {
        throw Exception(jsonDecode(response.body)['description']);
      }
      SharedPrefs.setToken(json.decode(response.body)['data']['token']);
      SharedPrefs.saveUserInfo(json.decode(response.body)['info']);
      return true;
    } catch (e) {
      print(e);
      errorMsg = e.toString();
      return false;
    }
  }
}
