import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_hub/localStorage/local_storage.dart';
import 'package:quiz_hub/models/loginResponse.dart';

class APICalls {
  final localStorage _storage = localStorage();
  Future<loginResponse> loginAPI(String email, String password) async{
try{

  http.Response login = await http.post(Uri.parse('http://localhost:3000/api/user/jwt'),
      headers: {'Content-Type':'application/json'}, body: json.encode({
    'email': email,
    'password': password,
  }));
  final data = json.decode(login.body.toString());
  if(login.statusCode == 200){
    loginResponse loginUser = loginResponse.fromJson(data);
    _storage.setUser(loginUser);
  return loginUser;
  }else{
    throw data['error'];
  }
  }catch(e){
  rethrow;
  }
}
}