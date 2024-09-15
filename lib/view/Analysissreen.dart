import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthaid/Models/Staticmodel.dart';
import 'package:healthaid/viewmodel/chatbotapi.dart';
import 'package:healthaid/viewmodel/controllers/services/sentimentAnalysiscontroller.dart';

class AnalysisScreen extends StatefulWidget {
  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  @override
  TextEditingController textcontroller = TextEditingController();
  final SentimentControl = Get.put(SentimentController());
  final chatbotcontrol = Get.put(ChatController());

  var height, width;

  Widget build(BuildContext context) {
    // Get the size of the screen
    String name = Staticdata.userModel!.Name.toString();

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.purple],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Container(
              //   width: width,
              //   color: Colors.red,
              //   padding: EdgeInsets.all(10), // 2% of screen width
              //   child: Row(
              //     children: [sa
              //       Icon(Icons.wifi_off,
              //           color: Colors.white,
              //           size: width * 0.05), // 5% of screen width
              //       SizedBox(width: width * 0.02), // 2% of screen width
              //       Text(
              //         "No internet connection. Some features may be limited.",
              //         style: TextStyle(
              //             color: Colors.white,
              //             fontSize: width * 0.03), // 4% of screen width
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                width: width * 0.9,
                child: Text(
                  "Welcome $name !",
                  style: TextStyle(
                    fontSize: width * 0.05, // 5% of screen width
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(width * 0.04), // 4% of screen width
                child: TextFormField(
                  controller: textcontroller,

                  decoration: InputDecoration(
                    hintText: "How are you feeling today?",
                    hintStyle: TextStyle(
                        color: const Color.fromARGB(150, 0, 0, 0),
                        fontSize: width * 0.04), // 4% of screen width
                    filled: true,
                    fillColor: Colors.white.withOpacity(1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          width * 0.05), // 5% of screen width
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send,
                          color: const Color.fromARGB(255, 0, 0, 0),
                          size: width * 0.05), // 5% of screen width
                      onPressed: () {
                        // chatbotcontrol.getChatbotResponse(
                        //     textcontroller.value.toString());
                        SentimentControl.analyzeSentiment(
                            textcontroller.value.toString());
                        print('called the function');
                        //String tips1 = chatbotcontrol.tips.toString();

                        textcontroller.clear();
                      },
                    ),
                  ),
                  style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: width * 0.04), // 4% of screen width
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(width * 0.04), // 4% of screen width
                  padding: EdgeInsets.all(width * 0.04), // 4% of screen width
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(1),
                    borderRadius: BorderRadius.circular(
                        width * 0.05), // 5% of screen width
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Your Health Suggestions",
                        style: TextStyle(
                          fontSize: width * 0.05, // 5% of screen width
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      // SizedBox(height: height * 0.01), // 2% of screen height
                      Expanded(
                        child: Center(child: Obx(
                          () {
                            if (chatbotcontrol.isLoading.value) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return Text(
                                chatbotcontrol.tips.toString(),
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  fontSize: width * 0.04, // 4% of screen width
                                ),
                                textAlign: TextAlign.left,
                              );
                            }
                          },
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
