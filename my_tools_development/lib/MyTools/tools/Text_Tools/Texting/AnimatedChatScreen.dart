import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

// Message model to store different types of messages
class ChatMessage {
  /// Unique identifier for the message
  /// 
  /// Used to distinguish between messages and for updating specific messages
  /// Example: "msg_123456789"
  final String id;

  /// The content of the message
  /// 
  /// For text messages, contains the message text
  /// For media messages, contains caption or description
  /// For emoji messages, contains the emoji character(s)
  final String text;

  /// Flag indicating if the message was sent by the current user
  /// 
  /// When true, message is displayed as sent by the current user (usually right-aligned)
  /// When false, message is displayed as received from another user (usually left-aligned)
  final bool isMe;

  /// The date and time when the message was sent
  /// 
  /// Used for sorting messages chronologically and displaying time information
  /// Example: DateTime.now()
  final DateTime timestamp;

  /// The type of the message content
  /// 
  /// Determines how the message content is rendered (text, image, video, etc.)
  /// Example: MessageType.text, MessageType.image
  final MessageType type;

  /// URL for media content (images, videos, audio, files)
  /// 
  /// Used to load and display media content within the message
  /// Example: "https://example.com/image.jpg"
  final String? mediaUrl;

  /// List of emoji reactions added to this message
  /// 
  /// Used to display user reactions below the message
  /// Example: ["👍", "❤️", "😊"]
  final List<String> reactions;

  /// Flag indicating if this is a newly created message
  /// 
  /// When true, can trigger special animations or behaviors for new messages
  /// Default: false
  final bool isNew;

  /// Additional custom data for the message
  /// 
  /// Used to store application-specific information not covered by other fields
  /// Example: {"translated_text": "Hello in Spanish", "original_language": "en"}
  final Map<String, dynamic>? metadata;

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

  /// Create a modern light theme with enhanced visuals
  /// 
  /// Provides a more polished, contemporary appearance with carefully selected colors
  static ChatTheme modernLight() {
    return ChatTheme(
      primaryColor: Color(0xFF4A6FFF),
      secondaryColor: Color(0xFF8E8E93),
      backgroundColor: Color(0xFFF9F9F9),
      sentMessageColor: Color(0xFF4A6FFF),
      receivedMessageColor: Color(0xFFEEEEEE),
      sentMessageTextColor: Colors.white,
      receivedMessageTextColor: Color(0xFF1A1A1A),
      timestampColor: Color(0xFF8E8E93),
      appBarColor: Color(0xFF4A6FFF),
      inputBarColor: Colors.white,
      hintTextColor: Color(0xFFBDBDBD),
      fontFamily: 'SF Pro Display',
      fontSize: 16.0,
      messageBorderRadius: 20.0,
      showUserAvatar: true,
      showSentStatus: true,
      brightness: Brightness.light,
      messageShadow: BoxShadow(
        color: Colors.black12,
        blurRadius: 3,
        offset: Offset(0, 1),
      ),
      messagePadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
    );
  }
  
  /// Create a sleek dark theme with enhanced visuals
  /// 
  /// Provides a modern dark appearance with careful attention to contrast and readability
  static ChatTheme modernDark() {
    return ChatTheme(
      primaryColor: Color(0xFF4A6FFF),
      secondaryColor: Color(0xFF636366),
      backgroundColor: Color(0xFF121212),
      sentMessageColor: Color(0xFF4A6FFF),
      receivedMessageColor: Color(0xFF2C2C2E),
      sentMessageTextColor: Colors.white,
      receivedMessageTextColor: Color(0xFFE5E5E7),
      timestampColor: Color(0xFF8E8E93),
      appBarColor: Color(0xFF1C1C1E),
      inputBarColor: Color(0xFF1C1C1E),
      hintTextColor: Color(0xFF8E8E93),
      fontFamily: 'SF Pro Display',
      fontSize: 16.0,
      messageBorderRadius: 20.0,
      showUserAvatar: true,
      showSentStatus: true,
      brightness: Brightness.dark,
      messageShadow: BoxShadow(
        color: Colors.black38,
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
      messagePadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
    );
  }
}

// Configuration for user profiles
class UserProfile {
  /// Unique identifier for the user
  /// 
  /// Used to distinguish between different users in the chat
  /// Example: "user_123"
  final String id;

