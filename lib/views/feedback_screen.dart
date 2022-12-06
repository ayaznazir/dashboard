import 'package:dashboard/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
class FeedBackScreen extends StatefulWidget {
  final String token;
  final String deviceID;
  final String userid;
  final String feedbackId;
  final String date;

  const FeedBackScreen({super.key, required this.token, required this.deviceID, required this.userid, required this.feedbackId, required this.date});

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  var feedbackController = Get.put(SignInController());
  var controller = TextEditingController();
  @override
  void initState() {
    feedbackController.getFeedBack(widget.token, widget.deviceID, widget.userid, widget.feedbackId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.lightBlue,
      title: const Text("FeedBack"),
      automaticallyImplyLeading: false,
    ),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                SingleChildScrollView(
                  child:  Obx(() => feedbackController.loading3.value
                      ? const Center(child: CircularProgressIndicator())
                      : Container(
                       height: 120,
                       width: MediaQuery.of(context).size.width,
                       decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.lightBlue, width: 2),
                        borderRadius: BorderRadius.circular(10)),
                    child:  Row(
                      children: [

                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Row(

                              children: [
                                Text(feedbackController.feedbackDetails!.block!.device.toString(),
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 20,),
                                 SizedBox(
                                  child: Text(widget.date,
                                    overflow: TextOverflow.clip,
                                    softWrap: false,
                                    maxLines: 1,
                                    style: const TextStyle(

                                        color: Colors.black, fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            Text(feedbackController.feedbackDetails!.block!.name.toString(),   style: const TextStyle(
                                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(feedbackController.feedbackDetails!.block!.mobile.toString(),    style: const TextStyle(
                                    color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                                const SizedBox(
                                  width: 100,
                                ),
                                MaterialButton(
                                  onPressed: (){

                                  },
                                  color: Colors.white,
                                  child: const Text("Open", style: TextStyle(color: Colors.black),),
                                  shape: const RoundedRectangleBorder(
                                      side: BorderSide(color: Colors.lightBlue)
                                  ),

                                ),
                              ],
                            ),



                          ],
                        ),
                      ],
                    ),
                  )),
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(() => feedbackController.loading3.value
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                     itemCount: feedbackController.feedbackDetails!.questions!.length,
                     itemBuilder: (context , index){
                       return Column(
                         children: [
                           Container(
                             height: 70,
                             decoration: const BoxDecoration(
                               border: Border(
                                 top: BorderSide(color: Colors.lightBlue, width: 2),
                                 left: BorderSide(color: Colors.lightBlue, width: 2),
                                 right: BorderSide(color: Colors.lightBlue, width: 2),
                                 bottom: BorderSide(color: Colors.lightBlue, width: 2),
                               ),
                             ),
                             child: ListTile(
                                 title: Text(feedbackController.feedbackDetails!.questions![index].qEnglish.toString(),  style: const TextStyle(
                                     color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                                 ),

                                trailing:  feedbackController.feedbackDetails!.questions![index].id == 1 ? Image.asset("images/yes.png", width: 50, height: 60,) : Image.asset("images/1.png", width: 50, height: 60,) ,
                                // trailing: Image.network(feedbackController.feedbackDetails!.questions![index].toString()),
                             ),
                           ),
                           const SizedBox(
                             height: 5,
                           ),

                         ],
                       );
                     },
                )),
                const SizedBox(
                  height: 15,
                ),
                Obx(() => feedbackController.loading3.value
                    ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: feedbackController.feedbackDetails!.logs!.isNotEmpty ? feedbackController.feedbackDetails!.logs!.length : null,
                    itemBuilder: (context , index){
                      var now = feedbackController.feedbackDetails!.logs![index].crDate.toString();
                      DateTime dateTime = DateTime.parse(now);
                      String dateformat = DateFormat( "dd.MM.yyyy").format(dateTime);
                    return Column(
                      children: [
                        Container(

                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.lightBlue, width: 2),
                          ),
                          child: ListTile(
                            title: Text(feedbackController.feedbackDetails!.logs![index].user ?? "User",   style: const TextStyle(
                                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(feedbackController.feedbackDetails!.logs![index].remarks ?? "User",   style: const TextStyle(
                                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            trailing: Text(dateformat ?? ""),
                            // trailing: Image.network(feedbackController.feedbackDetails!.questions![index].toString()),
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),

                      ],
                    );
                  },
                )),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: controller,
                  decoration:  InputDecoration(
                    hintText: "Notes :",
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
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                    child: const Text("Close"),
                      color: Colors.green,
                    ),
                    MaterialButton(
                      onPressed: () {
                        if(controller.text.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter note")));
                        }else{
                          feedbackController.noteSubmit(widget.token, widget.deviceID, widget.userid, widget.feedbackId, controller.text).then((value){
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Submitted Logs")));
                          });
                        }
                      },
                      child: const Text("Forword"),
                      color: Colors.lightBlue,
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                      color: Colors.green,
                    ),
                  ],
                ),

                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          )),
    );
  }
}
