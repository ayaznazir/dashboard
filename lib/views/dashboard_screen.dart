import 'dart:async';

import 'package:dashboard/controller/auth_controller.dart';
import 'package:dashboard/model.dart';
import 'package:dashboard/views/feedback_screen.dart';
import 'package:dashboard/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  SignInController getDataController = Get.put(SignInController());
  String deviceId = "";
  String userId = "";
  String token1 = "";
  int modetype = 0;
  int periodtype = 0;
  int statustype = 0;
  Future getSp() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    String? device = preferences.getString("device");
    String? userid = preferences.getString("userid");

    setState(() {
      token1 = token!;
      deviceId = device!;
      userId = userid!;

      print(deviceId);
      print(userId);
      print(token1);
    });

  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getSp().then((value) {
        getDataController.getDashBoardDatas(token1, deviceId, userId, modetype, periodtype, statustype);
        getDataController.getDashBoardData(token1, deviceId, userId,);
      });
    });
    super.initState();
  }

  bool isLoad = false;
  bool check = false;
  bool check2 = false;
  bool pcheck = false;
  bool pcheck2 = false;
  bool pchec3k = false;
  bool scheck = false;
  bool schec2k = false;
  bool schec3k = false;

  //return _buildFinancialList(series);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: const Text("Dashboard"),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Are you sure logout"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("No")),
                            TextButton(
                                onPressed: () async {
                                  SharedPreferences pre =
                                      await SharedPreferences.getInstance();
                                  pre.clear();
                                  pre.commit().then((value) {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()),
                                        (route) => false);
                                  });
                                },
                                child: const Text("Yes"))
                          ],
                        );
                      });
                },
                icon: const Icon(
                  Icons.logout,
                  size: 30,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    isLoad = !isLoad;
                  });
                },
                icon: const Icon(
                  Icons.filter_list,
                  size: 30,
                )),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async{
            getDataController.getDashBoardDatas(token1, deviceId, userId, modetype, periodtype, statustype);
            getDataController.getDashBoardData(token1, deviceId, userId);
          },
          child: SafeArea(
            child: GestureDetector(
              onTap: () {
                setState(() {
                //  isLoad = false;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Stack(
                  children: [
                    ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        Obx(() => getDataController.loading1.value
                            ? const Center(child: CircularProgressIndicator())
                            : Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              // physics: ScrollPhysics(),
                              itemCount: getDataController.dashboard2!.tags!.length ,
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(20)),
                                        child: Column(
                                          children: [
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 20,
                                                    height: 200,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey.shade300,
                                                        borderRadius: BorderRadius.circular(20)),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        //Text(getDataController.dashboard2!.tags![index].status!.pending.toString(),style: TextStyle(color: Colors.white),),
                                                        Container(
                                                          width: 20,
                                                          height: 40 +
                                                              getDataController.dashboard2!
                                                                  .tags![index].status!.pending!
                                                                  .toDouble() *
                                                                  5,
                                                          decoration: BoxDecoration(
                                                              color: Colors.red.shade800,
                                                              borderRadius:
                                                              BorderRadius.circular(20)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            /*      Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 200,
                                  width: 18,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue , width: 4)
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 13,
                                        height: getDataController.dashboard2!.tags![index].status!.finished!.toDouble() * 3,
                                        decoration: const BoxDecoration(
                                          color: Colors.orange,
                                            border: Border(

                                              bottom: BorderSide(color: Colors.blue, width: 4),

                                            )
                                        ),
                                      ),
                                      Container(
                                        width: 13,
                                        height: getDataController.dashboard2!.tags![index].status!.pending!.toDouble() * 3,
                                        decoration: const BoxDecoration(
                                            color: Colors.yellow,
                                            border: Border(

                                              bottom: BorderSide(color: Colors.blue, width: 4),

                                            )
                                        ),
                                      ),
                                      Container(
                                        width: 13,
                                        height: getDataController.dashboard2!.tags![index].status!.hold!.toDouble() * 4,
                                        decoration: const BoxDecoration(
                                            color: Colors.green,
                                            border: Border(

                                              bottom: BorderSide(color: Colors.blue, width: 4),

                                            )
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 200,
                                  width: 14,
                                  decoration: const BoxDecoration(
                                      border: Border(
                                        top: BorderSide(color: Colors.blue, width: 4),
                                        bottom: BorderSide(color: Colors.blue, width: 4),
                                        right: BorderSide(color: Colors.blue, width: 4),
                                      ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 13,
                                        height: getDataController.dashboard2!.tags![index].poll!.bad!.toDouble() * 5,
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                            border: Border(

                                              bottom: BorderSide(color: Colors.blue, width: 4),

                                            )
                                        ),
                                      ),
                                      Container(
                                        width: 13,
                                        height: getDataController.dashboard2!.tags![index].poll!.good!.toDouble() * 5,
                                        decoration: const BoxDecoration(
                                          color: Colors.green,
                                            border: Border(

                                              bottom: BorderSide(color: Colors.blue, width: 4),

                                            )
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),*/
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              getDataController.dashboard2!.tags![index].tag
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.black, fontSize: 18),
                                            ),
                                          ],
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    )
                                  ],
                                );
                              }),
                        )),
                        Obx(() => getDataController.loading2.value
                            ? const Center(child: CircularProgressIndicator())
                            : _builScreen2()),
                      ],
                    ),
                    isLoad
                        ? Positioned(
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Container(
                                  width: 300,
                                  height: 170,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.grey.shade200)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  "Mode",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                RoundCheckBox(
                                                  size: 18,
                                                  isChecked: check,
                                                  onTap: (selected) {
                                                    setState(() {
                                                      check = selected!;
                                                      check2 = false;
                                                      modetype = 7;
                                                    });
                                                  },
                                                  checkedWidget: const Icon(
                                                    Icons.circle,
                                                    color: Colors.blue,
                                                    size: 20,
                                                  ),
                                                  uncheckedColor: Colors.white,
                                                  checkedColor: Colors.blue,
                                                  uncheckedWidget: const Icon(
                                                    Icons.circle_outlined,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                const Text("Device"),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                RoundCheckBox(
                                                  isChecked: check2,
                                                  size: 18,
                                                  onTap: (selected) {
                                                    setState(() {
                                                      check2 = selected!;
                                                      check = false;
                                                      modetype = 30;
                                                    });
                                                  },
                                                  checkedWidget: const Icon(
                                                    Icons.circle,
                                                    color: Colors.blue,
                                                    size: 20,
                                                  ),
                                                  uncheckedColor: Colors.white,
                                                  checkedColor: Colors.blue,
                                                  uncheckedWidget: const Icon(
                                                    Icons.circle_outlined,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                const Text("Data"),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  "Period",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                RoundCheckBox(
                                                  isChecked: pcheck,
                                                  size: 18,
                                                  onTap: (selected) {
                                                    setState(() {
                                                      pcheck = selected!;
                                                      pcheck2 = false;
                                                      pchec3k = false;
                                                      periodtype = 1;
                                                    });
                                                  },
                                                  checkedWidget: const Icon(
                                                    Icons.circle,
                                                    color: Colors.blue,
                                                    size: 20,
                                                  ),
                                                  uncheckedColor: Colors.white,
                                                  checkedColor: Colors.blue,
                                                  uncheckedWidget: const Icon(
                                                    Icons.circle_outlined,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                const Text("Day"),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                RoundCheckBox(
                                                  size: 18,
                                                  isChecked: pcheck2,
                                                  onTap: (selected) {
                                                    setState(() {
                                                      pcheck2 = selected!;
                                                      pcheck = false;
                                                      pchec3k = false;
                                                      periodtype = 2;
                                                    });
                                                  },
                                                  checkedWidget: const Icon(
                                                    Icons.circle,
                                                    color: Colors.blue,
                                                    size: 20,
                                                  ),
                                                  uncheckedColor: Colors.white,
                                                  checkedColor: Colors.blue,
                                                  uncheckedWidget: const Icon(
                                                    Icons.circle_outlined,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                const Text("Week"),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                RoundCheckBox(
                                                  size: 18,
                                                  isChecked: pchec3k,
                                                  onTap: (selected) {
                                                    setState(() {
                                                      pchec3k = selected!;
                                                      pcheck2 = false;
                                                      pcheck = false;
                                                      periodtype = 7;
                                                    });
                                                  },
                                                  checkedWidget: const Icon(
                                                    Icons.circle,
                                                    color: Colors.blue,
                                                    size: 20,
                                                  ),
                                                  uncheckedColor: Colors.white,
                                                  checkedColor: Colors.blue,
                                                  uncheckedWidget: const Icon(
                                                    Icons.circle_outlined,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                const Text("Month"),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  "Status",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                RoundCheckBox(
                                                  size: 18,
                                                  isChecked: scheck,
                                                  onTap: (selected) {
                                                 setState(() {
                                                   scheck = selected!;
                                                   schec2k = false;
                                                   schec3k = false;
                                                   statustype = 1;
                                                 });
                                                  },
                                                  checkedWidget: const Icon(
                                                    Icons.circle,
                                                    color: Colors.blue,
                                                    size: 20,
                                                  ),
                                                  uncheckedColor: Colors.white,
                                                  checkedColor: Colors.blue,
                                                  uncheckedWidget: const Icon(
                                                    Icons.circle_outlined,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                const Text("all"),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                RoundCheckBox(
                                                  size: 18,
                                                  isChecked: schec2k,
                                                  onTap: (selected) {
                                                    setState(() {
                                                      schec2k = selected!;
                                                      scheck = false;
                                                      schec3k = false;
                                                      statustype = 2;
                                                    });
                                                  },
                                                  checkedWidget: const Icon(
                                                    Icons.circle,
                                                    color: Colors.blue,
                                                    size: 20,
                                                  ),
                                                  uncheckedColor: Colors.white,
                                                  checkedColor: Colors.blue,
                                                  uncheckedWidget: const Icon(
                                                    Icons.circle_outlined,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                const Text("Pending"),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                RoundCheckBox(
                                                  size: 18,
                                                  isChecked: schec3k,
                                                  onTap: (selected) {
                                                    setState(() {
                                                      schec3k = selected!;
                                                      schec2k = false;
                                                      scheck = false;
                                                      statustype = 3;
                                                    });
                                                  },
                                                  checkedWidget: const Icon(
                                                    Icons.circle,
                                                    color: Colors.blue,
                                                    size: 20,
                                                  ),
                                                  uncheckedColor: Colors.white,
                                                  checkedColor: Colors.blue,
                                                  uncheckedWidget: const Icon(
                                                    Icons.circle_outlined,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                const Text("Close"),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            MaterialButton(
                                              onPressed: () {
                                                getDataController
                                                    .getDashBoardDatas(
                                                        token1, deviceId, userId, modetype, periodtype, statustype);
                                                getDataController
                                                    .getDashBoardData(
                                                        token1, deviceId, userId);
                                                setState(() {
                                                  isLoad = false;
                                                });
                                              },
                                              child: const Text(
                                                "Apply",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              color: Colors.lightBlue,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ))
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget _builScreen() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          // physics: ScrollPhysics(),
          itemCount: getDataController.dashboard2!.tags!.length ,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Container(
                                width: 20,
                                height: 200,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    //Text(getDataController.dashboard2!.tags![index].status!.pending.toString(),style: TextStyle(color: Colors.white),),
                                    Container(
                                      width: 20,
                                      height: 40 +
                                          getDataController.dashboard2!
                                                  .tags![index].status!.pending!
                                                  .toDouble() *
                                              5,
                                      decoration: BoxDecoration(
                                          color: Colors.red.shade800,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        /*      Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 200,
                                  width: 18,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue , width: 4)
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 13,
                                        height: getDataController.dashboard2!.tags![index].status!.finished!.toDouble() * 3,
                                        decoration: const BoxDecoration(
                                          color: Colors.orange,
                                            border: Border(

                                              bottom: BorderSide(color: Colors.blue, width: 4),

                                            )
                                        ),
                                      ),
                                      Container(
                                        width: 13,
                                        height: getDataController.dashboard2!.tags![index].status!.pending!.toDouble() * 3,
                                        decoration: const BoxDecoration(
                                            color: Colors.yellow,
                                            border: Border(

                                              bottom: BorderSide(color: Colors.blue, width: 4),

                                            )
                                        ),
                                      ),
                                      Container(
                                        width: 13,
                                        height: getDataController.dashboard2!.tags![index].status!.hold!.toDouble() * 4,
                                        decoration: const BoxDecoration(
                                            color: Colors.green,
                                            border: Border(

                                              bottom: BorderSide(color: Colors.blue, width: 4),

                                            )
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 200,
                                  width: 14,
                                  decoration: const BoxDecoration(
                                      border: Border(
                                        top: BorderSide(color: Colors.blue, width: 4),
                                        bottom: BorderSide(color: Colors.blue, width: 4),
                                        right: BorderSide(color: Colors.blue, width: 4),
                                      ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 13,
                                        height: getDataController.dashboard2!.tags![index].poll!.bad!.toDouble() * 5,
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                            border: Border(

                                              bottom: BorderSide(color: Colors.blue, width: 4),

                                            )
                                        ),
                                      ),
                                      Container(
                                        width: 13,
                                        height: getDataController.dashboard2!.tags![index].poll!.good!.toDouble() * 5,
                                        decoration: const BoxDecoration(
                                          color: Colors.green,
                                            border: Border(

                                              bottom: BorderSide(color: Colors.blue, width: 4),

                                            )
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),*/
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          getDataController.dashboard2!.tags![index].tag
                              .toString(),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 10,
                )
              ],
            );
          }),
    );
  }

  Widget _builScreen2() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: getDataController.dashboard!.blocks!.length,
        itemBuilder: (context, index) {
          var now =
              getDataController.dashboard!.blocks![index].crDate.toString();
          DateTime dateTime = DateTime.parse(now);
          String dateformat = DateFormat("dd.MM.yyyy").format(dateTime);

          return Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FeedBackScreen(
                                token: token1,
                                deviceID: deviceId,
                                userid: userId,
                                feedbackId: getDataController
                                    .dashboard!.blocks![index].id
                                    .toString(),
                                date: dateformat,
                                // date: dateformat,
                              )));
                },
                child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.lightBlue, width: 2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                            width: 70,
                            height: 70,
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            child: Image.asset("images/yes.png")),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  "${getDataController.dashboard!.blocks![index].device.toString()}  ",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  child: Text(
                                    dateformat,
                                    overflow: TextOverflow.clip,
                                    softWrap: false,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              getDataController.dashboard!.blocks![index].name
                                  .toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  getDataController
                                      .dashboard!.blocks![index].mobile
                                      .toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                MaterialButton(
                                  onPressed: () async {
                                    /* SharedPreferences pre = await SharedPreferences.getInstance();
                                    pre.clear();
                                    pre.commit();*/
                                  },
                                  color: Colors.white,
                                  child: const Text(
                                    "Open",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  shape: const RoundedRectangleBorder(
                                      side:
                                          BorderSide(color: Colors.lightBlue)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    )

                    /* ListTile(
                      leading: Image.asset("images/yes.png"),
                      title:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("${getDataController.dashboard!.blocks![index].device.toString()}  ",
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: Text(DateFormat('MMMM').format(DateFormat("dd").parse(getDataController.dashboard!.blocks![index].crDate.toString())),
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          Text("${getDataController.dashboard!.blocks![index].name.toString()}  ",
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                          ),

                          Text("${getDataController.dashboard!.blocks![index].mobile.toString()}  ",
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                          ),
                        ],
                      ),
                      trailing: MaterialButton(
                        onPressed: (){

                        },
                        color: Colors.red,
                        child: Text("Open", style: TextStyle(color: Colors.white),),

                      ),
                    )*/

                    ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          );
        });
  }
}
