import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pettygram_flutter/api/pettygram_repo_impl.dart';
import 'package:pettygram_flutter/blocs/comments/comments_bloc.dart';
import 'package:pettygram_flutter/models/comment.dart';
import 'package:pettygram_flutter/models/comment_body.dart';
import 'package:pettygram_flutter/models/token.dart';
import 'package:pettygram_flutter/storage/shared_preferences.dart';
import 'package:pettygram_flutter/utils/enums.dart';
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
        expect: () => [
          const CommentsState(
              comments: [],
              status: Status.loading,
              newCommentStatus: Status.initial,
              editStatus: Status.initial),
          CommentsState(
              comments: [comment],
              status: Status.success,
              newCommentStatus: Status.initial,
              editStatus: Status.initial)
        ],
      );

      blocTest(
        '[NewCommentLoading, NewCommentLoaded] when AddComment is emmited',
        setUp: () => when(() => mockPettygramRepository.addComment(
                const CommentBody(comment: 'new-comment', post: 'post-id'),
                Token(accessToken: mockStorage.getString('accessToken')!)))
            .thenAnswer(
                (invocation) async => await Future.value("Comment Added")),
        build: () => CommentsBloc(
            pettygramRepository: mockPettygramRepository, storage: mockStorage),
        act: (bloc) => bloc.add(const AddComment(
            commentBody: CommentBody(comment: 'new-comment', post: 'post-id'))),
        expect: () => [
          const CommentsState(
              comments: [],
              status: Status.initial,
              newCommentStatus: Status.loading,
              editStatus: Status.initial),
          const CommentsState(
              comments: [],
              status: Status.initial,
              newCommentStatus: Status.success,
              editStatus: Status.initial)
        ],
      );
    });
  });
}
