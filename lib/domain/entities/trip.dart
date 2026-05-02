import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip.freezed.dart';
part 'trip.g.dart';

@freezed
class Trip with _$Trip {
  const factory Trip({
    required String id,
    required String name,
    String? description,
    String? coverImagePath,
    @Default('BDT') String baseCurrency,
    required String createdBy,
    DateTime? startDate,
    DateTime? endDate,
    @Default(false) bool isArchived,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String hlcTimestamp,
  }) = _Trip;

  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);
}
