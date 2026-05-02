import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiptap_tour/application/providers/expense_providers.dart';
import 'package:tiptap_tour/application/providers/user_providers.dart';
import 'package:tiptap_tour/core/constants/category_constants.dart';
import 'package:tiptap_tour/core/utils/currency_formatter.dart';
import 'package:tiptap_tour/domain/enums/split_type.dart';
import 'package:tiptap_tour/presentation/theme/app_colors.dart';
import 'package:tiptap_tour/presentation/theme/glass_theme.dart';
import 'package:tiptap_tour/presentation/widgets/avatar_circle.dart';

class AddExpenseSheet extends ConsumerStatefulWidget {
  final String tripId;
  final String currency;

  const AddExpenseSheet({
    super.key,
    required this.tripId,
    required this.currency,
  });

  @override
  ConsumerState<AddExpenseSheet> createState() => _AddExpenseSheetState();
}

class _AddExpenseSheetState extends ConsumerState<AddExpenseSheet> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();

  ExpenseCategory _selectedCategory = ExpenseCategory.food;
  SplitType _splitType = SplitType.equal;
  String? _paidByUserId;
  bool _isLoading = false;

  final Map<String, double> _customSplits = {};
  final Map<String, bool> _selectedMembers = {};

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final membersAsync = ref.watch(usersByTripProvider(widget.tripId));

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
              'Add Expense',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 24),

            // Amount input
            TextField(
              controller: _amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
              decoration: InputDecoration(
                labelText: 'Amount',
                prefixText: widget.currency == 'BDT'
                    ? '৳ '
                    : widget.currency == 'USD'
                        ? '\$ '
                        : '${widget.currency} ',
                prefixStyle:
                    Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                hintText: '0.00',
              ),
            ),
            const SizedBox(height: 16),

            // Title
            TextField(
              controller: _titleController,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'What was it for?',
                hintText: 'e.g. Lunch at Sea Beach',
                prefixIcon: Icon(Icons.description_outlined),
              ),
            ),
            const SizedBox(height: 20),

            // Category selector
            Text(
              'Category',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 42,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: ExpenseCategory.values.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final cat = ExpenseCategory.values[index];
                  final isSelected = cat == _selectedCategory;
                  return GestureDetector(
                    onTap: () =>
                        setState(() => _selectedCategory = cat),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? cat.color
                            : cat.color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            cat.icon,
                            size: 18,
                            color:
                                isSelected ? Colors.white : cat.color,
                          ),
                          if (isSelected) ...[
                            const SizedBox(width: 6),
                            Text(
                              cat.displayName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Paid by
            membersAsync.when(
              data: (members) {
                if (_paidByUserId == null && members.isNotEmpty) {
                  _paidByUserId = members.first.id;
                  for (final m in members) {
                    _selectedMembers.putIfAbsent(m.id, () => true);
                  }
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Paid by',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 56,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: members.length,
                        separatorBuilder: (_, _) =>
                            const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          final member = members[index];
                          final isSelected =
                              member.id == _paidByUserId;
                          return GestureDetector(
                            onTap: () => setState(
                                () => _paidByUserId = member.id),
                            child: AnimatedContainer(
                              duration:
                                  const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary
                                        .withValues(alpha: 0.12)
                                    : Colors.transparent,
                                borderRadius:
                                    BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary
                                      : Theme.of(context)
                                          .colorScheme
                                          .outline,
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AvatarCircle(
                                    name: member.displayName,
                                    size: 28,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    member.displayName,
                                    style: TextStyle(
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                      color: isSelected
                                          ? AppColors.primary
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Split type
                    Text(
                      'Split',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 8),
                    SegmentedButton<SplitType>(
                      segments: const [
                        ButtonSegment(
                            value: SplitType.equal, label: Text('Equal')),
                        ButtonSegment(
                            value: SplitType.exact, label: Text('Exact')),
                        ButtonSegment(
                            value: SplitType.percentage,
                            label: Text('Percent')),
                      ],
                      selected: {_splitType},
                      onSelectionChanged: (val) =>
                          setState(() => _splitType = val.first),
                    ),
                    const SizedBox(height: 12),

                    if (_splitType == SplitType.equal)
                      _buildEqualSplit(members)
                    else if (_splitType == SplitType.exact)
                      _buildExactSplit(members)
                    else
                      _buildPercentageSplit(members),
                  ],
                );
              },
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('Error loading members: $e'),
            ),

            const SizedBox(height: 16),
            TextField(
              controller: _notesController,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Notes (optional)',
                prefixIcon: Icon(Icons.notes_rounded),
              ),
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton.icon(
                onPressed: _isLoading ? null : _addExpense,
                icon: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.check_rounded),
                label: Text(_isLoading ? 'Adding...' : 'Add Expense'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEqualSplit(List<dynamic> members) {
    final selectedCount =
        _selectedMembers.values.where((v) => v).length;
    final amount =
        double.tryParse(_amountController.text) ?? 0;
    final perPerson =
        selectedCount > 0 ? amount / selectedCount : 0.0;

    return Column(
      children: [
        ...members.map((member) {
          final isSelected = _selectedMembers[member.id] ?? true;
          return CheckboxListTile(
            value: isSelected,
            onChanged: (val) {
              setState(() => _selectedMembers[member.id] = val ?? true);
            },
            title: Text(member.displayName),
            subtitle: isSelected
                ? Text(CurrencyFormatter.format(perPerson,
                    currency: widget.currency))
                : null,
            secondary: AvatarCircle(name: member.displayName, size: 36),
            dense: true,
            contentPadding: EdgeInsets.zero,
          );
        }),
      ],
    );
  }

  Widget _buildExactSplit(List<dynamic> members) {
    return Column(
      children: [
        ...members.map((member) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                AvatarCircle(name: member.displayName, size: 32),
                const SizedBox(width: 10),
                Expanded(child: Text(member.displayName)),
                SizedBox(
                  width: 100,
                  child: TextField(
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true),
                    decoration: InputDecoration(
                      prefixText: widget.currency == 'BDT' ? '৳' : '',
                      hintText: '0',
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 10),
                    ),
                    onChanged: (val) {
                      _customSplits[member.id] =
                          double.tryParse(val) ?? 0;
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildPercentageSplit(List<dynamic> members) {
    return Column(
      children: [
        ...members.map((member) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                AvatarCircle(name: member.displayName, size: 32),
                const SizedBox(width: 10),
                Expanded(child: Text(member.displayName)),
                SizedBox(
                  width: 80,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      suffixText: '%',
                      hintText: '0',
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 8, vertical: 10),
                    ),
                    onChanged: (val) {
                      _customSplits[member.id] =
                          double.tryParse(val) ?? 0;
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Future<void> _addExpense() async {
    final amount = double.tryParse(_amountController.text);
    final title = _titleController.text.trim();

    if (title.isEmpty) {
      _showError('Please enter a description');
      return;
    }
    if (amount == null || amount <= 0) {
      _showError('Please enter a valid amount');
      return;
    }
    if (_paidByUserId == null) {
      _showError('Please select who paid');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final members =
          await ref.read(usersByTripProvider(widget.tripId).future);
      final Map<String, double> splits = {};

      if (_splitType == SplitType.equal) {
        final selected = members
            .where((m) => _selectedMembers[m.id] ?? true)
            .toList();
        if (selected.isEmpty) {
          _showError('Select at least one member');
          setState(() => _isLoading = false);
          return;
        }
        final perPerson = amount / selected.length;
        for (final m in selected) {
          splits[m.id] = perPerson;
        }
      } else if (_splitType == SplitType.exact) {
        for (final m in members) {
          final splitAmount = _customSplits[m.id] ?? 0;
          if (splitAmount > 0) splits[m.id] = splitAmount;
        }
        final total =
            splits.values.fold(0.0, (sum, v) => sum + v);
        if ((total - amount).abs() > 0.01) {
          _showError(
              'Split amounts must equal total (${CurrencyFormatter.format(amount, currency: widget.currency)})');
          setState(() => _isLoading = false);
          return;
        }
      } else {
        double totalPct = 0;
        for (final m in members) {
          final pct = _customSplits[m.id] ?? 0;
          totalPct += pct;
          if (pct > 0) splits[m.id] = amount * pct / 100;
        }
        if ((totalPct - 100).abs() > 0.01) {
          _showError('Percentages must add up to 100%');
          setState(() => _isLoading = false);
          return;
        }
      }

      await ref.read(addExpenseProvider.notifier).addExpense(
            tripId: widget.tripId,
            paidBy: _paidByUserId!,
            title: title,
            amount: amount,
            category: _selectedCategory.name,
            splitType: _splitType,

            splits: splits,
            notes: _notesController.text.trim().isEmpty
                ? null
                : _notesController.text.trim(),
            currency: widget.currency,
          );

      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      _showError('Failed to add expense: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
