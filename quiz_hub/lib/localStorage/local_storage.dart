import 'dart:convert';
import 'package:quiz_hub/models/loginResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class localStorage{
  //saving credentials of logged in user
  Future<bool> setUser(loginResponse user) async {
    print(user.email);
   SharedPreferences sp = await SharedPreferences.getInstance();

   bool userName = await sp.setString('user', json.encode(user.toJson()));
   // print(userName);
   return userName;
  }

  //retrieving saved credentials of logged in user
  Future<loginResponse> getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? userName = await sp.getString('user');
    print(userName);
    return loginResponse.fromJson(json.decode(userName!));
  }

  //saving details of attemted quiz locally
  Future<bool> setResultDataLocally(Map<String, dynamic> resultData) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String jsonResultData = jsonEncode(resultData);

    bool setUserResultData = await sp.setString('studentResultDetails', jsonResultData);
    print('data locally saved successfully!');
    print(setUserResultData);
    return setUserResultData;
  }

  //retrieving saved credentials of logged in user
  Future<Map<String, dynamic>?> getResultDataLocally() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? jsonResultData = await sp.getString('studentResultDetails');
    if (jsonResultData != null) {
      Map<String, dynamic> resultData = jsonDecode(jsonResultData);
      print(resultData);
      return resultData;
    } else {
      return null;
    }
  }

}


