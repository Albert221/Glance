import 'package:flutter_test/flutter_test.dart';
import 'package:reddigram/utils/jwt.dart';

void main() {
  test('Repository fetches and maps stuff', () async {
    final token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1NTYzNzk1Mjd9.ahhv8_mBIYfdnrTUqyrgY4ABT5riU-_xACYQ0hQ0fcI';
    expect(jwtExp(token), DateTime.utc(2019, 4, 27, 15, 38, 47));
  });
}
