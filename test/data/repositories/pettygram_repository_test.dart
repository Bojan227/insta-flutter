import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pettygram_flutter/data/core/exceptions.dart';
import 'package:pettygram_flutter/data/core/failures.dart';
import 'package:pettygram_flutter/data/core/network_info.dart';
import 'package:pettygram_flutter/data/datasources/pettygram_local_datasource.dart';
import 'package:pettygram_flutter/data/datasources/pettygram_remote_datasource.dart';
import 'package:pettygram_flutter/data/models/comment_model.dart';
import 'package:pettygram_flutter/data/repositories/pettygram_repo_impl.dart';
import 'package:pettygram_flutter/domain/entities/comment.dart';

class MockPettygramRemoteDataSource extends Mock
    implements PettygramRemoteDataSource {}

class MockPettygramLocalDataSource extends Mock
    implements PettygramLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late PettygramRepositoryImpl repository;
  late MockPettygramLocalDataSource mockPettygramLocalDataSource;
  late MockPettygramRemoteDataSource mockPettygramRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockPettygramRemoteDataSource = MockPettygramRemoteDataSource();
    mockPettygramLocalDataSource = MockPettygramLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = PettygramRepositoryImpl(
        remoteDataSource: mockPettygramRemoteDataSource,
        localDataSource: mockPettygramLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  group('device is online', () {
    setUp(() async {
      when(() => mockNetworkInfo.isConnected)
          .thenAnswer((invocation) async => true);
    });
    const tPostId = '1';
    CommentModel tCommentModel = const CommentModel(
        id: '1',
        comment: 'test',
        post: 'test',
        createdBy: {},
        likes: ['1'],
        createdAt: '');
    Comment tComment = tCommentModel;

    test('should return remote data when call to remote source is success',
        () async {
      when(() => mockPettygramRemoteDataSource.getCommentsByPostId(tPostId))
          .thenAnswer((invocation) async => Future.value([tCommentModel]));

      final result = await repository.getCommentsByPostId(tPostId);
      verify(() => mockPettygramRemoteDataSource.getCommentsByPostId(tPostId));
      expect(result[0], tComment);
    });

    // test('should return server failure when call to remote source is success',
    //     () async {
    //   when(() => mockPettygramRemoteDataSource.getCommentsByPostId(tPostId))
    //       .thenAnswer((invocation) async => ServerException());

    //   final result = await repository.getCommentsByPostId(tPostId);
    //   verify(() => mockPettygramRemoteDataSource.getCommentsByPostId(tPostId));
    //   expect(result, ServerFailure());

    //   // expect(result[0], tComment);
    // });
  });
}