  /// Display name of the user
  /// 
  /// Shown in chat headers, avatars, and potentially in message bubbles
  /// Example: "John Doe"
  final String name;

  /// URL to the user's avatar image
  /// 
  /// Used to display user profile picture in chat UI
  /// Example: "https://example.com/avatar.jpg"
  final String? avatarUrl;

  /// Background color for text-based avatars
  /// 
  /// Used when avatarUrl is null to create a colored circle with initials
  /// Example: Colors.blue
  final Color? avatarColor;

  /// Flag indicating the user's online status
  /// 
  /// When true, user is shown as online with indicators
  /// When false, user is shown as offline
  /// Default: false
  final bool isOnline;

  /// Custom status message for the user
  /// 
  /// Displays additional user status information (e.g., "Away", "In a meeting")
  /// Example: "Available"
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
  /// Margin around each message bubble
  /// 
  /// Controls spacing between consecutive message bubbles
  /// Example: EdgeInsets.symmetric(horizontal: 8, vertical: 4)
  final EdgeInsets margin;

  /// Duration of the appear animation for new messages
  /// 
  /// Controls how long it takes for new messages to fully appear
  /// Example: Duration(milliseconds: 300)
  final Duration appearAnimationDuration;

  /// Animation curve for message appearance
  /// 
  /// Controls the easing function of the appear animation
  /// Example: Curves.easeOutCubic
  final Curve appearAnimationCurve;

  /// Offset for transform animation during appearance
  /// 
  /// Controls how far messages slide in during animation
  /// Example: 50.0 (pixels)
  final double transformOffset;

  /// Flag to enable haptic feedback on message actions
  /// 
  /// When true, device provides haptic feedback when interacting with messages
  /// Example: true
  final bool enableHapticFeedback;

  /// Padding inside the message bubble
  /// 
  /// Controls spacing between bubble edges and message content
  /// Example: EdgeInsets.all(12)
  final EdgeInsets contentPadding;

  /// Font size for text messages
  /// 
  /// Controls the size of text within message bubbles
  /// Example: 16.0
  final double fontSize;

  /// Size for emoji-only messages
  /// 
  /// Controls the size of emojis when message type is emoji
  /// Example: 32.0
  final double emojiSize;

  /// Maximum width for media content in messages
  /// 
  /// Limits how wide images, videos, etc. can be in a message
  /// Example: 200.0
  final double maxWidth;

  /// Maximum height for media content in messages
  /// 
  /// Limits how tall images, videos, etc. can be in a message
  /// Example: 200.0
  final double maxHeight;

  /// Flag to show/hide message timestamps
  /// 
  /// When true, displays time message was sent
  /// Example: true
  final bool showTimestamp;

  /// Flag to show/hide read receipts for messages
  /// 
  /// When true, displays read status indicators for messages
  /// Example: true
  final bool showReadStatus;

  /// Custom text style for timestamp text
  /// 
  /// Allows customization of timestamp appearance
  /// Example: TextStyle(fontSize: 10, color: Colors.grey)
  final TextStyle? timestampStyle;

  /// Custom decoration for message bubbles
  /// 
  /// Allows complete customization of the bubble appearance
  /// Example: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(20))
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
  
  /// Creates an enhanced message bubble configuration with modern styling
  /// 
  /// Features larger media previews, smoother animations, and refined spacing
  static MessageBubbleConfig modern() {
    return const MessageBubbleConfig(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      appearAnimationDuration: Duration(milliseconds: 350),
      appearAnimationCurve: Curves.easeOutQuint,
      transformOffset: 40,
      enableHapticFeedback: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      fontSize: 16,
      emojiSize: 40,
      maxWidth: 280,  // Wider images for better viewing
      maxHeight: 320, // Taller images for better viewing
      showTimestamp: true,
      showReadStatus: true,
      timestampStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w300),
    );
  }
  
  /// Creates a compact message bubble configuration for dense conversations
  /// 
  /// Features smaller bubbles, tighter spacing, and quicker animations
  static MessageBubbleConfig compact() {
    return const MessageBubbleConfig(
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      appearAnimationDuration: Duration(milliseconds: 200),
      appearAnimationCurve: Curves.easeOut,
      transformOffset: 30,
      enableHapticFeedback: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      fontSize: 14,
      emojiSize: 28,
      maxWidth: 240,
      maxHeight: 180,
      showTimestamp: true,
      showReadStatus: true,
      timestampStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
    );
  }
  
