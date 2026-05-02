import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tiptap_tour/application/providers/user_providers.dart';
import 'package:tiptap_tour/presentation/theme/app_animations.dart';
import 'package:tiptap_tour/presentation/theme/app_colors.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _nameController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              Icon(
                Icons.flight_takeoff_rounded,
                size: 80,
                color: AppColors.primary,
              )
                  .animate()
                  .fadeIn(duration: AppAnimations.slow)
                  .scale(
                    begin: const Offset(0.5, 0.5),
                    curve: AppAnimations.entrance,
                    duration: AppAnimations.slow,
                  ),
              const SizedBox(height: 24),
              Text(
                'Tiptap Tour',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              )
                  .animate()
                  .fadeIn(
                    duration: AppAnimations.normal,
                    delay: const Duration(milliseconds: 200),
                  ),
              const SizedBox(height: 12),
              Text(
                'Split expenses, chat offline,\nand enjoy your trip!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.7),
                    ),
              )
                  .animate()
                  .fadeIn(
                    duration: AppAnimations.normal,
                    delay: const Duration(milliseconds: 350),
                  ),
              const Spacer(),
              TextField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
                decoration: InputDecoration(
                  hintText: 'Your name',
                  hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.3),
                      ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                ),
              )
                  .animate()
                  .fadeIn(
                    duration: AppAnimations.normal,
                    delay: const Duration(milliseconds: 500),
                  )
                  .slideY(
                    begin: 0.1,
                    duration: AppAnimations.normal,
                    delay: const Duration(milliseconds: 500),
                    curve: AppAnimations.springLike,
                  ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton.icon(
                  onPressed: _isLoading ? null : _getStarted,
                  icon: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.arrow_forward_rounded),
                  label: Text(_isLoading ? 'Setting up...' : 'Get Started'),
                ),
              )
                  .animate()
                  .fadeIn(
                    duration: AppAnimations.normal,
                    delay: const Duration(milliseconds: 650),
                  ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getStarted() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await ref.read(createUserProvider.notifier).createUser(
            displayName: name,
          );

      final settingsBox = Hive.box('settings');
      await settingsBox.put('isFirstLaunch', false);

      if (mounted) context.go('/');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Something went wrong: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}
