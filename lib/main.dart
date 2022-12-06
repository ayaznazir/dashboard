import 'package:dashboard/views/dashboard_screen.dart';
import 'package:dashboard/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String deviceId = "";

  String userId = "";

  String token1 = "";

  void getSp()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? device = preferences.getString("device");
    String? userid = preferences.getString("userid");
    String? token = preferences.getString("token");
    setState(() {
      deviceId = device!;
      userId = userid!;
      token1 = token!;
    });
  }
  @override
  void initState() {
    getSp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: deviceId == "" ? const LoginScreen() : const DashBoardScreen(),
    );
  }
}
