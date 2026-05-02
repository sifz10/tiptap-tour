import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tiptap_tour/presentation/theme/app_colors.dart';
import 'package:tiptap_tour/presentation/theme/glass_theme.dart';
import 'package:tiptap_tour/presentation/widgets/avatar_circle.dart';

class ChatBubble extends StatelessWidget {
  final String content;
  final String senderName;
  final bool isMe;
  final bool showSender;
  final String time;
  final String? imagePath;
  final String? replyPreview;
  final VoidCallback? onLongPress;

  const ChatBubble({
    super.key,
    required this.content,
    required this.senderName,
    required this.isMe,
    this.showSender = true,
    required this.time,
    this.imagePath,
    this.replyPreview,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Padding(
      padding: EdgeInsets.only(
        left: isMe ? 48 : 0,
        right: isMe ? 0 : 48,
        top: showSender ? 12 : 3,
        bottom: 1,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe && showSender)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: AvatarCircle(name: senderName, size: 28),
            )
          else if (!isMe)
            const SizedBox(width: 36),
          Flexible(
            child: GestureDetector(
              onLongPress: onLongPress,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: isMe
                      ? AppColors.primary
                      : brightness == Brightness.light
                          ? Colors.white
                          : AppColors.surfaceDarkElevated,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(18),
                    topRight: const Radius.circular(18),
                    bottomLeft: Radius.circular(isMe ? 18 : 4),
                    bottomRight: Radius.circular(isMe ? 4 : 18),
                  ),
                  border: isMe
                      ? null
                      : Border.all(
                          color: brightness == Brightness.light
                              ? AppColors.dividerLight
                              : AppColors.dividerDark,
                          width: 0.5,
                        ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(8),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (showSender && !isMe)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          senderName,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _senderColor(senderName),
                          ),
                        ),
                      ),
                    if (replyPreview != null)
                      Container(
                        margin: const EdgeInsets.only(bottom: 6),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: isMe
                              ? Colors.white.withAlpha(25)
                              : AppColors.primary.withAlpha(15),
                          borderRadius: BorderRadius.circular(8),
                          border: Border(
                            left: BorderSide(
                              color: isMe
                                  ? Colors.white.withAlpha(128)
                                  : AppColors.primary,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Text(
                          replyPreview!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: isMe
                                ? Colors.white.withAlpha(179)
                                : Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withAlpha(153),
                          ),
                        ),
                      ),
                    if (imagePath != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 200,
                            maxWidth: 250,
                          ),
                          child: Image.file(
                            File(imagePath!),
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => Container(
                              height: 100,
                              color: Colors.grey.withAlpha(51),
                              child: const Center(
                                child: Icon(Icons.broken_image_outlined),
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (imagePath != null && content.isNotEmpty)
                      const SizedBox(height: 6),
                    if (content.isNotEmpty)
                      Text(
                        content,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.35,
                          color: isMe
                              ? Colors.white
                              : Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    const SizedBox(height: 3),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        time,
                        style: TextStyle(
                          fontSize: 10,
                          color: isMe
                              ? Colors.white.withAlpha(179)
                              : Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withAlpha(102),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _senderColor(String name) {
    const palette = [
      AppColors.primary,
      AppColors.secondary,
      AppColors.categoryFood,
      AppColors.categoryTransport,
      AppColors.categoryShopping,
      AppColors.info,
    ];
    final hash = name.codeUnits.fold<int>(0, (sum, c) => sum + c);
    return palette[hash % palette.length];
  }
}

class SystemMessageBubble extends StatelessWidget {
  final String content;
  final String time;
  final bool isExpenseUpdate;

  const SystemMessageBubble({
    super.key,
    required this.content,
    required this.time,
    this.isExpenseUpdate = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isExpenseUpdate
                ? AppColors.primary.withAlpha(15)
                : Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest
                    .withAlpha(128),
            borderRadius: BorderRadius.circular(GlassTheme.borderRadiusSmall),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isExpenseUpdate) ...[
                Icon(
                  Icons.receipt_long_rounded,
                  size: 14,
                  color: AppColors.primary.withAlpha(179),
                ),
                const SizedBox(width: 6),
              ],
              Flexible(
                child: Text(
                  content,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withAlpha(153),
                        fontStyle:
                            isExpenseUpdate ? null : FontStyle.italic,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DateSeparator extends StatelessWidget {
  final String label;

  const DateSeparator({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 48),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: Theme.of(context).colorScheme.outline.withAlpha(51),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withAlpha(102),
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          Expanded(
            child: Divider(
              color: Theme.of(context).colorScheme.outline.withAlpha(51),
            ),
          ),
        ],
      ),
    );
  }
}
