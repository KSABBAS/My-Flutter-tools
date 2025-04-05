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

// Configuration classes for customization
class MessageBubbleConfig {
  final EdgeInsets margin;
  final Duration appearAnimationDuration;
  final Curve appearAnimationCurve;
  final double transformOffset;
  final bool enableHapticFeedback;
  final EdgeInsets contentPadding;
  final double fontSize;
  final double emojiSize;
  final double maxWidth;
  final double maxHeight;
  final bool showTimestamp;
  final bool showReadStatus;
  final TextStyle? timestampStyle;
  final BoxDecoration? customDecoration;

  const MessageBubbleConfig({
    this.margin = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.appearAnimationDuration = const Duration(milliseconds: 300),
    this.appearAnimationCurve = Curves.easeOutCubic,
    this.transformOffset = 50,
    this.enableHapticFeedback = true,
    this.contentPadding = const EdgeInsets.all(12),
    this.fontSize = 16,
    this.emojiSize = 32,
    this.maxWidth = 200,
    this.maxHeight = 200,
    this.showTimestamp = true,
    this.showReadStatus = true,
    this.timestampStyle,
    this.customDecoration,
  });
}

class InputAreaConfig {
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double borderRadius;
  final double iconSize;
  final Color? iconColor;
  final bool showSendButton;
  final bool showEmojiButton;
  final bool showAttachmentButton;
  final TextStyle? inputTextStyle;
  final InputDecoration? inputDecoration;
  final BoxDecoration? containerDecoration;
  final double emojiPickerHeight;
  final int emojiColumns;
  final double emojiSizeMax;

  const InputAreaConfig({
    this.margin = const EdgeInsets.all(8),
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
    this.borderRadius = 24,
    this.iconSize = 24,
    this.iconColor,
    this.showSendButton = true,
    this.showEmojiButton = true,
    this.showAttachmentButton = true,
    this.inputTextStyle,
    this.inputDecoration,
    this.containerDecoration,
    this.emojiPickerHeight = 250,
    this.emojiColumns = 7,
    this.emojiSizeMax = 32,
  });
}

class ReactionConfig {
  final double selectorHeight;
  final double selectorBorderRadius;
  final EdgeInsets selectorPadding;
  final EdgeInsets selectorMargin;
  final double reactionSize;
  final double spaceBetweenReactions;
  final BoxDecoration? selectorDecoration;
  final Duration showHideAnimationDuration;
  final Curve showHideCurve;

  const ReactionConfig({
    this.selectorHeight = 40,
    this.selectorBorderRadius = 24,
    this.selectorPadding = const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    this.selectorMargin = const EdgeInsets.symmetric(vertical: 4),
    this.reactionSize = 20,
    this.spaceBetweenReactions = 4,
    this.selectorDecoration,
    this.showHideAnimationDuration = const Duration(milliseconds: 200),
    this.showHideCurve = Curves.easeInOut,
  });
}

class CustomizableChatScreen extends StatefulWidget {
  /// The title displayed in the app bar
  /// 
  /// Example: "Customer Support" or "Chat with John"
  /// Used for identifying the chat conversation in the UI
  final String title;

  /// The current user's profile information
  /// 
  /// Contains details like user ID, name, avatar URL, etc.
  /// Example: UserProfile(id: "user123", name: "John Doe")
  final UserProfile currentUser;

  /// The chat partner's profile information
  /// 
  /// Contains details about the person being chatted with
  /// Can be null for broadcast or system messages
  /// Example: UserProfile(id: "support123", name: "Support Agent")
  final UserProfile? chatPartner;

  /// Initial messages to populate the chat
  /// 
  /// Useful for loading chat history or predefined messages
  /// Example: [ChatMessage(id: "1", text: "Welcome!", isMe: false, ...)]
  final List<ChatMessage>? initialMessages;

  /// Theme configuration for the chat UI
  /// 
  /// Controls colors, fonts, sizes, and other visual properties
  /// Example: ChatTheme(primaryColor: Colors.blue, fontSize: 16)
  final ChatTheme theme;

