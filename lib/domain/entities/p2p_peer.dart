import 'package:freezed_annotation/freezed_annotation.dart';

part 'p2p_peer.freezed.dart';
part 'p2p_peer.g.dart';

@freezed
class P2PPeer with _$P2PPeer {
  const factory P2PPeer({
    required String deviceId,
    required String displayName,
    String? platform,
    required DateTime lastSeen,
    @Default(false) bool isConnected,
  }) = _P2PPeer;

  factory P2PPeer.fromJson(Map<String, dynamic> json) => _$P2PPeerFromJson(json);
}
