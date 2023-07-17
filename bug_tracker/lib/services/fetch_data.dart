import 'dart:convert';

import 'package:http/http.dart' as http;

import '../home/model/deploy_model.dart';
import '../home/model/error_model.dart';
import '../home/model/test_model.dart';
import '../home/model/user_model.dart';

class FetchData {
  final String url = 'http://127.0.0.1:8000';

  String token;
  FetchData({
    required this.token,
  });

  Future<void> createError(ErrorModel data) async {
    try {
      Uri uri = Uri.parse('$url/errors/');
      http.Response response = await http.post(
        uri,
        headers: {
          'token': token,
          'Content-Type': 'application/json',
        },
        body: data.toJson(),
      );

      var jsonDecode2 = jsonDecode(response.body);
      print(jsonDecode2);

      if (jsonDecode2['message'] != 'SUCCESS') {
        throw Exception(jsonDecode2['description']);
      }
    } catch (e) {
      print(e.runtimeType);
      print("createError METHOD = $e");
      rethrow;
    }
  }

  Future<void> createTest(TestModel data) async {
    try {
      Uri uri = Uri.parse('$url/tests');
      http.Response response = await http.post(uri,
          headers: {
            'token': token,
            'Content-Type': 'application/json',
          },
          body: data.toJson());

      var jsonDecode2 = jsonDecode(response.body);
      if (jsonDecode2['message'] != 'SUCCESS') {
        throw Exception(jsonDecode2['description']);
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> createDeploy(DeployModel data) async {
    try {
      Uri uri = Uri.parse('$url/deploys');
      http.Response response = await http.post(uri,
          headers: {
            'token': token,
            'Content-Type': 'application/json',
          },
          body: data.toJson());

      var jsonDecode2 = jsonDecode(response.body);
      if (jsonDecode2['message'] != 'SUCCESS') {
        throw Exception(jsonDecode2['description']);
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<ErrorModel>> getErrors() async {
    try {
      Uri uri = Uri.parse('$url/errors');
      http.Response response = await http.get(
        uri,
        headers: {
          'token': token,
        },
      );

      var jsonDecode2 = jsonDecode(response.body);
      if (jsonDecode2['message'] != 'SUCCESS') {
        throw Exception(jsonDecode2['description']);
      }

      List<dynamic> data = jsonDecode2['data']['info'];

      List<ErrorModel> list = data.map((e) => ErrorModel.fromMap(e)).toList();
      return list.reversed.toList();
    } catch (e) {
      print(e);

      rethrow;
    }
  }

  Future<List<TestModel>> getTests() async {
    try {
      Uri uri = Uri.parse('$url/tests');
      http.Response response = await http.get(
        uri,
        headers: {
          'token': token,
        },
      );

      var jsonDecode2 = jsonDecode(response.body);
      if (jsonDecode2['message'] != 'SUCCESS') {
        throw Exception(jsonDecode2['description']);
      }

      List<dynamic> data = jsonDecode2['data']['info'];
      print(data);
      List<TestModel> list = data.map((e) => TestModel.fromMap(e)).toList();
      return list.reversed.toList();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<DeployModel>> getDeploys() async {
    try {
      Uri uri = Uri.parse('$url/deploys');
      http.Response response = await http.get(
        uri,
        headers: {
          'token': token,
        },
      );

      var jsonDecode2 = jsonDecode(response.body);
      if (jsonDecode2['message'] != 'SUCCESS') {
        throw Exception(jsonDecode2['description']);
      }

      List<dynamic> data = jsonDecode2['data']['info'];
      List<DeployModel> list = data.map((e) => DeployModel.fromMap(e)).toList();
      return list.reversed.toList();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> updateError(ErrorModel errorModel) async {
    try {
      Uri uri = Uri.parse('$url/errors/${errorModel.error_id}');
      final response = await http.patch(uri,
          headers: {
            'token': token,
            'Content-Type': 'application/json',
          },
          body: errorModel.toJson());
      var jsonDecode2 = jsonDecode(response.body);
      if (jsonDecode2['message'] != 'SUCCESS') {
        throw Exception(jsonDecode2['description']);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateTest(TestModel testModel) async {
    try {
      Uri uri = Uri.parse('$url/tests/${testModel.test_id}');
      final response = await http.patch(uri,
          headers: {
            'token': token,
            'Content-Type': 'application/json',
          },
          body: testModel.toJson());
      var jsonDecode2 = jsonDecode(response.body);
      if (jsonDecode2['message'] != 'SUCCESS') {
        throw Exception(jsonDecode2['description']);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateDeploy(DeployModel deployModel) async {
    try {
      Uri uri = Uri.parse('$url/deploys/${deployModel.deploy_id}');
      final response = await http.patch(uri,
          headers: {
            'token': token,
            'Content-Type': 'application/json',
          },
          body: deployModel.toJson());
      var jsonDecode2 = jsonDecode(response.body);
      if (jsonDecode2['message'] != 'SUCCESS') {
        throw Exception(jsonDecode2['description']);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteError(ErrorModel model) async {
    try {
      Uri uri = Uri.parse('$url/errors/${model.error_id}');
      final response = await http.delete(
        uri,
        headers: {'token': token},
      );
      var jsonDecode2 = jsonDecode(response.body);
      if (jsonDecode2['message'] != 'SUCCESS') {
        throw Exception(jsonDecode2['description']);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteTest(TestModel model) async {
    try {
      Uri uri = Uri.parse('$url/tests/${model.test_id}');
      final response = await http.delete(
        uri,
        headers: {'token': token},
      );
      var jsonDecode2 = jsonDecode(response.body);
      if (jsonDecode2['message'] != 'SUCCESS') {
        throw Exception(jsonDecode2['description']);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteDeploy(DeployModel model) async {
    try {
      Uri uri = Uri.parse('$url/deploys/${model.deploy_id}');
      final response = await http.delete(
        uri,
        headers: {'token': token},
      );
      var jsonDecode2 = jsonDecode(response.body);
      if (jsonDecode2['message'] != 'SUCCESS') {
        throw Exception(jsonDecode2['description']);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<UserModel>> getUsers(String query) async {
    try {
      Uri uri = Uri.parse('$url/users');
      http.Response response = await http.get(
        uri,
        headers: {
          'token': token,
        },
      );

      var jsonDecode2 = jsonDecode(response.body);
      if (jsonDecode2['message'] != 'SUCCESS') {
        throw Exception(jsonDecode2['description']);
      }

      List<dynamic> data = jsonDecode2['data']['info'];
      List<UserModel> list = data.map((e) => UserModel.fromMap(e)).toList();
      return list;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
