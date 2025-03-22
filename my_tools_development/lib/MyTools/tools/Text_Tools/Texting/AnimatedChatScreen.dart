import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

// Message model to store different types of messages
class ChatMessage {
  final String id;
  final String text;
  final bool isMe;
  final DateTime timestamp;
  final MessageType type;
  final String? mediaUrl;
  final List<String> reactions;
  final bool isNew;
  final Map<String, dynamic>? metadata; // For additional custom data

  ChatMessage({
    required this.id,
    required this.text,
    required this.isMe,
    required this.timestamp,
    required this.type,
    this.mediaUrl,
    this.reactions = const [],
    this.isNew = false,
    this.metadata,
  });

  // Create a copy of the message with modifications
  ChatMessage copyWith({
    String? id,
    String? text,
    bool? isMe,
    DateTime? timestamp,
    MessageType? type,
    String? mediaUrl,
    List<String>? reactions,
    bool? isNew,
    Map<String, dynamic>? metadata,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      text: text ?? this.text,
      isMe: isMe ?? this.isMe,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      reactions: reactions ?? this.reactions,
      isNew: isNew ?? this.isNew,
      metadata: metadata ?? this.metadata,
    );
  }
}

enum MessageType { text, image, video, emoji, file, audio, location }

// Callback typedefs
typedef MessageSentCallback = void Function(ChatMessage message);
typedef MessageReceivedCallback = void Function(ChatMessage message);
typedef ReactionAddedCallback = void Function(ChatMessage message, String emoji);
typedef AttachmentPickedCallback = void Function(String type);

// Theme configuration for the chat UI
class ChatTheme {
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;
  final Color sentMessageColor;
  final Color receivedMessageColor;
  final Color sentMessageTextColor;
  final Color receivedMessageTextColor;
  final Color timestampColor;
  final Color appBarColor;
  final Color inputBarColor;
  final Color hintTextColor;
  final String fontFamily;
  final double fontSize;
  final double messageBorderRadius;
  final bool showUserAvatar;
  final bool showSentStatus;
  final String? backgroundImage;
  final Brightness brightness;
  final BoxShadow? messageShadow;
  final EdgeInsets messagePadding;

  ChatTheme({
    this.primaryColor = Colors.blue,
    this.secondaryColor = Colors.grey,
    this.backgroundColor = Colors.white,
    this.sentMessageColor = Colors.blue,
    this.receivedMessageColor = Colors.grey,
    this.sentMessageTextColor = Colors.white,
    this.receivedMessageTextColor = Colors.black,
    this.timestampColor = Colors.grey,
    this.appBarColor = Colors.blue,
    this.inputBarColor = Colors.white,
    this.hintTextColor = Colors.grey,
    this.fontFamily = 'Roboto',
    this.fontSize = 16.0,
    this.messageBorderRadius = 16.0,
    this.showUserAvatar = true,
    this.showSentStatus = true,
    this.backgroundImage,
    this.brightness = Brightness.light,
    this.messageShadow,
    this.messagePadding = const EdgeInsets.all(12.0),
  });