  /// Callback function when a message is sent
  /// 
  /// Triggered when user sends a new message
  /// Example: (message) => saveMessageToDatabase(message)
  final MessageSentCallback? onMessageSent;

  /// Callback function when a message is received
  /// 
  /// Triggered when a new message arrives
  /// Example: (message) => playNotificationSound()
  final MessageReceivedCallback? onMessageReceived;

  /// Callback function when a reaction is added to a message
  /// 
  /// Triggered when user adds/removes emoji reaction
  /// Example: (message, emoji) => updateMessageReactions(message.id, emoji)
  final ReactionAddedCallback? onReactionAdded;

  /// Callback function when an attachment is selected
  /// 
  /// Triggered when user picks a file/image/etc
  /// Example: (type) => handleFileUpload(type)
  final AttachmentPickedCallback? onAttachmentPicked;

  /// Enable/disable emoji picker functionality
  /// 
  /// When true, shows emoji button in input area
  /// Default: true
  final bool enableEmojis;

  /// Enable/disable file attachment functionality
  /// 
  /// When true, shows attachment button in input area
  /// Default: true
  final bool enableAttachments;

  /// Enable/disable message reactions
  /// 
  /// When true, allows long-press to add reactions
  /// Default: true
  final bool enableReactions;

  /// Enable/disable automatic responses
  /// 
  /// When true, simulates automated replies
  /// Useful for demos or chatbot interfaces
  /// Default: false
  final bool autoRespond;

  /// Placeholder text for the message input field
  /// 
  /// Example: "Type a message..." or "Send a reply..."
  final String? hintText;

  /// List of quick reaction emojis
  /// 
  /// Appears when long-pressing a message
  /// Example: ['👍', '❤️', '😂', '😮', '😢', '👏']
  final List<String>? quickReactions;

  /// Show/hide typing indicator
  /// 
  /// When true, displays typing status
  /// Default: true
  final bool showTypingIndicator;

  /// Show/hide read receipts
  /// 
  /// When true, shows message read status
  /// Default: true
  final bool showReadReceipts;

  /// Custom widget to display at the top of chat
  /// 
  /// Useful for notifications or custom headers
  /// Example: Banner or ConnectionStatus widget
  final Widget? header;

  /// Custom widget to display at the bottom of chat
  /// 
  /// Useful for ads or additional controls
  /// Example: AdBanner or ActionButtons widget
  final Widget? footer;

  /// Custom message bubble builder
  /// 
  /// For complete control over message rendering
  /// Example: (context, message) => CustomMessageBubble(message)
  final Widget Function(BuildContext, ChatMessage)? customMessageBuilder;

  /// Duration for auto-scrolling animations
  /// 
  /// Controls smooth scrolling behavior
  /// Example: Duration(milliseconds: 300)
  final Duration? autoScrollDuration;

  /// URL for current user's avatar image
  /// 
  /// Displayed in message bubbles and app bar
  /// Example: "https://example.com/avatar.jpg"
  final String? myImageUrl;

  /// URL for chat partner's avatar image
  /// 
  /// Displayed in message bubbles and app bar
  /// Example: "https://example.com/partner-avatar.jpg"
  final String? otherImageUrl;

  /// Show/hide the app bar
  /// 
  /// When false, removes the top app bar
  /// Useful for custom layouts or embedded chats
  /// Default: true
  final bool showAppBar;

  /// Configuration for message bubbles
  /// 
  /// Controls appearance and behavior of message bubbles
  /// Example: MessageBubbleConfig(maxWidth: 280, fontSize: 16)
  final MessageBubbleConfig messageBubbleConfig;

  /// Configuration for input area
  /// 
  /// Controls appearance and behavior of message input
  /// Example: InputAreaConfig(borderRadius: 24, iconSize: 24)
  final InputAreaConfig inputAreaConfig;

  /// Configuration for reactions
  /// 
  /// Controls appearance and behavior of reaction selector
  /// Example: ReactionConfig(selectorHeight: 40, reactionSize: 20)
  final ReactionConfig reactionConfig;

