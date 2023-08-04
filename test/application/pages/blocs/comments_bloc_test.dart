import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pettygram_flutter/api/pettygram_repo_impl.dart';
import 'package:pettygram_flutter/blocs/comments/comments_bloc.dart';
import 'package:pettygram_flutter/models/comment.dart';
import 'package:pettygram_flutter/storage/shared_preferences.dart';
import 'package:test/test.dart';

class MockPettygramRepository extends Mock implements PettygramRepository {}

class MockStorage extends Mock implements SharedPreferencesConfig {}

void main() {
  group('CommentsBloc', () {
    group('should emit', () {
      final Comment comment = Comment(
          id: '1',
          comment: 'test comment',
          post: 'post-id',
          createdBy: const {},
          likes: const ['2', '3'],
          createdAt: 'monday');

      final MockPettygramRepository mockPettygramRepository =
          MockPettygramRepository();

      final mockStorage = MockStorage();

      blocTest(
        'nothing when no event is added',
        build: () => CommentsBloc(
            pettygramRepository: mockPettygramRepository, storage: mockStorage),
        expect: () => <CommentsBloc>[],
      );

      blocTest(
        '[CommentsLoading, CommentsLoaded] when GetComments is emmited',
        setUp: () =>
            when(() => mockPettygramRepository.getCommentsByPostId('1'))
                .thenAnswer((invocation) => Future.value([comment])),
        build: () => CommentsBloc(
            pettygramRepository: mockPettygramRepository, storage: mockStorage),
        act: (bloc) => bloc.add(const GetComments(postId: '1')),
        expect: () => <CommentsState>[
          const CommentsLoading(),
          CommentsLoaded(comments: [comment])
        ],
      );
    });
  });
}