  // Create a copy with modifications
  ChatTheme copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? backgroundColor,
    Color? sentMessageColor,
    Color? receivedMessageColor,
    Color? sentMessageTextColor,
    Color? receivedMessageTextColor,
    Color? timestampColor,
    Color? appBarColor,
    Color? inputBarColor,
    Color? hintTextColor,
    String? fontFamily,
    double? fontSize,
    double? messageBorderRadius,
    bool? showUserAvatar,
    bool? showSentStatus,
    String? backgroundImage,
    Brightness? brightness,
    BoxShadow? messageShadow,
    EdgeInsets? messagePadding,
  }) {
    return ChatTheme(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      sentMessageColor: sentMessageColor ?? this.sentMessageColor,
      receivedMessageColor: receivedMessageColor ?? this.receivedMessageColor,
      sentMessageTextColor: sentMessageTextColor ?? this.sentMessageTextColor,
      receivedMessageTextColor: receivedMessageTextColor ?? this.receivedMessageTextColor,
      timestampColor: timestampColor ?? this.timestampColor,
      appBarColor: appBarColor ?? this.appBarColor,
      inputBarColor: inputBarColor ?? this.inputBarColor,
      hintTextColor: hintTextColor ?? this.hintTextColor,
      fontFamily: fontFamily ?? this.fontFamily,
      fontSize: fontSize ?? this.fontSize,
      messageBorderRadius: messageBorderRadius ?? this.messageBorderRadius,
      showUserAvatar: showUserAvatar ?? this.showUserAvatar,
      showSentStatus: showSentStatus ?? this.showSentStatus,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      brightness: brightness ?? this.brightness,
      messageShadow: messageShadow ?? this.messageShadow,
      messagePadding: messagePadding ?? this.messagePadding,
    );
  }

  // Create a dark theme
  static ChatTheme dark() {
    return ChatTheme(
      primaryColor: Colors.indigo,
      secondaryColor: Colors.blue,
      backgroundColor: Colors.grey[900]!,
      sentMessageColor: Colors.indigo,
      receivedMessageColor: Colors.grey[800]!,
      sentMessageTextColor: Colors.white,
      receivedMessageTextColor: Colors.white,
      timestampColor: Colors.grey[400]!,
      appBarColor: Colors.grey[850]!,
      inputBarColor: Colors.grey[800]!,
      hintTextColor: Colors.grey[400]!,
      brightness: Brightness.dark,
      messageShadow: BoxShadow(
        color: Colors.black26,
        blurRadius: 5,
        offset: Offset(0, 2),
      ),
    );
  }
}

// Configuration for user profiles
class UserProfile {
  final String id;
  final String name;
  final String? avatarUrl;
  final Color? avatarColor;
  final bool isOnline;
  final String? status;

  UserProfile({
    required this.id,
    required this.name,
    this.avatarUrl,
    this.avatarColor,
    this.isOnline = false,
    this.status,
  });
}

class CustomizableChatScreen extends StatefulWidget {
  final String title;
  final UserProfile currentUser;
  final UserProfile? chatPartner;
  final List<ChatMessage>? initialMessages;
  final ChatTheme theme;
  final MessageSentCallback? onMessageSent;
  final MessageReceivedCallback? onMessageReceived;
  final ReactionAddedCallback? onReactionAdded;
  final AttachmentPickedCallback? onAttachmentPicked;
  final bool enableEmojis;
  final bool enableAttachments;
  final bool enableReactions;
  final bool autoRespond;
  final String? hintText;
  final List<String>? quickReactions;
  final bool showTypingIndicator;
  final bool showReadReceipts;
  final Widget? header;
  final Widget? footer;
  final Widget Function(BuildContext, ChatMessage)? customMessageBuilder;
  final Duration? autoScrollDuration;

  const CustomizableChatScreen({
    Key? key,
    required this.title,
    required this.currentUser,
    this.chatPartner,
    this.initialMessages,
    required this.theme ,
    this.onMessageSent,
    this.onMessageReceived,
    this.onReactionAdded,
    this.onAttachmentPicked,
    this.enableEmojis = true,
    this.enableAttachments = true,
    this.enableReactions = true,
    this.autoRespond = false,
    this.hintText,
    this.quickReactions,
    this.showTypingIndicator = true,
    this.showReadReceipts = true,
    this.header,
    this.footer,
    this.customMessageBuilder,
    this.autoScrollDuration,
  }) : super(key: key);

  @override
  State<CustomizableChatScreen> createState() => _CustomizableChatScreenState();
}

