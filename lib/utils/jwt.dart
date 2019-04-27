import 'dart:convert';

import 'package:jaguar_jwt/jaguar_jwt.dart';

DateTime jwtExp(String token) {
  try {
    final split = token.split('.');
    final encodedPayload = split[1];
    final decodedPayload = B64urlEncRfc7515.decodeUtf8(encodedPayload);

    final payload = json.decode(decodedPayload);

    return DateTime.fromMillisecondsSinceEpoch(
      payload['exp'] * 1000,
      isUtc: true,
    );
  } on Exception catch (_) {
    return null;
  }
}
