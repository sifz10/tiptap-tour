import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiptap_tour/application/providers/trip_providers.dart';
import 'package:tiptap_tour/application/providers/user_providers.dart';
import 'package:tiptap_tour/presentation/theme/app_colors.dart';
import 'package:tiptap_tour/presentation/theme/glass_theme.dart';

class CreateTripSheet extends ConsumerStatefulWidget {
  const CreateTripSheet({super.key});

  @override
  ConsumerState<CreateTripSheet> createState() => _CreateTripSheetState();
}

class _CreateTripSheetState extends ConsumerState<CreateTripSheet> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedCurrency = 'BDT';
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isLoading = false;

  final _currencies = ['BDT', 'USD', 'EUR', 'GBP', 'INR'];
  final _currencyLabels = {
    'BDT': '৳ Taka',
    'USD': '\$ Dollar',
    'EUR': '€ Euro',
    'GBP': '£ Pound',
    'INR': '₹ Rupee',
  };

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(GlassTheme.borderRadiusLarge),
        ),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.outline,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'New Trip',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Set up your group trip and start tracking expenses.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.6),
                  ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Trip Name',
                hintText: 'e.g. Cox\'s Bazar Weekend',
                prefixIcon: Icon(Icons.flight_takeoff_rounded),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              textCapitalization: TextCapitalization.sentences,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
                hintText: 'Short note about the trip',
                prefixIcon: Icon(Icons.notes_rounded),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Currency',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: _currencies.map((currency) {
                final isSelected = currency == _selectedCurrency;
                return ChoiceChip(
                  label: Text(_currencyLabels[currency]!),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() => _selectedCurrency = currency);
                  },
                  selectedColor: AppColors.primary.withValues(alpha: 0.15),
                  labelStyle: TextStyle(
                    color: isSelected
                        ? AppColors.primary
                        : Theme.of(context).colorScheme.onSurface,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _DatePickerField(
                    label: 'Start Date',
                    date: _startDate,
                    onTap: () => _pickDate(isStart: true),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _DatePickerField(
                    label: 'End Date',
                    date: _endDate,
                    onTap: () => _pickDate(isStart: false),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton.icon(
                onPressed: _isLoading ? null : _createTrip,
                icon: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.add_rounded),
                label: Text(_isLoading ? 'Creating...' : 'Create Trip'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate({required bool isStart}) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart ? (_startDate ?? now) : (_endDate ?? now),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _createTrip() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a trip name')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final currentUser = await ref.read(currentUserProvider.future);
      final userId = currentUser?.id ?? 'default-user';

      await ref.read(createTripProvider.notifier).createTrip(
            name: name,
            description: _descriptionController.text.trim().isEmpty
                ? null
                : _descriptionController.text.trim(),
            baseCurrency: _selectedCurrency,
            createdByUserId: userId,
            startDate: _startDate,
            endDate: _endDate,
          );

      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create trip: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}

class _DatePickerField extends StatelessWidget {
  final String label;
  final DateTime? date;
  final VoidCallback onTap;

  const _DatePickerField({
    required this.label,
    this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.calendar_today_rounded, size: 20),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        ),
        child: Text(
          date != null ? _formatDate(date!) : 'Select',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: date != null
                    ? null
                    : Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.4),
              ),
        ),
      ),
    );
  }

  String _formatDate(DateTime d) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[d.month - 1]} ${d.day}';
  }
}
