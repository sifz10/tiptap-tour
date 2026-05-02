import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiptap_tour/application/providers/user_providers.dart';
import 'package:tiptap_tour/presentation/theme/app_animations.dart';
import 'package:tiptap_tour/presentation/theme/app_colors.dart';
import 'package:tiptap_tour/presentation/theme/glass_theme.dart';
import 'package:tiptap_tour/presentation/widgets/avatar_circle.dart';
import 'package:tiptap_tour/presentation/widgets/empty_state.dart';
import 'package:tiptap_tour/presentation/widgets/error_state.dart';

class MembersView extends ConsumerWidget {
  final String tripId;

  const MembersView({super.key, required this.tripId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(usersByTripProvider(tripId));

    return usersAsync.when(
      data: (users) {
        if (users.isEmpty) {
          return const EmptyState(
            icon: Icons.people_outline_rounded,
            title: 'No members',
            subtitle: 'Use Nearby to discover and add trip members',
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _MemberCard(
                name: user.displayName,
                avatarPath: user.avatarPath,
                isFirst: index == 0,
              )
                  .animate()
                  .fadeIn(
                    duration: AppAnimations.normal,
                    delay: AppAnimations.staggerFor(index),
                  )
                  .slideX(
                    begin: 0.03,
                    duration: AppAnimations.normal,
                    delay: AppAnimations.staggerFor(index),
                    curve: AppAnimations.springLike,
                  ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => ErrorState(
        message: e.toString(),
        onRetry: () => ref.invalidate(usersByTripProvider(tripId)),
      ),
    );
  }
}

class _MemberCard extends StatelessWidget {
  final String name;
  final String? avatarPath;
  final bool isFirst;

  const _MemberCard({
    required this.name,
    this.avatarPath,
    this.isFirst = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: GlassTheme.glass(
        brightness: Theme.of(context).brightness,
        radius: GlassTheme.borderRadiusSmall,
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          AvatarCircle(
            name: name,
            imagePath: avatarPath,
            size: 44,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                if (isFirst)
                  Text(
                    'Admin',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
              ],
            ),
          ),
          Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: AppColors.success,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