class _CustomizableChatScreenState extends State<CustomizableChatScreen>
    with TickerProviderStateMixin {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _showEmojiPicker = false;
  final FocusNode _focusNode = FocusNode();
  bool _isTyping = false;

  // Animation controllers for various animations
  late AnimationController _typingController;
  late AnimationController _newMessageController;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _typingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _newMessageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Add initial messages if provided
    if (widget.initialMessages != null && widget.initialMessages!.isNotEmpty) {
      _messages.addAll(widget.initialMessages!);
    } else {
      // Load sample messages for demo if no initial messages
      _loadSampleMessages();
    }

    // Listen to text changes to show typing indicator
    _textController.addListener(() {
      if (_textController.text.isNotEmpty && !_isTyping) {
        setState(() {
          _isTyping = true;
        });
      } else if (_textController.text.isEmpty && _isTyping) {
        setState(() {
          _isTyping = false;
        });
      }
    });
  }

  void _loadSampleMessages() {
    final sampleMessages = [
      ChatMessage(
        id: '1',
        text: 'Hey there! How are you doing today?',
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 20)),
        type: MessageType.text,
      ),
      ChatMessage(
        id: '2',
        text: 'I\'m good, thanks for asking! Just working on this new project.',
        isMe: true,
        timestamp: DateTime.now().subtract(const Duration(minutes: 18)),
        type: MessageType.text,
      ),
      ChatMessage(
        id: '3',
        text: 'Check out this image',
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
        type: MessageType.image,
        mediaUrl: 'https://picsum.photos/400/300',
      ),
      ChatMessage(
        id: '4',
        text: '😍',
        isMe: true,
        timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
        type: MessageType.emoji,
      ),
    ];

    setState(() {
      _messages.addAll(sampleMessages);
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    _typingController.dispose();
    _newMessageController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

void _handleSubmitted(String text) {
  if (text.trim().isEmpty) return;

  _textController.clear();

  // Determine message type
  final MessageType messageType;
  if (text.length < 3 && RegExp(r'[\p{Emoji}]', unicode: true).hasMatch(text)) {
    messageType = MessageType.emoji;
  } else {
    messageType = MessageType.text;
  }

  final message = ChatMessage(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    text: text,
    isMe: true,
    timestamp: DateTime.now(),
    type: messageType,
    isNew: true,
  );

  setState(() {
    _messages.add(message);
    _isTyping = false;
  });

  _scrollToBottom();
  _newMessageController.forward().then((_) => _newMessageController.reset());

  // Trigger the onMessageSent callback
  if (widget.onMessageSent != null) {
    widget.onMessageSent!(message);
  }

  // Auto respond if enabled
  if (widget.autoRespond) {
    _simulateResponse();
  }
}

  void _simulateResponse() {
    setState(() {
      _isTyping = true;
    });

    // Simulate a response after a short delay
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      setState(() {
        _isTyping = false;
      });

      final response = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: 'Thanks for your message! This is an automated response.',
        isMe: false,
        timestamp: DateTime.now(),
        type: MessageType.text,
        isNew: true,
      );

      setState(() {
        _messages.add(response);
      });

      _scrollToBottom();
      HapticFeedback.lightImpact();

      // Trigger the onMessageReceived callback
      if (widget.onMessageReceived != null) {
        widget.onMessageReceived!(response);
      }
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 70,
        duration: widget.autoScrollDuration ?? const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _toggleEmojiPicker() {
    setState(() {
      _showEmojiPicker = !_showEmojiPicker;
      if (_showEmojiPicker) {
        _focusNode.unfocus();
      } else {
        _focusNode.requestFocus();
      }
    });
  }

  void _onEmojiSelected(String emoji) {
    setState(() {
      _textController.text = _textController.text + emoji;
      _textController.selection = TextSelection.fromPosition(
        TextPosition(offset: _textController.text.length),
      );
    });
  }

  void _handleAttachmentPressed(String type) {
    if (widget.onAttachmentPicked != null) {
      widget.onAttachmentPicked!(type);
    }
  }

  void _addReaction(ChatMessage message, String emoji) {
    setState(() {
      final index = _messages.indexWhere((msg) => msg.id == message.id);
      if (index != -1) {
        final List<String> updatedReactions =
            List.from(_messages[index].reactions);
        if (updatedReactions.contains(emoji)) {
          updatedReactions.remove(emoji);
        } else {
          updatedReactions.add(emoji);
        }

        _messages[index] = _messages[index].copyWith(
          reactions: updatedReactions,
        );
      }
    });

    // Trigger the onReactionAdded callback
    if (widget.onReactionAdded != null) {
      widget.onReactionAdded!(message, emoji);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: widget.theme.primaryColor,
        colorScheme: ColorScheme(
          brightness: widget.theme.brightness,
          primary: widget.theme.primaryColor,
          onPrimary: widget.theme.sentMessageTextColor,
          secondary: widget.theme.secondaryColor,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          background: widget.theme.backgroundColor,
          onBackground: widget.theme.receivedMessageTextColor,
          surface: widget.theme.inputBarColor,
          onSurface: widget.theme.receivedMessageTextColor,
        ),
        fontFamily: widget.theme.fontFamily,
      ),
      child: Scaffold(
        backgroundColor: widget.theme.backgroundColor,
        appBar: _buildAppBar(),
        body: Container(
          decoration: widget.theme.backgroundImage != null
              ? BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.theme.backgroundImage!),
                    fit: BoxFit.cover,
                  ),
                )
              : null,
          child: Column(
            children: [
              if (widget.header != null) widget.header!,
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: _messages.length + (_isTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _messages.length && _isTyping) {
                      // Show typing indicator
                      return _buildTypingIndicator();
                    }
                    final message = _messages[index];
                    return widget.customMessageBuilder != null
                        ? widget.customMessageBuilder!(context, message)
                        : _buildMessageWidget(message);
                  },
                ),
              ),
              if (widget.footer != null) widget.footer!,
              _buildInputArea(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: widget.theme.appBarColor,
      title: Row(
        children: [
          if (widget.chatPartner != null && widget.chatPartner!.avatarUrl != null)
            CircleAvatar(
              backgroundImage: NetworkImage(widget.chatPartner!.avatarUrl!),
              backgroundColor: widget.chatPartner!.avatarColor ?? widget.theme.secondaryColor,
            )
          else if (widget.chatPartner != null)
            CircleAvatar(
              backgroundColor: widget.chatPartner!.avatarColor ?? widget.theme.secondaryColor,
              child: Text(
                widget.chatPartner!.name.substring(0, 1).toUpperCase(),
                style: TextStyle(color: widget.theme.sentMessageTextColor),
              ),
            ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 16,
                  color: widget.theme.sentMessageTextColor,
                ),
              ),
              if (widget.chatPartner != null && widget.showTypingIndicator)
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: widget.chatPartner!.isOnline ? Colors.green : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.chatPartner!.isOnline
                          ? (_isTyping ? 'Typing...' : 'Online')
                          : 'Offline',
                      style: TextStyle(
                        fontSize: 12,
                        color: widget.theme.sentMessageTextColor.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.call),
          color: widget.theme.sentMessageTextColor,
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.videocam),
          color: widget.theme.sentMessageTextColor,
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.more_vert),
          color: widget.theme.sentMessageTextColor,
          onPressed: () {
            // Show chat settings menu
            _showChatSettingsMenu();
          },
        ),
      ],
    );
  }

  Widget _buildInputArea() {
    return Container(
      decoration: BoxDecoration(
        color: widget.theme.inputBarColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 3,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: widget.theme.brightness == Brightness.light
                    ? Colors.grey.shade200
                    : Colors.grey.shade800,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: widget.theme.secondaryColor.withOpacity(0.2),
                ),
              ),
              child: Row(
                children: [
                  if (widget.enableEmojis)
                    IconButton(
                      icon: Icon(
                        _showEmojiPicker ? Icons.keyboard : Icons.emoji_emotions_outlined,
                        color: widget.theme.secondaryColor,
                      ),
                      onPressed: _toggleEmojiPicker,
                    ),
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      focusNode: _focusNode,
                      style: TextStyle(
                        color: widget.theme.receivedMessageTextColor,
                        fontFamily: widget.theme.fontFamily,
                        fontSize: widget.theme.fontSize,
                      ),
                      decoration: InputDecoration(
                        hintText: widget.hintText ?? 'Type a message...',
                        hintStyle: TextStyle(
                          color: widget.theme.hintTextColor,
                          fontFamily: widget.theme.fontFamily,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                      onSubmitted: _handleSubmitted,
                    ),
                  ),
                  if (widget.enableAttachments)
                    IconButton(
                      icon: Icon(
                        Icons.attach_file,
                        color: widget.theme.secondaryColor,
                      ),
                      onPressed: () => _showAttachmentOptions(),
                    ),
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      color: widget.theme.primaryColor,
                    ),
                    onPressed: () => _handleSubmitted(_textController.text),
                  ),
                ],
              ),
            ),
            if (_showEmojiPicker && widget.enableEmojis)
              SizedBox(
                height: 250,
                child: EmojiPicker(
                  onEmojiSelected: (category, emoji) => _onEmojiSelected(emoji.emoji),
                  config: Config(
                    height: 250,
                    emojiViewConfig: EmojiViewConfig(
                      columns: 7,
                      emojiSizeMax: 32,
                      verticalSpacing: 0,
                      horizontalSpacing: 0,
                      backgroundColor: widget.theme.brightness == Brightness.light
                          ? Colors.white
                          : Colors.grey.shade900,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageWidget(ChatMessage message) {
    return AnimatedMessageBubble(
      message: message,
      theme: widget.theme,
      onReactionTap: widget.enableReactions ? _addReaction : null,
      typingAnimation: _typingController,
      newMessageAnimation: _newMessageController,
      isNew: message.isNew,
      showAvatar: widget.theme.showUserAvatar,
      showStatus: widget.theme.showSentStatus && message.isMe,
      quickReactions: widget.quickReactions ?? ['👍', '❤️', '😂', '😮', '😢', '👏'],
      userProfile: message.isMe ? widget.currentUser : widget.chatPartner,
    );
  }

  Widget _buildTypingIndicator() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.chatPartner != null && widget.theme.showUserAvatar)
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: widget.chatPartner!.avatarUrl != null
                  ? CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(widget.chatPartner!.avatarUrl!),
                    )
                  : CircleAvatar(
                      radius: 16,
                      backgroundColor: widget.chatPartner!.avatarColor ?? widget.theme.secondaryColor,
                      child: Text(
                        widget.chatPartner!.name.substring(0, 1).toUpperCase(),
                        style: TextStyle(color: widget.theme.sentMessageTextColor),
                      ),
                    ),
            ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: widget.theme.receivedMessageColor,
              borderRadius: BorderRadius.circular(widget.theme.messageBorderRadius),
            ),
            child: Row(
              children: [
                _buildDot(0),
                const SizedBox(width: 4),
                _buildDot(100),
                const SizedBox(width: 4),
                _buildDot(200),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int delay) {
    return AnimatedBuilder(
      animation: _typingController,
      builder: (context, child) {
        final begin = 0.0;
        final end = 1.0;
        final animationValue = Tween<double>(begin: begin, end: end)
            .animate(CurvedAnimation(
              parent: _typingController,
              curve: Interval(delay / 1000, (delay + 300) / 1000, curve: Curves.easeInOut),
            ))
            .value;
        
        return Transform.translate(
          offset: Offset(0, -3 * animationValue),
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: widget.theme.receivedMessageTextColor.withOpacity(0.7),
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: widget.theme.brightness == Brightness.light
          ? Colors.white
          : Colors.grey.shade900,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo, color: widget.theme.primaryColor),
                title: Text(
                  'Photo',
                  style: TextStyle(color: widget.theme.receivedMessageTextColor),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _handleAttachmentPressed('photo');
                },
              ),
              ListTile(
                leading: Icon(Icons.videocam, color: widget.theme.primaryColor),
                title: Text(
                  'Video',
                  style: TextStyle(color: widget.theme.receivedMessageTextColor),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _handleAttachmentPressed('video');
                },
              ),
              ListTile(
                leading: Icon(Icons.insert_drive_file, color: widget.theme.primaryColor),
                title: Text(
                  'File',
                  style: TextStyle(color: widget.theme.receivedMessageTextColor),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _handleAttachmentPressed('file');
                },
              ),
              ListTile(
                leading: Icon(Icons.location_on, color: widget.theme.primaryColor),
                title: Text(
                  'Location',
                  style: TextStyle(color: widget.theme.receivedMessageTextColor),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _handleAttachmentPressed('location');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showChatSettingsMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: widget.theme.brightness == Brightness.light
          ? Colors.white
          : Colors.grey.shade900,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.person, color: widget.theme.primaryColor),
                title: Text(
                  'View Profile',
                  style: TextStyle(color: widget.theme.receivedMessageTextColor),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Handle view profile
                },
              ),
              ListTile(
                leading: Icon(Icons.notifications, color: widget.theme.primaryColor),
                title: Text(
                  'Mute Notifications',
                  style: TextStyle(color: widget.theme.receivedMessageTextColor),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Handle mute notifications
                },
              ),
              ListTile(
                leading: Icon(Icons.search, color: widget.theme.primaryColor),
                title: Text(
                  'Search',
                  style: TextStyle(color: widget.theme.receivedMessageTextColor),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Handle search
                },
              ),
              ListTile(
                leading: Icon(Icons.clear_all, color: widget.theme.primaryColor),
                title: Text(
                  'Clear Chat',
                  style: TextStyle(color: widget.theme.receivedMessageTextColor),
                ),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _messages.clear();
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class AnimatedMessageBubble extends StatefulWidget {
  final ChatMessage message;
  final ChatTheme theme;
  final Function(ChatMessage, String)? onReactionTap;
  final AnimationController typingAnimation;
  final AnimationController newMessageAnimation;
  final bool isNew;
  final bool showAvatar;
  final bool showStatus;
  final List<String> quickReactions;
  final UserProfile? userProfile;

  const AnimatedMessageBubble({
    Key? key,
    required this.message,
    required this.theme,
    this.onReactionTap,
    required this.typingAnimation,
    required this.newMessageAnimation,
    this.isNew = false,
    this.showAvatar = true,
    this.showStatus = true,
    this.quickReactions = const ['👍', '❤️', '😂', '😮', '😢', '👏'],
    this.userProfile,
  }) : super(key: key);

  @override
  State<AnimatedMessageBubble> createState() => _AnimatedMessageBubbleState();
}

class _AnimatedMessageBubbleState extends State<AnimatedMessageBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _appearController;
  late Animation<double> _appearAnimation;
  bool _showReactions = false;

  @override
  void initState() {
    super.initState();
    _appearController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _appearAnimation = CurvedAnimation(
      parent: _appearController,
      curve: Curves.easeOutCubic,
    );

    if (widget.isNew) {
      _appearController.forward();
    } else {
      _appearController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _appearController.dispose();
    super.dispose();
  }

  String _formatTime(DateTime timestamp) {
    return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }

  Widget _buildAvatar() {
    if (!widget.showAvatar || widget.userProfile == null) {
      return const SizedBox(width: 32);
    }

    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: widget.userProfile!.avatarUrl != null
          ? CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(widget.userProfile!.avatarUrl!),
            )
          : CircleAvatar(
              radius: 16,
              backgroundColor: widget.userProfile!.avatarColor ?? widget.theme.secondaryColor,
              child: Text(
                widget.userProfile!.name.substring(0, 1).toUpperCase(),
                style: TextStyle(color: widget.theme.sentMessageTextColor),
              ),
            ),
    );
  }

  Widget _buildMessageContent() {
    switch (widget.message.type) {
      case MessageType.image:
        return Container(
          constraints: const BoxConstraints(
            maxWidth: 200,
            maxHeight: 200,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.theme.messageBorderRadius - 3),
            child: Image.network(
              widget.message.mediaUrl ?? 'https://picsum.photos/200',
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: 200,
                  height: 150,
                  color: widget.theme.secondaryColor.withOpacity(0.3),
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                      color: widget.theme.primaryColor,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      case MessageType.video:
        // Simple video thumbnail representation
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              constraints: const BoxConstraints(
                maxWidth: 200,
                maxHeight: 200,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.theme.messageBorderRadius - 3),
                child: Image.network(
                  widget.message.mediaUrl ?? 'https://picsum.photos/200',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        );
      case MessageType.emoji:
        return Text(
          widget.message.text,
          style: TextStyle(
            fontSize: 32,
          ),
        );
      case MessageType.file:
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.insert_drive_file,
                color: widget.message.isMe
                    ? widget.theme.sentMessageTextColor
                    : widget.theme.receivedMessageTextColor,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'File name.pdf',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: widget.message.isMe
                            ? widget.theme.sentMessageTextColor
                            : widget.theme.receivedMessageTextColor,
                      ),
                    ),
                    Text(
                      '2.5 MB',
                      style: TextStyle(
                        fontSize: 12,
                        color: (widget.message.isMe
                                ? widget.theme.sentMessageTextColor
                                : widget.theme.receivedMessageTextColor)
                            .withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      case MessageType.audio:
        return Container(
          width: 200,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Icon(
                Icons.play_circle_fill,
                color: widget.message.isMe
                    ? widget.theme.sentMessageTextColor
                    : widget.theme.receivedMessageTextColor,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 3,
                      decoration: BoxDecoration(
                        color: (widget.message.isMe
                                ? widget.theme.sentMessageTextColor
                                : widget.theme.receivedMessageTextColor)
                            .withOpacity(0.5),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '0:42',
                      style: TextStyle(
                        fontSize: 12,
                        color: (widget.message.isMe
                                ? widget.theme.sentMessageTextColor
                                : widget.theme.receivedMessageTextColor)
                            .withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      case MessageType.location:
        return Container(
          width: 200,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.theme.messageBorderRadius - 3),
            image: const DecorationImage(
              image: NetworkImage('https://picsum.photos/200/150?random=1'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Icon(
              Icons.location_on,
              color: Colors.red,
              size: 36,
            ),
          ),
        );
      case MessageType.text:
      default:
        return Text(
          widget.message.text,
          style: TextStyle(
            color: widget.message.isMe
                ? widget.theme.sentMessageTextColor
                : widget.theme.receivedMessageTextColor,
            fontSize: widget.theme.fontSize,
            fontFamily: widget.theme.fontFamily,
          ),
        );
    }
  }

  Widget _buildReactions() {
    if (widget.message.reactions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.only(
        top: 4,
        left: widget.message.isMe ? 0 : 8,
        right: widget.message.isMe ? 8 : 0,
      ),
      child: Align(
        alignment: widget.message.isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: widget.theme.brightness == Brightness.light
                ? Colors.white
                : Colors.grey.shade800,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: widget.message.reactions.map((emoji) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Text(
                  emoji,
                  style: const TextStyle(fontSize: 16),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickReactionsSelector() {
    if (!_showReactions || widget.onReactionTap == null) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.only(
        top: 4,
        bottom: 4,
        left: widget.message.isMe ? 40 : 0,
        right: widget.message.isMe ? 0 : 40,
      ),
      child: Align(
        alignment: widget.message.isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: widget.theme.brightness == Brightness.light
                ? Colors.white
                : Colors.grey.shade800,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: widget.quickReactions.map((emoji) {
              return GestureDetector(
                onTap: () {
                  widget.onReactionTap!(widget.message, emoji);
                  setState(() {
                    _showReactions = false;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    emoji,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _appearAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
              widget.message.isMe ? (1 - _appearAnimation.value) * 50 : -(1 - _appearAnimation.value) * 50, 0),
          child: Opacity(
            opacity: _appearAnimation.value,
            child: child,
          ),
        );
      },
      child: Column(
        children: [
          GestureDetector(
            onLongPress: widget.onReactionTap != null
                ? () {
                    setState(() {
                      _showReactions = !_showReactions;
                    });
                    HapticFeedback.mediumImpact();
                  }
                : null,
            child: Container(
              margin: EdgeInsets.only(
                top: 8,
                bottom: 4,
                right: widget.message.isMe ? 0 : 40,
                left: widget.message.isMe ? 40 : 0,
              ),
              child: Row(
                mainAxisAlignment:
                    widget.message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (!widget.message.isMe && widget.showAvatar) _buildAvatar(),
                  Flexible(
                    child: Container(
                      padding: widget.theme.messagePadding,
                      decoration: BoxDecoration(
                        color: widget.message.isMe
                            ? widget.theme.sentMessageColor
                            : widget.theme.receivedMessageColor,
                        borderRadius: BorderRadius.circular(widget.theme.messageBorderRadius),
                        boxShadow: widget.theme.messageShadow != null
                            ? [widget.theme.messageShadow!]
                            : null,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildMessageContent(),
                          const SizedBox(height: 2),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                _formatTime(widget.message.timestamp),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: (widget.message.isMe
                                          ? widget.theme.sentMessageTextColor
                                          : widget.theme.receivedMessageTextColor)
                                      .withOpacity(0.7),
                                ),
                              ),
                              if (widget.message.isMe && widget.showStatus)
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Icon(
                                    Icons.done_all,
                                    size: 12,
                                    color: widget.theme.sentMessageTextColor.withOpacity(0.7),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (widget.message.isMe && widget.showAvatar) _buildAvatar(),
                ],
              ),
            ),
          ),
          _buildReactions(),
          _buildQuickReactionsSelector(),
        ],
      ),
    );
  }
}