 
import 'dart:io';

import 'package:dash_chat_2/dash_chat_2.dart';

  
class ChatMessageModel {
  ChatUser user;
  String? message;
  String type;
  String? audio;
  File? image;
  String? networkImage;
  String? userAudio;
  bool? isFirst;
  // DateTime time;
  ChatMessageModel({
    required this.user,
    this.message,
    required this.type,
    this.audio,
    this.networkImage,
    this.isFirst,
    this.image,
    this.userAudio,
    // required this.time,
  });

  get id => null;
}
 