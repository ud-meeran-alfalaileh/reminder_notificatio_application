import 'dart:convert';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  RxList<ChatMessage> chatMessages = <ChatMessage>[].obs;

  late ChatUser currentUser = ChatUser(
    id: "0",
    firstName: 'User',
  );

  ChatUser chatGptUser = ChatUser(
    id: "1",
    firstName: "TimeSync",
  );

  List<Map<String, dynamic>> conversationHistory = [];

  Future<void> sendMessage(String message) async {
    messageController.clear();

    // Add user's message to chatMessages
    ChatMessage userMessage = ChatMessage(
      user: currentUser,
      createdAt: DateTime.now(),
      text: message,
    );
    chatMessages.insert(0, userMessage);

    // Add message to conversationHistory
    conversationHistory.add({'role': 'user', 'content': message});

    await generateResponse(message);
  }

  Future<void> generateResponse(String message) async {
    try {
      var response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {'Content-Type': 'application/json', 'Authorization': ""},
        body: json.encode({
          'model': 'gpt-4o-mini',
          'messages': [
            {
              'role': 'user',
              'content':
                  '''You are a virtual assistant integrated into the Time Sync application. Your primary role is to 
                  assist users with managing their reminders and notifications. You can explain how to set notifications for specific 
                  times (e.g., two hours, one day, or weekly), mark notifications as favorites, and provide detailed information about the app's
                   features. When users ask questions about the application, respond with accurate, concise, and user-friendly answers. If the query goes beyond 
                  the app's features, offer helpful general guidance. Maintain a friendly and approachable tone in every interaction.'''
            },
            {'role': 'user', 'content': message},
            ...conversationHistory,
          ],
        }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        var data = json.decode(utf8.decode(response.bodyBytes));
        var responseText = data['choices'][0]['message']['content'];

        // Add AI's response to chatMessages
        ChatMessage aiMessage = ChatMessage(
          user: chatGptUser,
          createdAt: DateTime.now(),
          text: responseText,
        );
        chatMessages.insert(0, aiMessage);

        // Update conversationHistory
        conversationHistory.add({'role': 'assistant', 'content': responseText});
      } else {
        ChatMessage errorMessage = ChatMessage(
          user: chatGptUser,
          createdAt: DateTime.now(),
          text: "Error: Unable to fetch response.",
        );
        chatMessages.insert(0, errorMessage);
      }
    } catch (e) {
      ChatMessage errorMessage = ChatMessage(
        user: chatGptUser,
        createdAt: DateTime.now(),
        text: "Error: Unable to fetch response.",
      );
      chatMessages.insert(0, errorMessage);
    }
  }
}
