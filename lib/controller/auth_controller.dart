import 'dart:convert';
import 'dart:io';

import 'package:dashboard/model.dart';
import 'package:dashboard/models/feed_back.dart';
import 'package:dashboard/models/user.dart';
import 'package:dashboard/services/auth_service.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignInController extends GetxController {
  Dashboard2? dashboard2;
  Dashboard? dashboard;
  User? user;
  FeedbackDetails? feedbackDetails;
  Blocks? blocks;
//  List<Blocks>? subcategories;
  var loading = false.obs;
  var loading1 = false.obs;
  var loading2 = false.obs;
  var loading3 = false.obs;
  var loading4 = false.obs;
   var client = http.Client().obs;

   Future<User?> signin(String deviceName, String username, String password,BuildContext context) async {
    SharedPreferences preferences =await SharedPreferences.getInstance();
    try {
      loading(true);
      var headers = {
        'tenantid': '2886241',
        'Content-Type': 'application/json'
      };
      final body =  json.encode({
        "device": deviceName,
        "userid": username,
        "password": password,
      });
      var response = await http.post(Uri.parse("https://redhaapi.luckyapps.org:443/api/feedback/V1/login"),
          headers: headers, body: body);
      var jsonData = jsonDecode(response.body);
      user = User.fromJson(jsonData);
      loading(false);
      return user;
    } catch (e) {
      print(e);
    }
  }

 /* Future signin( String username, String password, String deviceName) async {
    try {
      loading(true);
      var response = await AuthService.signin(username, password, deviceName);
      if (response != null) {
        print("response is: $response");
      } else {
        return false;
      }
    } finally {
      loading(false);
    }
  }*/

/*  Future<Dashboard2?> getDashBoardData( String token, String deviceID,String userid) async {

    try {
      loading(true);
      var response = await AuthService.getDashBoardData(token, deviceID, userid);
      if (response != null) {
          dashboard2.value = response;
          print(response);
      } else {
      }
    } finally {
      loading(false);
    }
  }*/
  Future<Dashboard2?> getDashBoardDatas(String token, String deviceID , String userid , int modetype, int periodtype , int statusTpe)async {
    var headers = {
      'Content-Type': 'application/json'
    };
    final body = json.encode({
      "token": token,
      "device": deviceID,
      "userid": userid,
      "modetype": modetype,
      "periodtype": periodtype,
      "statustype": statusTpe
    });
    try {
      loading1(true);
      var response = await http.post(Uri.parse('https://redhaapi.luckyapps.org:443/api/feedback/V1/dashboard'),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body)["dashboard"];
        print(jsonResponse);
        dashboard2 =  Dashboard2.fromJson(jsonResponse);

      }
      else {

      }
      loading1(false);
    }catch(e){
      loading1(false);
     // loading(false);
      print(e);
    }
  }
  Future<List<Blocks>?> getDashBoardData(String token, String deviceID , String userid)async {
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
    try {
      loading2(true);
      var response = await http.post(Uri.parse('https://redhaapi.luckyapps.org:443/api/feedback/V1/dashboard'),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        var block = jsonDecode(response.body);
        print(block);
        dashboard = Dashboard.fromJson(block);
        print(dashboard!.blocks!.length);

        loading2(false);

      }
      else {

      }
    }catch(e){
    //  loading(false);
      print(e);
    }


  }
  Future<List<Blocks>?> getFeedBack(String token, String deviceID , String userid, String feedbackId)async {
    var headers = {
      'Content-Type': 'application/json'
    };
    final body = json.encode( {
      "token": "token",
      "device": deviceID,
      "userid": userid,
      "feedbackid": feedbackId,
      "action" : 1,
    });
    try {
      loading3(true);
      var response = await http.post(Uri.parse('https://redhaapi.luckyapps.org:443/api/feedback/V1/feedbackdetails'),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        var feedback = jsonDecode(response.body)["feedbackDetails"];
        print(feedback);
        feedbackDetails = FeedbackDetails.fromJson(feedback);
        print(dashboard!.blocks!.length);

        loading3(false);

      }
      else {

      }
    }catch(e){
      //  loading(false);
      print(e);
    }


  }
  Future noteSubmit(String token, String deviceID , String userid, String feedbackid, String notes)async {
    var headers = {
      'Content-Type': 'application/json'
    };
    final body = json.encode( {
      "token": token,
      "device": deviceID,
      "userid": userid,
      "feedbackid": feedbackid,
      "action": 1, //0- Hold, 1-Forward, 2-Close
      "notes": notes
    });
  try{
    loading4(true);
    var response = await http.post(Uri.parse('https://redhaapi.luckyapps.org:443/api/feedback/V1/dashboard'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body)["status"];
      print(jsonResponse);
      //  return Dashboard2.fromJson(jsonResponse);
      loading4(false);
    }
    else {

    }
  }catch(e){

  }
  }
}