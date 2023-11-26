import 'dart:convert';
import 'package:quiz_hub/models/loginResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class localStorage{
  Future<bool> setUser(loginResponse user) async {
    print(user.email);
   SharedPreferences sp = await SharedPreferences.getInstance();

   bool userName = await sp.setString('user', json.encode(user.toJson()));
   // print(userName);
   return userName;
  }

  Future<loginResponse> getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? userName = await sp.getString('user');
    print(userName);
    return loginResponse.fromJson(json.decode(userName!));
  }

}