import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pettygram_flutter/data/core/exceptions.dart';
import 'package:pettygram_flutter/data/datasources/pettygram_local_datasource.dart';
import 'package:pettygram_flutter/data/models/comment_model.dart';
import 'package:pettygram_flutter/models/token.dart';
import 'package:pettygram_flutter/storage/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferencesConfig {}

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late PettygramLocalDataSourceImpl pettygramLocal;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    pettygramLocal =
        PettygramLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('get Token test', () {
    final tTokenModel = Token.fromJson(json.decode(fixture('token.json')));

    test(
        'should return Token from SharedPreferences when there is one in the cache',
        () async {
      when(() => mockSharedPreferences.getString(ACCESS_TOKEN))
          .thenReturn(fixture('token.json'));

      final result = await pettygramLocal.getToken();

      verify(() => mockSharedPreferences.getString(ACCESS_TOKEN));
      expect(result, tTokenModel);
    });

    test(
        'should return CacheException from SharedPreferences when there is none in the cache',
        () async {
      when(() => mockSharedPreferences.getString(ACCESS_TOKEN))
          .thenReturn(null);

      final call = pettygramLocal.getToken;

      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });

    group('save Token test', () {
      final tTokenModel = Token(accessToken: 'token test');
      test('should verify that save token is called with correct args',
          () async {
        pettygramLocal.saveToken(tTokenModel);

        final jsonString = json.encode(tTokenModel.toJson());

        verify(
            () => mockSharedPreferences.saveString(ACCESS_TOKEN, jsonString));
      });
    });
  });
}
