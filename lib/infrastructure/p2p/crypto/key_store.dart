import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:hive_flutter/hive_flutter.dart';

class P2PKeyStore {
  static const _privateKeyKey = 'p2pX25519PrivateKey';
  static const _publicKeyKey = 'p2pX25519PublicKey';

  final Box _settingsBox;
  final X25519 _x25519 = X25519();

  P2PKeyStore(this._settingsBox);

  Future<SimpleKeyPair> loadOrCreateIdentity() async {
    final privateKeyBase64 = _settingsBox.get(_privateKeyKey) as String?;
    final publicKeyBase64 = _settingsBox.get(_publicKeyKey) as String?;

    if (privateKeyBase64 != null && publicKeyBase64 != null) {
      return SimpleKeyPairData(
        base64Decode(privateKeyBase64),
        publicKey: SimplePublicKey(
          base64Decode(publicKeyBase64),
          type: KeyPairType.x25519,
        ),
        type: KeyPairType.x25519,
      );
    }

    final keyPair = await _x25519.newKeyPair();
    final privateKeyBytes = await keyPair.extractPrivateKeyBytes();
    final publicKey = await keyPair.extractPublicKey();

    await _settingsBox.put(_privateKeyKey, base64Encode(privateKeyBytes));
    await _settingsBox.put(_publicKeyKey, base64Encode(publicKey.bytes));

    return SimpleKeyPairData(
      privateKeyBytes,
      publicKey: publicKey,
      type: KeyPairType.x25519,
    );
  }
}