  /// Creates a spacious message bubble configuration for better readability
  /// 
  /// Features generous spacing, larger text, and prominent media displays
  static MessageBubbleConfig spacious() {
    return const MessageBubbleConfig(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      appearAnimationDuration: Duration(milliseconds: 400),
      appearAnimationCurve: Curves.easeOutCubic,
      transformOffset: 50,
      enableHapticFeedback: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      fontSize: 17,
      emojiSize: 48,
      maxWidth: 320,
      maxHeight: 350,
      showTimestamp: true,
      showReadStatus: true,
      timestampStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
    );
  }
}

class InputAreaConfig {
  /// Margin around the input area container
  /// 
  /// Controls the spacing between the input area and surrounding elements
  /// Example: EdgeInsets.all(8)
  final EdgeInsets margin;

  /// Padding inside the input area container
  /// 
  /// Controls the spacing between input area edges and its content
  /// Example: EdgeInsets.symmetric(horizontal: 8)
  final EdgeInsets padding;

  /// Border radius for the input area container
  /// 
  /// Controls the roundness of the input area corners
  /// Example: 24.0
  final double borderRadius;

  /// Size of icons in the input area
  /// 
  /// Controls the dimensions of emoji, attachment, and send icons
  /// Example: 24.0
  final double iconSize;

  /// Color of icons in the input area
  /// 
  /// Controls the tint color of all interactive icons
  /// Example: Colors.blue
  final Color? iconColor;

  /// Flag to show/hide the send button
  /// 
  /// When true, displays the send message button
  /// Example: true
  final bool showSendButton;

  /// Flag to show/hide the emoji picker button
  /// 
  /// When true, displays the emoji selector button
  /// Example: true
  final bool showEmojiButton;

  /// Flag to show/hide the attachment button
  /// 
  /// When true, displays the attach file button
  /// Example: true
  final bool showAttachmentButton;

  /// Custom text style for the input field
  /// 
  /// Controls the appearance of text as user types
  /// Example: TextStyle(fontSize: 16, color: Colors.black)
  final TextStyle? inputTextStyle;

  /// Custom decoration for the input text field
  /// 
  /// Allows complete customization of the text field appearance
  /// Example: InputDecoration(hintText: "Type here...", border: InputBorder.none)
  final InputDecoration? inputDecoration;

  /// Custom decoration for the input area container
  /// 
  /// Allows complete customization of the input area appearance
  /// Example: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(24))
  final BoxDecoration? containerDecoration;

  /// Height of the emoji picker panel
  /// 
  /// Controls the vertical space allocated for the emoji picker
  /// Example: 250.0
  final double emojiPickerHeight;

  /// Number of emoji columns in the picker
  /// 
  /// Controls how many emojis appear in each row of the picker
  /// Example: 7
  final int emojiColumns;

  /// Maximum size of emojis in the picker
  /// 
  /// Controls the display size of individual emojis
  /// Example: 32.0
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
  
  /// Creates a modern, elevated input area with refined styling
  /// 
  /// Features subtle shadows, rounded corners, and optimized spacing
  static InputAreaConfig modern() {
    return InputAreaConfig(
      margin: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      borderRadius: 24,
      iconSize: 24,
      iconColor: const Color(0xFF4A6FFF),
      showSendButton: true,
      showEmojiButton: true,
      showAttachmentButton: true,
      inputTextStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Color(0xFF1A1A1A),
      ),
      containerDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      emojiPickerHeight: 300,
      emojiColumns: 8,
      emojiSizeMax: 32,
    );
  }
  
  /// Creates a compact input area that maximizes message space
  /// 
  /// Features minimal margins and optimized for typing efficiency
  static InputAreaConfig compact() {
    return InputAreaConfig(
      margin: const EdgeInsets.fromLTRB(8, 4, 8, 8),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      borderRadius: 20,
      iconSize: 22,
      showSendButton: true,
      showEmojiButton: true,
      showAttachmentButton: true,
      inputTextStyle: const TextStyle(
        fontSize: 15,
        color: Color(0xFF1A1A1A),
      ),
      containerDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      emojiPickerHeight: 250,
      emojiColumns: 8,
      emojiSizeMax: 28,
    );
  }
  
  /// Creates a prominent input area with clear visual hierarchy
  /// 
  /// Features distinct buttons and generous spacing for easy interaction
  static InputAreaConfig prominent() {
    return InputAreaConfig(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      borderRadius: 28,
      iconSize: 26,
      iconColor: const Color(0xFF4A6FFF),
      showSendButton: true,
      showEmojiButton: true,
      showAttachmentButton: true,
      inputTextStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Color(0xFF1A1A1A),
      ),
      containerDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 3),
            spreadRadius: 1,
          ),
        ],
      ),
      emojiPickerHeight: 320,
      emojiColumns: 8,
      emojiSizeMax: 34,
    );
  }
}

