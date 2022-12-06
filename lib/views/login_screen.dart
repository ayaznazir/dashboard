
import 'package:dashboard/controller/auth_controller.dart';
import 'package:dashboard/views/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool value = false;
  final signupController = Get.put(SignInController());
  var nameController = TextEditingController();
  var deviceName = TextEditingController();
  var passController = TextEditingController();
  bool isLoading = false;
  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
            padding:  const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Image.asset("images/smile.png", width: 200, height: 200,),

                  const SizedBox(
                    height: 50,
                  ),

                  TextFormField(
                    controller: deviceName,

                    decoration:  InputDecoration(
                      hintText: "Device name",
                      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black),
                      ),

                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                  TextFormField(
                    controller: nameController,
                    decoration:  InputDecoration(
                      hintText: "Username",
                      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black),
                      ),

                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  TextFormField(
                    controller: passController,
                    obscureText: isObsecure,
                    decoration:  InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: IconButton(icon: isObsecure ? const Icon(Icons.visibility_off) :const Icon(Icons.visibility),
                        onPressed: (){
                          setState(() {
                            isObsecure = !isObsecure;
                          });
                        },),
                      hintText: "Password",
                      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: value,
                            onChanged: (value) {
                              setState(() {
                                this.value = value!;
                              });
                            },
                          ),
                          const Text("Remember", style: TextStyle(fontSize: 12, color: Colors.black),),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(350, 50),
                        backgroundColor: Colors.lightBlue,
                        elevation: 0,
                      //  side:  BorderSide(color: Colors.yellow.shade700)
                    ),
                    onPressed: ()async {
                      if(deviceName.text.isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter device name")));
                      }else if(nameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter Username")));
                      }else if(passController.text.isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter valid password")));
                      }else {
                        SharedPreferences sp = await SharedPreferences.getInstance();
                        setState(() {
                          isLoading = true;
                        });
                          signupController.loading(true);
                          signupController.signin(deviceName.text, nameController.text,passController.text, context).then((value) {
                            if(value!.status!.success == false){
                              setState(() {
                                isLoading = false;
                              });
                               ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(value.status!.message.toString())));
                            }else {
                              sp.setString("device", deviceName.text);
                              sp.setString("userid", nameController.text);
                              sp.setString("token", value.token.toString());
                              print(value.token.toString());
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => DashBoardScreen()), (route) => false);
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Success login")));
                              setState(() {
                                isLoading = false;
                              });
                            }
                            signupController.loading(false);
                        
                          setState(() {
                         //   isLoading = false;
                          });
                        });
                      }
                      

                    },
                    child: isLoading ? const CircularProgressIndicator(color: Colors.white,) : const Text('Sign In', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  ),


                ],
              ),
            ),
          )),
    );
  }
}
