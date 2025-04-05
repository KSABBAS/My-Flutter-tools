import 'package:flutter/material.dart';
import 'package:my_tools_development/MyTools/tools/Text_Tools/Texting/AnimatedChatScreen.dart';
import 'package:my_tools_development/MyTools/tools/Video_Tools/miniVideoPlayer/miniVideoPlayer.dart';
import 'package:my_tools_development/MyTools/tools/internet_tools/IsConnected/IsConnected.dart';

void main() => runApp(VideoPlayerApp());

class VideoPlayerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Video Player Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: Scaffold(body: MyApp()),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return CustomizableChatScreen(
        quickReactions: ["hi"],
        autoRespond: true,
        onMessageSent: (message) {
          print(message.text);
        },
        onMessageReceived: (message) {
          print(message.text);
        },
        enableReactions: true,
        enableEmojis: true,
        enableAttachments: true,
        title: "hi",
        currentUser: UserProfile(id: "hi", name: "kareem"),
        theme: ChatTheme(),
        myImageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyzTWQoCUbRNdiyorem5Qp1zYYhpliR9q0Bw&s",
        otherImageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyzTWQoCUbRNdiyorem5Qp1zYYhpliR9q0Bw&s",
        showAppBar: false,
        messageBubbleConfig: MessageBubbleConfig(),
        );
  }
}