class ReactionConfig {
  /// Height of the reaction selector panel
  /// 
  /// Controls the vertical size of the quick reaction selector
  /// Example: 40.0
  final double selectorHeight;

  /// Border radius for the reaction selector panel
  /// 
  /// Controls the roundness of the reaction selector corners
  /// Example: 24.0
  final double selectorBorderRadius;

  /// Padding inside the reaction selector panel
  /// 
  /// Controls spacing between the selector edges and reaction emojis
  /// Example: EdgeInsets.symmetric(horizontal: 8, vertical: 6)
  final EdgeInsets selectorPadding;

  /// Margin around the reaction selector panel
  /// 
  /// Controls spacing between the selector and other elements
  /// Example: EdgeInsets.symmetric(vertical: 4)
  final EdgeInsets selectorMargin;

  /// Size of reaction emojis in the selector
  /// 
  /// Controls how large each reaction emoji appears
  /// Example: 20.0
  final double reactionSize;

  /// Horizontal spacing between reaction emojis
  /// 
  /// Controls the gap between adjacent reaction options
  /// Example: 4.0
  final double spaceBetweenReactions;

  /// Custom decoration for the reaction selector panel
  /// 
  /// Allows complete customization of the selector appearance
  /// Example: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24))
  final BoxDecoration? selectorDecoration;

  /// Duration of the show/hide animation for the reaction selector
  /// 
  /// Controls how long it takes for the selector to appear/disappear
  /// Example: Duration(milliseconds: 200)
  final Duration showHideAnimationDuration;

  /// Animation curve for the show/hide animation
  /// 
  /// Controls the easing function of the selector appear/disappear animation
  /// Example: Curves.easeInOut
  final Curve showHideCurve;

  const ReactionConfig({
    this.selectorHeight = 60,
    this.selectorBorderRadius = 24,
    this.selectorPadding = const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    this.selectorMargin = const EdgeInsets.symmetric(vertical: 4),
    this.reactionSize = 20,
    this.spaceBetweenReactions = 4,
    this.selectorDecoration,
    this.showHideAnimationDuration = const Duration(milliseconds: 200),
    this.showHideCurve = Curves.easeInOut,
  });
  
  /// Creates a modern, polished reaction selector with refined animations
  /// 
  /// Features elegant transitions, optimized spacing, and smooth animations
  static ReactionConfig modern() {
    return ReactionConfig(
      selectorHeight: 60,  // Reduced height to be more compact
      selectorBorderRadius: 24,  // Slightly less rounded
      selectorPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),  // Less padding
      selectorMargin: const EdgeInsets.symmetric(vertical: 6),  // Less margin
      reactionSize: 24,  // Smaller emoji size
      spaceBetweenReactions: 6,  // Less spacing between emojis
      selectorDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 8,
            offset: const Offset(0, 2),
            spreadRadius: 1,
          ),
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.08),
          width: 0.5,
        ),
      ),
      showHideAnimationDuration: const Duration(milliseconds: 250),
      showHideCurve: Curves.easeOutBack,
    );
  }
  
  /// Creates a compact reaction selector that's subtle but functional
  /// 
  /// Features smaller emojis, tighter spacing, and quicker animations
  static ReactionConfig subtle() {
    return ReactionConfig(
      selectorHeight: 36,
      selectorBorderRadius: 18,
      selectorPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      selectorMargin: const EdgeInsets.symmetric(vertical: 4),
      reactionSize: 18,
      spaceBetweenReactions: 6,
      selectorDecoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      showHideAnimationDuration: const Duration(milliseconds: 180),
      showHideCurve: Curves.easeOut,
    );
  }
  
  /// Creates a bold, prominent reaction selector for emphasis
  /// 
  /// Features larger emojis, clear spacing, and attention-grabbing appearance
  static ReactionConfig prominent() {
    return ReactionConfig(
      selectorHeight: 54,
      selectorBorderRadius: 27,
      selectorPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      selectorMargin: const EdgeInsets.symmetric(vertical: 8),
      reactionSize: 28,
      spaceBetweenReactions: 12,
      selectorDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(27),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 4),
            spreadRadius: 2,
          ),
        ],
      ),
      showHideAnimationDuration: const Duration(milliseconds: 300),
      showHideCurve: Curves.easeOutBack,
    );
  }
}

