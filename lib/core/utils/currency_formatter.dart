import 'package:intl/intl.dart';

class CurrencyFormatter {
  static const _currencySymbols = {
    'BDT': '৳',
    'USD': '\$',
    'EUR': '€',
    'GBP': '£',
    'INR': '₹',
  };

  static String format(double amount, {String currency = 'BDT'}) {
    final symbol = _currencySymbols[currency] ?? currency;
    final formatter = NumberFormat.currency(
      symbol: symbol,
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }

  static double parse(String formatted, {String currency = 'BDT'}) {
    final symbol = _currencySymbols[currency] ?? currency;
    final formatter = NumberFormat.currency(
      symbol: symbol,
      decimalDigits: 2,
    );
    return formatter.parse(formatted).toDouble();
  }
}
