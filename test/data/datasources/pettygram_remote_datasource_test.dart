import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:pettygram_flutter/data/core/exceptions.dart';
import 'package:pettygram_flutter/data/datasources/pettygram_remote_datasource.dart';
import 'package:pettygram_flutter/data/models/comment_model.dart';

import '../../core/fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockHttpClient;
  late PettygramRemoteDataSourceImpl pettygramRemoteDataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    pettygramRemoteDataSource =
        PettygramRemoteDataSourceImpl(client: mockHttpClient);
  });

  const tPostId = 'test-id';
  final url = Uri.parse('/posts/$tPostId/comments');

  void setUpMockHttpClientSuccess() {
    when(() => mockHttpClient
            .get(url, headers: {'Content-type': 'application/json'}))
        .thenAnswer(
            (invocation) async => http.Response(fixture('comment.json'), 200));
    when(() => mockHttpClient
            .get(url, headers: {'Content-type': 'application/json'}))
        .thenAnswer(
            (invocation) async => http.Response(fixture('comment.json'), 200));
  }

  void setUpMockHttpClientFailure() {
    when(() => mockHttpClient
            .get(url, headers: {'Content-type': 'application/json'}))
        .thenAnswer(
            (invocation) async => http.Response('something went wrong', 404));
  }

  group('get comments', () {
    final jsonResponse = json.decode(fixture('comment.json'));

    List<CommentModel> comments = [];

    for (var comment in jsonResponse['data']) {
      comments.add(CommentModel.fromJson(comment));
    }

    test(
        'should be called get request with a number in the url and app/json headers',
        () {
      setUpMockHttpClientSuccess();

      pettygramRemoteDataSource.getCommentsByPostId(tPostId);

      verifyNever(() => mockHttpClient.get(
            url,
            headers: {'Content-Type': 'application/json'},
          ));
    });

    test(
        'should return List of comment model when the response code is 200 (success)',
        () async {
      setUpMockHttpClientSuccess();

      final result =
          await pettygramRemoteDataSource.getCommentsByPostId(tPostId);

      expect(result, comments);
    });

    test('should Throw ServerException when the response code is 404',
        () async {
      setUpMockHttpClientFailure();

      final call = pettygramRemoteDataSource.getCommentsByPostId;

      expect(
          () => call(tPostId), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