class CustomizableChatScreen extends StatefulWidget {
  /// Chat title shown in the app bar
  /// 
  /// Example: "Customer Support" or "John Doe"
  final String title;

  /// Your user profile in the conversation
  /// 
  /// Example: UserProfile(id: "user123", name: "John Doe")
  final UserProfile currentUser;

  /// The person you're chatting with (null for system/broadcast messages)
  /// 
  /// Example: UserProfile(id: "support123", name: "Support Agent") 
  final UserProfile? chatPartner;

  /// Starting messages to display when chat first loads
  /// 
  /// Example: [ChatMessage(id: "1", text: "Welcome!", isMe: false)]
  final List<ChatMessage>? initialMessages;

  /// Visual styling for the entire chat UI
  /// 
  /// Example: ChatTheme(primaryColor: Colors.blue, fontSize: 16)
  final ChatTheme theme;

  /// Called when user sends a new message
  /// 
  /// Example: (message) => saveToDatabase(message)
  final MessageSentCallback? onMessageSent;

  /// Called when a new message is received
  /// 
  /// Example: (message) => playNotificationSound()
  final MessageReceivedCallback? onMessageReceived;

  /// Called when a user adds/removes a reaction emoji
  /// 
  /// Example: (message, emoji) => updateReactions(message.id, emoji)
  final ReactionAddedCallback? onReactionAdded;

  /// Called when user selects a file to attach
  /// 
  /// Example: (type) => uploadFile(type)
  final AttachmentPickedCallback? onAttachmentPicked;

  /// Whether to show the emoji picker button (true) or not (false)
  /// 
  /// Default: true
  final bool enableEmojis;

  /// Whether to show the file attachment button (true) or not (false)
  /// 
  /// Default: true
  final bool enableAttachments;

  /// Whether to allow reactions on messages (true) or not (false)
  /// 
  /// Default: true
  final bool enableReactions;

  /// Whether to generate automatic responses for demos/bots (true) or not (false)
  /// 
  /// Default: false
  final bool autoRespond;
  
  /// The text to use for automatic responses when autoRespond is true
  /// 
  /// Example: "Thanks for your message! I'll get back to you soon."
  /// Default: "Thanks for your message! This is an automated response."
  final String autoRespondText;

  /// Placeholder text shown in the empty message input field
  /// 
  /// Example: "Type a message..."
  final String? hintText;

  /// Available emoji reactions when long-pressing a message
  /// 
  /// Example: ['👍', '❤️', '😂', '😮', '😢', '👏']
  final List<String>? quickReactions;

  /// Whether to show "typing..." indicators (true) or not (false)
  /// 
  /// Default: true
  final bool showTypingIndicator;

  /// Whether to show message read status (true) or not (false)
  /// 
  /// Default: true
  final bool showReadReceipts;

  /// Optional widget to display at the top of the chat area
  /// 
  /// Example: NotificationBanner() or ConnectionStatusBar()
  final Widget? header;

  /// Optional widget to display at the bottom of the chat area
  /// 
  /// Example: AdBanner() or SuggestedRepliesBar()
  final Widget? footer;

  /// Custom builder function for complete message bubble customization
  /// 
  /// Example: (context, message) => YourCustomBubble(message)
  final Widget Function(BuildContext, ChatMessage)? customMessageBuilder;

  /// How fast the chat should scroll when new messages arrive
  /// 
  /// Example: Duration(milliseconds: 300)
  final Duration? autoScrollDuration;

