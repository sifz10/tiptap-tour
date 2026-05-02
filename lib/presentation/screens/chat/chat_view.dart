import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiptap_tour/application/providers/chat_providers.dart';
import 'package:tiptap_tour/application/providers/user_providers.dart';
import 'package:tiptap_tour/infrastructure/database/app_database.dart';
import 'package:tiptap_tour/presentation/theme/app_animations.dart';
import 'package:tiptap_tour/presentation/theme/app_colors.dart';
import 'package:tiptap_tour/presentation/widgets/chat_bubble.dart';
import 'package:tiptap_tour/presentation/widgets/empty_state.dart';
import 'package:tiptap_tour/presentation/widgets/error_state.dart';

class ChatView extends ConsumerStatefulWidget {
  final String tripId;

  const ChatView({super.key, required this.tripId});

  @override
  ConsumerState<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends ConsumerState<ChatView> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  String? _replyToId;
  String? _replyToContent;
  String? _replyToSender;

  String get _currentUserId {
    final settingsBox = Hive.box('settings');
    return settingsBox.get('userId', defaultValue: '') as String;
  }

  @override
  void initState() {
    super.initState();
    ref.listenManual(chatP2PListenerProvider(widget.tripId), (_, _) {});
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messagesAsync = ref.watch(messagesByTripProvider(widget.tripId));
    final membersAsync = ref.watch(usersByTripProvider(widget.tripId));

    return Column(
      children: [
        Expanded(
          child: messagesAsync.when(
            data: (messages) {
              if (messages.isEmpty) {
                return const EmptyState(
                  icon: Icons.chat_bubble_outline_rounded,
                  title: 'No Messages Yet',
                  subtitle:
                      'Start chatting with your\ntrip members!',
                );
              }

              final memberMap = <String, String>{};
              final members = membersAsync.valueOrNull ?? [];
              for (final m in members) {
                memberMap[m.id] = m.displayName;
              }

              final reversed = messages.reversed.toList();

              return ListView.builder(
                controller: _scrollController,
                reverse: true,
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final prevMessage =
                      index < messages.length - 1 ? messages[index + 1] : null;

                  final isMe = message.senderId == _currentUserId;
                  final senderName =
                      memberMap[message.senderId] ?? 'Unknown';

                  final showSender = !isMe &&
                      (prevMessage == null ||
                          prevMessage.senderId != message.senderId ||
                          _isDifferentDay(
                            prevMessage.sentAt,
                            message.sentAt,
                          ));

                  final showDate = prevMessage == null ||
                      _isDifferentDay(prevMessage.sentAt, message.sentAt);

                  final time = _formatTime(message.sentAt);

                  String? replyPreview;
                  if (message.replyToId != null) {
                    final replyMsg = reversed.cast<Message?>().firstWhere(
                          (m) => m?.id == message.replyToId,
                          orElse: () => null,
                        );
                    replyPreview = replyMsg?.content ?? 'Message';
                  }

                  final isSystemOrExpense =
                      message.messageType == 'system' ||
                          message.messageType == 'expenseUpdate';

                  return Column(
                    children: [
                      if (showDate)
                        DateSeparator(
                          label: _formatDateLabel(message.sentAt),
                        ),
                      if (isSystemOrExpense)
                        SystemMessageBubble(
                          content: message.content ?? '',
                          time: time,
                          isExpenseUpdate:
                              message.messageType == 'expenseUpdate',
                        )
                      else
                        ChatBubble(
                          content: message.content ?? '',
                          senderName: senderName,
                          isMe: isMe,
                          showSender: showSender,
                          time: time,
                          imagePath: message.imagePath,
                          replyPreview: replyPreview,
                          onLongPress: () =>
                              _showMessageActions(context, message, senderName),
                        ),
                    ],
                  );
                },
              );
            },
            loading: () =>
                const Center(child: CircularProgressIndicator()),
            error: (e, _) => ErrorState(
              message: e.toString(),
              onRetry: () =>
                  ref.invalidate(messagesByTripProvider(widget.tripId)),
            ),
          ),
        ),
        if (_replyToId != null) _buildReplyBanner(),
        _buildMessageInput(context),
      ],
    );
  }

  Widget _buildReplyBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withAlpha(10),
        border: Border(
          top: BorderSide(
            color: AppColors.primary.withAlpha(51),
          ),
          left: BorderSide(
            color: AppColors.primary,
            width: 3,
          ),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.reply_rounded,
              size: 18, color: AppColors.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _replyToSender ?? '',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  _replyToContent ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withAlpha(153),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 18),
            onPressed: () => setState(() {
              _replyToId = null;
              _replyToContent = null;
              _replyToSender = null;
            }),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: AppAnimations.fast)
        .slideY(begin: 0.3, duration: AppAnimations.fast);
  }

  Widget _buildMessageInput(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        12,
        8,
        12,
        8 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(
            color:
                Theme.of(context).colorScheme.outline.withAlpha(51),
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.add_photo_alternate_outlined),
            onPressed: _pickImage,
            color: AppColors.primary,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest
                    .withAlpha(128),
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: _messageController,
                textCapitalization: TextCapitalization.sentences,
                minLines: 1,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon:
                  const Icon(Icons.send_rounded, color: Colors.white),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    ref.read(sendMessageProvider.notifier).sendTextMessage(
          tripId: widget.tripId,
          content: text,
          replyToId: _replyToId,
        );

    _messageController.clear();
    setState(() {
      _replyToId = null;
      _replyToContent = null;
      _replyToSender = null;
    });

    _scrollToBottom();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 75,
    );

    if (image == null) return;

    ref.read(sendMessageProvider.notifier).sendImageMessage(
          tripId: widget.tripId,
          imagePath: image.path,
        );

    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: AppAnimations.normal,
          curve: AppAnimations.snappy,
        );
      }
    });
  }

  void _showMessageActions(
    BuildContext context,
    Message message,
    String senderName,
  ) {
    final isMe = message.senderId == _currentUserId;

    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.reply_rounded),
              title: const Text('Reply'),
              onTap: () {
                Navigator.pop(ctx);
                setState(() {
                  _replyToId = message.id;
                  _replyToContent = message.content ?? 'Image';
                  _replyToSender = senderName;
                });
              },
            ),
            if (message.content != null)
              ListTile(
                leading: const Icon(Icons.copy_rounded),
                title: const Text('Copy Text'),
                onTap: () {
                  Navigator.pop(ctx);
                  // Clipboard.setData not imported to keep clean, can add
                },
              ),
            if (isMe)
              ListTile(
                leading: const Icon(Icons.delete_outline_rounded,
                    color: AppColors.error),
                title: const Text('Delete',
                    style: TextStyle(color: AppColors.error)),
                onTap: () {
                  Navigator.pop(ctx);
                  _deleteMessage(message.id);
                },
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteMessage(String messageId) async {
    ref.read(deleteMessageProvider.notifier).deleteMessage(messageId);
  }

  bool _isDifferentDay(int ts1, int ts2) {
    final d1 = DateTime.fromMillisecondsSinceEpoch(ts1);
    final d2 = DateTime.fromMillisecondsSinceEpoch(ts2);
    return d1.year != d2.year || d1.month != d2.month || d1.day != d2.day;
  }

  String _formatTime(int timestamp) {
    final dt = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour < 12 ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  String _formatDateLabel(int timestamp) {
    final dt = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDay = DateTime(dt.year, dt.month, dt.day);

    if (messageDay == today) return 'Today';
    if (messageDay == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    }

    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[dt.month - 1]} ${dt.day}, ${dt.year}';
  }
}
