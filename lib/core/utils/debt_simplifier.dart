import 'dart:math';

class DebtSettlement {
  final String fromUserId;
  final String toUserId;
  final double amount;

  const DebtSettlement({
    required this.fromUserId,
    required this.toUserId,
    required this.amount,
  });

  @override
  String toString() =>
      'DebtSettlement($fromUserId -> $toUserId: $amount)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DebtSettlement &&
          fromUserId == other.fromUserId &&
          toUserId == other.toUserId &&
          amount == other.amount;

  @override
  int get hashCode => Object.hash(fromUserId, toUserId, amount);
}

class DebtSimplifier {
  static List<DebtSettlement> simplify(Map<String, double> balances) {
    final creditors = <_BalanceEntry>[];
    final debtors = <_BalanceEntry>[];

    for (final entry in balances.entries) {
      final rounded = _round(entry.value);
      if (rounded > 0) {
        creditors.add(_BalanceEntry(entry.key, rounded));
      } else if (rounded < 0) {
        debtors.add(_BalanceEntry(entry.key, rounded));
      }
    }

    if (creditors.isEmpty || debtors.isEmpty) {
      return [];
    }

    creditors.sort((a, b) => b.balance.compareTo(a.balance));
    debtors.sort((a, b) => a.balance.compareTo(b.balance));

    final settlements = <DebtSettlement>[];
    var ci = 0;
    var di = 0;

    while (ci < creditors.length && di < debtors.length) {
      final credit = creditors[ci].balance;
      final debt = debtors[di].balance.abs();
      final transfer = _round(min(credit, debt));

      if (transfer > 0) {
        settlements.add(DebtSettlement(
          fromUserId: debtors[di].userId,
          toUserId: creditors[ci].userId,
          amount: transfer,
        ));
      }

      creditors[ci] = _BalanceEntry(
        creditors[ci].userId,
        _round(credit - transfer),
      );
      debtors[di] = _BalanceEntry(
        debtors[di].userId,
        _round(debtors[di].balance + transfer),
      );

      if (_round(creditors[ci].balance) == 0) ci++;
      if (_round(debtors[di].balance) == 0) di++;
    }

    return settlements;
  }

  static double _round(double value) {
    return (value * 100).roundToDouble() / 100;
  }
}

class _BalanceEntry {
  final String userId;
  double balance;

  _BalanceEntry(this.userId, this.balance);
}
