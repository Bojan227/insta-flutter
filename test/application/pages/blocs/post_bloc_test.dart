import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pettygram_flutter/api/pettygram_repo_impl.dart';
import 'package:pettygram_flutter/blocs/posts/post_bloc.dart';
import 'package:pettygram_flutter/models/post.dart';
import 'package:pettygram_flutter/models/post_body.dart';
import 'package:pettygram_flutter/models/token.dart';
import 'package:pettygram_flutter/storage/shared_preferences.dart';
import 'package:pettygram_flutter/utils/enums.dart';
import 'package:test/test.dart';

class MockPettygramRepo extends Mock implements PettygramRepository {}

class MockStorage extends Mock implements SharedPreferencesConfig {}

void main() {
  group("PostBloc", () {
    group(
      'should emit',
      () {
        final Post post = Post(
            text: 'text',
            createdBy: const {"test": 'test'},
            imageUrl: const ['image-test'],
            createdAt: 'monday');

        final MockPettygramRepo mockPettygramRepo = MockPettygramRepo();
        final MockStorage mockStorage = MockStorage();

        blocTest(
          'nothing when no event is added',
          build: () => PostBloc(
              pettygramRepository: mockPettygramRepo, storage: mockStorage),
          expect: () => <PostBloc>[],
        );

        blocTest(
          '[PostLoading, PostLoaded] on when status is initial',
          setUp: () => when(() => mockPettygramRepo.getPosts(0))
              .thenAnswer((invocation) => Future.value([post])),
          build: () => PostBloc(
              pettygramRepository: mockPettygramRepo, storage: mockStorage),
          act: (bloc) => bloc.add(const GetPosts()),
          expect: () => [
            PostState(
              hasReachedMax: false,
              status: Status.success,
              posts: [post],
            )
          ],
        );

        blocTest<PostBloc, PostState>(
          '[UserPostAdding, UserPostAdded] on success request',
          setUp: () => when(() => mockPettygramRepo.addPost(
                  const PostBody(text: 'test', images: ['test image']),
                  Token(accessToken: mockStorage.getString('accessToken')!)))
              .thenAnswer(
            (_) async => await Future.value(post),
          ),
          build: () => PostBloc(
              pettygramRepository: mockPettygramRepo, storage: mockStorage),
          act: (bloc) => bloc.add(const AddPost(
              userPost: PostBody(text: 'test', images: ['test image']))),
          expect: () => <PostState>[
            const PostState(
              addPostStatus: Status.loading,
            ),
            const PostState(addPostStatus: Status.success, posts: [])
          ],
        );
      },
    );
  });
}
