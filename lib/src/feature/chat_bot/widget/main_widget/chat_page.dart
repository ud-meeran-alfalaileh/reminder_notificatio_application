import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_async/src/config/sizes/size_box_extension.dart';
import 'package:time_async/src/config/sizes/sizes.dart';
import 'package:time_async/src/config/theme/theme.dart';
import 'package:time_async/src/feature/chat_bot/controller/chat_controller.dart';
import 'package:time_async/src/feature/home/widget/text/home_text.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(
      {super.key,
      required this.title,
      required this.description,
      required this.notification});

  final String description;
  final String title;
  final String notification;
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatController controller = Get.put(
    ChatController(),
  );
  @override
  void initState() {
    controller.chatMessages.clear();
    controller.generateResponse(
        "", widget.description, widget.title, widget.notification);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightAppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            //
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Color(0xffffffff),
                    )),
                HomeText.secText("ChatBot"),
              ],
            ),
            // Chat messages
            Obx(
              () => Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  reverse: true,
                  itemCount: controller.chatMessages.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return 10.0.kH;
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment:
                              controller.chatMessages[index].user.id == '1'
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                          children: [
                            Container(
                                width: context.screenWidth * .6,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppTheme.lightAppColors.bordercolor),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    HomeText.headerText(controller
                                        .chatMessages[index].user.firstName),
                                    HomeText.chatText(
                                        controller.chatMessages[index].text),
                                  ],
                                )),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            20.0.kH,
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.white
                  .withOpacity(0.4), // Add background for better visibility
              child: Row(
                children: [
                  // Text input
                  Expanded(
                    child: TextField(
                        controller: controller.messageController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppTheme.lightAppColors.mainTextcolor
                                  .withOpacity(0.1),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          border: const OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppTheme.lightAppColors.mainTextcolor
                                  .withOpacity(0.1),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          hintText: 'Type your message...',
                          hintStyle: TextStyle(
                            fontFamily: "kanti",
                            fontWeight: FontWeight.w200,
                            letterSpacing: .5,
                            color: AppTheme.lightAppColors.mainTextcolor
                                .withOpacity(.5),
                            fontSize: 20,
                          ),
                        )),
                  ),
                  // Send button
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      color: AppTheme.lightAppColors.primary,
                    ),
                    onPressed: () {
                      final message = controller.messageController.text.trim();
                      if (message.isNotEmpty) {
                        controller.sendMessage(message, widget.description,
                            widget.title, widget.notification);
                        controller.messageController.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