  const CustomizableChatScreen({
    Key? key,
    required this.title,
    required this.currentUser,
    this.chatPartner,
    this.initialMessages,
    required this.theme,
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
    this.myImageUrl,
    this.otherImageUrl,
    this.showAppBar = true,
    this.messageBubbleConfig = const MessageBubbleConfig(),
    this.inputAreaConfig = const InputAreaConfig(),
    this.reactionConfig = const ReactionConfig(),
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

  late AnimationController _typingController;
  late AnimationController _newMessageController;

  @override
  void initState() {
    super.initState();

    _typingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _newMessageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    if (widget.initialMessages != null && widget.initialMessages!.isNotEmpty) {
      _messages.addAll(widget.initialMessages!);
    } else {
      _loadSampleMessages();
    }
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
    });

    _scrollToBottom();
    _newMessageController.forward().then((_) => _newMessageController.reset());

    if (widget.onMessageSent != null) {
      widget.onMessageSent!(message);
    }

    if (widget.autoRespond) {
      _simulateResponse();
    }
  }

  void _simulateResponse() {
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

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
        appBar: widget.showAppBar ? _buildAppBar() : null,
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
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
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
          if (widget.chatPartner != null)
            CircleAvatar(
              backgroundImage: widget.otherImageUrl != null 
                  ? NetworkImage(widget.otherImageUrl!)
                  : null,
              backgroundColor: widget.chatPartner!.avatarColor ?? widget.theme.secondaryColor,
              child: widget.otherImageUrl == null 
                  ? Text(
                      widget.chatPartner!.name.substring(0, 1).toUpperCase(),
                      style: TextStyle(color: widget.theme.sentMessageTextColor),
                    )
                  : null,
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
                      widget.chatPartner!.isOnline ? 'Online' : 'Offline',
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
            _showChatSettingsMenu();
          },
        ),
      ],
    );
  }

  Widget _buildInputArea() {
    return Container(
      margin: widget.inputAreaConfig.margin,
      decoration: widget.inputAreaConfig.containerDecoration ?? BoxDecoration(
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
              padding: widget.inputAreaConfig.padding,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.inputAreaConfig.borderRadius),
                color: widget.theme.brightness == Brightness.light
                    ? Colors.grey.shade200
                    : Colors.grey.shade800,
                border: Border.all(
                  color: widget.theme.secondaryColor.withOpacity(0.2),
                ),
              ),
              child: Row(
                children: [
                  if (widget.enableEmojis && widget.inputAreaConfig.showEmojiButton)
                    IconButton(
                      icon: Icon(
                        _showEmojiPicker ? Icons.keyboard : Icons.emoji_emotions_outlined,
                        color: widget.inputAreaConfig.iconColor ?? widget.theme.secondaryColor,
                        size: widget.inputAreaConfig.iconSize,
                      ),
                      onPressed: _toggleEmojiPicker,
                    ),
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      focusNode: _focusNode,
                      style: widget.inputAreaConfig.inputTextStyle ??
                          TextStyle(
                            color: widget.theme.receivedMessageTextColor,
                            fontFamily: widget.theme.fontFamily,
                            fontSize: widget.theme.fontSize,
                          ),
                      decoration: widget.inputAreaConfig.inputDecoration ??
                          InputDecoration(
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
                  if (widget.enableAttachments && widget.inputAreaConfig.showAttachmentButton)
                    IconButton(
                      icon: Icon(
                        Icons.attach_file,
                        color: widget.inputAreaConfig.iconColor ?? widget.theme.secondaryColor,
                        size: widget.inputAreaConfig.iconSize,
                      ),
                      onPressed: () => _showAttachmentOptions(),
                    ),
                  if (widget.inputAreaConfig.showSendButton)
                    IconButton(
                      icon: Icon(
                        Icons.send,
                        color: widget.theme.primaryColor,
                        size: widget.inputAreaConfig.iconSize,
                      ),
                      onPressed: () => _handleSubmitted(_textController.text),
                    ),
                ],
              ),
            ),
            if (_showEmojiPicker && widget.enableEmojis)
              SizedBox(
                height: widget.inputAreaConfig.emojiPickerHeight,
                child: EmojiPicker(
                  onEmojiSelected: (category, emoji) => _onEmojiSelected(emoji.emoji),
                  config: Config(
                    height: widget.inputAreaConfig.emojiPickerHeight,
                    emojiViewConfig: EmojiViewConfig(
                      columns: widget.inputAreaConfig.emojiColumns,
                      emojiSizeMax: widget.inputAreaConfig.emojiSizeMax,
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
      myImageUrl: widget.myImageUrl,
      otherImageUrl: widget.otherImageUrl,
      config: widget.messageBubbleConfig,
      reactionConfig: widget.reactionConfig,
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
  final String? myImageUrl;
  final String? otherImageUrl;
  final MessageBubbleConfig config;
  final ReactionConfig reactionConfig;

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
    this.myImageUrl,
    this.otherImageUrl,
    this.config = const MessageBubbleConfig(),
    this.reactionConfig = const ReactionConfig(),
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
      duration: widget.config.appearAnimationDuration,
    );
    _appearAnimation = CurvedAnimation(
      parent: _appearController,
      curve: widget.config.appearAnimationCurve,
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
    return const SizedBox.shrink();
  }

  Widget _buildMessageContent() {
    switch (widget.message.type) {
      case MessageType.image:
        return Container(
          constraints: BoxConstraints(
            maxWidth: widget.config.maxWidth,
            maxHeight: widget.config.maxHeight,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.theme.messageBorderRadius - 3),
            child: Image.network(
              widget.message.mediaUrl ?? 'https://picsum.photos/200',
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: widget.config.maxWidth,
                  height: widget.config.maxHeight,
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
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: widget.config.maxWidth,
                maxHeight: widget.config.maxHeight,
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
            fontSize: widget.config.emojiSize,
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
          width: widget.config.maxWidth,
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
          width: widget.config.maxWidth,
          height: widget.config.maxHeight,
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
            fontSize: widget.config.fontSize,
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
          decoration: widget.reactionConfig.selectorDecoration ??
              BoxDecoration(
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
                  style: TextStyle(fontSize: widget.reactionConfig.reactionSize),
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
      margin: widget.reactionConfig.selectorMargin,
      child: Align(
        alignment: widget.message.isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: widget.reactionConfig.selectorPadding,
          decoration: widget.reactionConfig.selectorDecoration ??
              BoxDecoration(
                color: widget.theme.brightness == Brightness.light
                    ? Colors.white
                    : Colors.grey.shade800,
                borderRadius: BorderRadius.circular(widget.reactionConfig.selectorBorderRadius),
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
                  padding: EdgeInsets.symmetric(
                      horizontal: widget.reactionConfig.spaceBetweenReactions),
                  child: Text(
                    emoji,
                    style: TextStyle(fontSize: widget.reactionConfig.reactionSize),
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
              widget.message.isMe
                  ? (1 - _appearAnimation.value) * widget.config.transformOffset
                  : -(1 - _appearAnimation.value) * widget.config.transformOffset,
              0),
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
                    if (widget.config.enableHapticFeedback) {
                      HapticFeedback.mediumImpact();
                    }
                  }
                : null,
            child: Container(
              margin: widget.config.margin,
              child: Row(
                mainAxisAlignment:
                    widget.message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Container(
                      padding: widget.config.contentPadding,
                      decoration: widget.config.customDecoration ??
                          BoxDecoration(
                            color: widget.message.isMe
                                ? widget.theme.sentMessageColor
                                : widget.theme.receivedMessageColor,
                            borderRadius:
                                BorderRadius.circular(widget.theme.messageBorderRadius),
                            boxShadow: widget.theme.messageShadow != null
                                ? [widget.theme.messageShadow!]
                                : null,
                          ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildMessageContent(),
                          const SizedBox(height: 2),
                          if (widget.config.showTimestamp)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  _formatTime(widget.message.timestamp),
                                  style: widget.config.timestampStyle ??
                                      TextStyle(
                                        fontSize: 10,
                                        color: (widget.message.isMe
                                                ? widget.theme.sentMessageTextColor
                                                : widget.theme.receivedMessageTextColor)
                                            .withOpacity(0.7),
                                      ),
                                ),
                                if (widget.message.isMe &&
                                    widget.config.showReadStatus &&
                                    widget.showStatus)
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