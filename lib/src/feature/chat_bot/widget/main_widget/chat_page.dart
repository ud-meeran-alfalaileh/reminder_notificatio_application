import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_async/src/config/sizes/size_box_extension.dart';
import 'package:time_async/src/config/sizes/sizes.dart';
import 'package:time_async/src/config/theme/theme.dart';
import 'package:time_async/src/feature/chat_bot/controller/chat_controller.dart';
import 'package:time_async/src/feature/home/widget/text/home_text.dart';

class ChatPage extends StatelessWidget {
  final ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightAppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Title
            HomeText.secText("ChatBot"),
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
              color: Colors.white, // Add background for better visibility
              child: Row(
                children: [
                  // Text input
                  Expanded(
                    child: TextField(
                      controller: controller.messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type your message...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  // Send button
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      final message = controller.messageController.text.trim();
                      if (message.isNotEmpty) {
                        controller.sendMessage(message);
                        controller.messageController.clear();
                      }
                    },
                  ),
                ],
              ),
            ),

            (context.screenHeight * .1).kH
          ],
        ),
      ),
    );
  }
}
