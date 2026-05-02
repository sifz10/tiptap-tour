import 'package:freezed_annotation/freezed_annotation.dart';

part 'settlement.freezed.dart';
part 'settlement.g.dart';

@freezed
class Settlement with _$Settlement {
  const factory Settlement({
    required String id,
    required String tripId,
    required String payerId,
    required String payeeId,
    required double amount,
    @Default('BDT') String currency,
    required DateTime settledAt,
    String? notes,
    @Default(false) bool isDeleted,
    required String hlcTimestamp,
  }) = _Settlement;

  factory Settlement.fromJson(Map<String, dynamic> json) => _$SettlementFromJson(json);
}
