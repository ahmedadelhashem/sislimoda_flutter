import 'dart:convert';
import 'package:crypto/crypto.dart';

class EncryptionHelper {
  static String encryptWithPublicKey(
      {required String word, required String publicKey}) {
    String key = '${publicKey}kedjnvjksafdklvnfi';
    var keyBytes = utf8.encode(key);
    var hmacSha256 = Hmac(sha256, keyBytes); // HMAC-SHA256
    var signature = hmacSha256.convert(utf8.encode(word));
    return signature.toString();
  }
}
