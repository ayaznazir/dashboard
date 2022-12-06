import 'dart:convert';
import 'dart:io';
import 'package:dashboard/model.dart';
import 'package:http/http.dart' as http;
import 'package:device_info/device_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static var client = http.Client();
  static Future signin(String username, String password, String deviceName) async {
    SharedPreferences preferences =await SharedPreferences.getInstance();
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo? androidInfo;
      IosDeviceInfo? iosInfo;
      if (Platform.isAndroid) {
        androidInfo = await deviceInfo.androidInfo;
      }
      if (Platform.isIOS) {
        iosInfo = await deviceInfo.iosInfo;
      }
      var headers = {
        'tenantid': '2886241',
        'Content-Type': 'application/json'
      };
      final body =  json.encode({
        "device": deviceName,
        "userid": username,
        "password": password,
      });
      // Map<String, String> headers = {
      //   'Content-Type': "application/json",
      //   'deviceid': (Platform.isAndroid)
      //       ? androidInfo!.androidId
      //       : iosInfo!.identifierForVendor,
      // };
     /* final body = jsonEncode({
        "mobile": mobile,
        "password": password,
      });*/
      var response = await client.post(Uri.parse("https://redhaapi.luckyapps.org:443/api/feedback/V1/login"),
          headers: headers, body: body);
      print("login: ${response.body}");
      if (response.statusCode == 200) {
        var  json  = jsonDecode(response.body)["token"];
          print(androidInfo!.androidId);
          preferences.setString("device", deviceName);
          preferences.setString("userid", username);
          preferences.setString("token", json);
          print("Tissssss is $json");
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<Dashboard2?> getDashBoardData(String token, String deviceID , String userid)async {
    var headers = {
      'Content-Type': 'application/json'
    };
    final body = json.encode({
      "token": token,
      "device": deviceID,
      "userid": userid,
      "modetype": 0,
      "periodtype": 0,
      "statustype": 0
    });

    var response = await client.post(Uri.parse('https://redhaapi.luckyapps.org:443/api/feedback/V1/dashboard'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body)["dashboard"];
      print(jsonResponse);
      return Dashboard2.fromJson(jsonResponse);

    }
    else {

    }
  }


}