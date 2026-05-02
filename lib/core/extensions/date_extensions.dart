import 'package:intl/intl.dart';

extension DateExtensions on DateTime {
  int get toEpochMs => millisecondsSinceEpoch;

  String toRelativeString() {
    final now = DateTime.now();
    final diff = now.difference(this);

    if (diff.isNegative) return DateFormat('MMM d').format(this);

    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) {
      final mins = diff.inMinutes;
      return '$mins min${mins == 1 ? '' : 's'} ago';
    }
    if (diff.inHours < 24) {
      final hours = diff.inHours;
      return '$hours hour${hours == 1 ? '' : 's'} ago';
    }
    if (diff.inDays == 1) return 'Yesterday';
    return DateFormat('MMM d').format(this);
  }

  String toShortDate() => DateFormat('MMM d, y').format(this);

  String toTimeString() => DateFormat('h:mm a').format(this);
}
