import 'package:flutter/material.dart';
import 'package:my_tools_development/MyTools/tools/Button_Tools/MyButton.dart';
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
    return Center(
      child: MyButton(
        text: "hi",
         tooltipMessage: "khvjg",
         icon:Icon( Icons.abc),
         gradient: LinearGradient(colors:[Colors.red,Colors.blue]),
        onTap: () {
          print("hi");
        },
      ),
    );
  }
}

    // return CustomizableChatScreen(
    //   title: "Chat with Support",
    //   currentUser: UserProfile(id: "23", name: "dj"),
    //   chatPartner: UserProfile(id: "sd", name: "sdc"),
    //   theme: ChatTheme.modernLight(), // or modernDark() for dark mode
    //   messageBubbleConfig: MessageBubbleConfig.modern(),
    //   inputAreaConfig: InputAreaConfig.modern(),
    //   reactionConfig: ReactionConfig.modern(),
    //   quickReactions: CustomizableChatScreen.expandedReactions,
    //   onReactionAdded: (message, emoji) {
    //     print(message.text);
    //     print(emoji);
    //   },
    //   autoRespond: true,
    //   autoRespondText: "ok",
    // );