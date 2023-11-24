import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_hub/localStorage/local_storage.dart';
import 'package:quiz_hub/models/loginResponse.dart';
import 'package:quiz_hub/models/loginRole.dart';

class APICalls {
  final localStorage _storage = localStorage();
  Future<loginResponse> loginAPI(String email, String password) async {
    try {
      http.Response login =
          await http.post(Uri.parse('http://localhost:3000/api/user/jwt'),
              headers: {'Content-Type': 'application/json'},
              body: json.encode({
                'email': email,
                'password': password,
              }));
      final data = json.decode(login.body.toString());
      if (login.statusCode == 200) {
        loginResponse loginUser = loginResponse.fromJson(data);
        _storage.setUser(loginUser);
        return loginUser;
      } else {
        throw data['error'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<roleLogin> getUserRole(String token) async {
    try {
      http.Response newRole = await http.post(
          Uri.parse('http://localhost:3000/api/user/role'),
          headers: {
            'Content-Type': 'application/json',
            'authorization': 'Bearer $token'
          },
          body: json.encode({}));
      final data = json.decode(newRole.body.toString());
      // print(data);
      // return role;
      roleLogin userRole = roleLogin.fromJson(data);
      return userRole;
    } catch (e) {
      rethrow;
    }
  }
}