  /// URL to your profile picture
  /// 
  /// Example: "https://example.com/your-avatar.jpg"
  final String? myImageUrl;

  /// URL to your chat partner's profile picture
  /// 
  /// Example: "https://example.com/their-avatar.jpg"
  final String? otherImageUrl;

  /// Whether to display the top app bar (true) or hide it (false)
  /// 
  /// Default: true
  final bool showAppBar;

  /// Customize the appearance and behavior of message bubbles
  /// 
  /// Example: MessageBubbleConfig(maxWidth: 280, fontSize: 16)
  final MessageBubbleConfig messageBubbleConfig;

  /// Customize the appearance and behavior of the message input area
  /// 
  /// Example: InputAreaConfig(borderRadius: 24, iconSize: 24)
  final InputAreaConfig inputAreaConfig;

  /// Customize the appearance and behavior of emoji reaction selectors
  /// 
  /// Example: ReactionConfig(selectorHeight: 40, reactionSize: 20)
  final ReactionConfig reactionConfig;

  /// Standard set of quick reactions - the classic basics
  static const List<String> standardReactions = ['👍', '❤️', '😂', '😮', '😢', '👏'];
  
  /// Expanded set of quick reactions with more emotional range
  static const List<String> expandedReactions = ['👍', '❤️', '😂', '😮', '😢', '😡', '👏', '🔥', '🎉'];
  
  /// Business-appropriate reactions for professional settings
  static const List<String> businessReactions = ['👍', '👌', '✅', '❓', '⭐', '🚩'];
  
  /// Playful reactions for casual conversations
  static const List<String> playfulReactions = ['😂', '🤣', '😍', '🤩', '😱', '🤯', '🤪', '💯'];

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
    this.autoRespondText = "Thanks for your message! This is an automated response.",
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
        text: widget.autoRespondText,
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

  void _addReaction(ChatMessage message, String reaction) {
    // Only one reaction per message - replace existing reaction if any
    List<String> updatedReactions = message.reactions.contains(reaction)
        ? [] // Remove the reaction if it was already there (toggle)
        : [reaction]; // Otherwise add just this reaction
    
    setState(() {
      final newMessages = _messages.map((m) {
        if (m.id == message.id) {
          return m.copyWith(reactions: updatedReactions);
        }
        return m;
      }).toList();
      _messages.clear();
      _messages.addAll(newMessages);
    });
  
    if (widget.onReactionAdded != null) {
      widget.onReactionAdded!(message, reaction);
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
  /// The message data to display in the bubble
  /// 
  /// Contains all information about the message including text, type, sender, etc.
  /// Example: ChatMessage(id: "123", text: "Hello", isMe: true, ...)
  final ChatMessage message;

  /// Theme configuration for the chat UI
  /// 
  /// Controls colors, fonts, sizes, and other visual properties of the message bubble
  /// Example: ChatTheme(sentMessageColor: Colors.blue, receivedMessageColor: Colors.grey)
  final ChatTheme theme;

  /// Callback function for when a reaction is added to a message
  ///
  /// Triggered when user taps on a reaction emoji
  /// Example: (message, emoji) => updateMessageReaction(message.id, emoji)
  final Function(ChatMessage, String)? onReactionTap;

  /// Animation controller for the typing indicator
  /// 
  /// Controls the animation of the typing indicator dots
  /// Used to create a pulsing effect for the typing status
  final AnimationController typingAnimation;

  /// Animation controller for new message appearance
  /// 
  /// Controls the animation that plays when a new message appears
  /// Used for sliding/fading in effects for new messages
  final AnimationController newMessageAnimation;

  /// Flag indicating if this message is newly added
  /// 
  /// When true, triggers an entry animation for the message
  /// Default: false
  final bool isNew;

  /// Flag to control user avatar visibility
  /// 
  /// When true, shows the avatar next to messages
  /// Default: true
  final bool showAvatar;

  /// Flag to control read receipt visibility
  /// 
  /// When true, shows read status indicators for sent messages
  /// Default: true
  final bool showStatus;

  /// List of quick reaction emojis available
  /// 
  /// Appears when long-pressing a message
  /// Example: ['👍', '❤️', '😂', '😮', '😢', '👏']
  final List<String> quickReactions;

  /// Profile information of the message sender
  /// 
  /// Used to display avatar and name information
  /// Example: UserProfile(id: "user1", name: "John")
  final UserProfile? userProfile;

  /// URL for current user's avatar image
  /// 
  /// Displayed in message bubbles sent by the current user
  /// Example: "https://example.com/avatar.jpg"
  final String? myImageUrl;

  /// URL for chat partner's avatar image
  /// 
  /// Displayed in message bubbles from the chat partner
  /// Example: "https://example.com/partner-avatar.jpg"
  final String? otherImageUrl;

  /// Configuration for message bubble appearance
  /// 
  /// Controls margins, padding, animations, and other visual properties
  /// Example: MessageBubbleConfig(margin: EdgeInsets.all(8), fontSize: 16)
  final MessageBubbleConfig config;

  /// Configuration for reaction selector appearance
  /// 
  /// Controls the look and behavior of the reaction selection UI
  /// Example: ReactionConfig(selectorHeight: 40, reactionSize: 20)
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
        return SelectableText(
          widget.message.text,
          style: TextStyle(
            fontSize: widget.config.emojiSize,
          ),
          enableInteractiveSelection: true,
          toolbarOptions: const ToolbarOptions(
            copy: true,
            selectAll: true,
            cut: false,
            paste: false,
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
                    SelectableText(
                      'File name.pdf',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: widget.message.isMe
                            ? widget.theme.sentMessageTextColor
                            : widget.theme.receivedMessageTextColor,
                      ),
                      enableInteractiveSelection: true,
                      toolbarOptions: const ToolbarOptions(
                        copy: true,
                        selectAll: true,
                        cut: false,
                        paste: false,
                      ),
                    ),
                    SelectableText(
                      '2.5 MB',
                      style: TextStyle(
                        fontSize: 12,
                        color: (widget.message.isMe
                                ? widget.theme.sentMessageTextColor
                                : widget.theme.receivedMessageTextColor)
                            .withOpacity(0.7),
                      ),
                      enableInteractiveSelection: true,
                      toolbarOptions: const ToolbarOptions(
                        copy: true,
                        selectAll: true,
                        cut: false,
                        paste: false,
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
                    SelectableText(
                      '0:42',
                      style: TextStyle(
                        fontSize: 12,
                        color: (widget.message.isMe
                                ? widget.theme.sentMessageTextColor
                                : widget.theme.receivedMessageTextColor)
                            .withOpacity(0.7),
                      ),
                      enableInteractiveSelection: true,
                      toolbarOptions: const ToolbarOptions(
                        copy: true,
                        selectAll: true,
                        cut: false,
                        paste: false,
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
        return SelectableText(
          widget.message.text,
          style: TextStyle(
            color: widget.message.isMe
                ? widget.theme.sentMessageTextColor
                : widget.theme.receivedMessageTextColor,
            fontSize: widget.config.fontSize,
            fontFamily: widget.theme.fontFamily,
          ),
          enableInteractiveSelection: true,
          toolbarOptions: const ToolbarOptions(
            copy: true,
            selectAll: true,
            cut: false,
            paste: false,
          ),
        );
    }
  }

  Widget _buildReactions(ChatMessage message) {
    if (message.reactions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 2),
      child: Align(
        alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.only(
            right: message.isMe ? 16 : 0,
            left: message.isMe ? 0 : 16,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: message.reactions.map((emoji) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: widget.theme.primaryColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
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

    return AnimatedOpacity(
      opacity: _showReactions ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Align(
          alignment: widget.message.isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...widget.quickReactions.map((emoji) {
                  final bool isSelected = widget.message.reactions.contains(emoji);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        widget.onReactionTap!(widget.message, emoji);
                        setState(() {
                          _showReactions = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          emoji,
                          style: const TextStyle(fontSize: 28),
                        ),
                      ),
                    ),
                  );
                }).toList(),
                // Add a small divider
                Container(
                  height: 32,
                  width: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  color: Colors.grey.withOpacity(0.2),
                ),
                // Close button
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    setState(() {
                      _showReactions = false;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(
                      Icons.close,
                      size: 18,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
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
          _buildReactions(widget.message),
          _buildQuickReactionsSelector(),
        ],
      ),
    );
  }
}