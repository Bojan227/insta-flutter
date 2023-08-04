import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pettygram_flutter/api/pettygram_repo_impl.dart';
import 'package:pettygram_flutter/blocs/posts/post_bloc.dart';
import 'package:pettygram_flutter/models/post.dart';
import 'package:pettygram_flutter/models/post_body.dart';
import 'package:pettygram_flutter/models/token.dart';
import 'package:pettygram_flutter/storage/shared_preferences.dart';
import 'package:test/test.dart';

class MockPettygramRepo extends Mock implements PettygramRepository {}

class MockStorage extends Mock implements SharedPreferencesConfig {}

void main() {
  group("PostBloc", () {
    group(
      'should emit',
      () {
        final MockPettygramRepo mockPettygramRepo = MockPettygramRepo();
        final MockStorage mockStorage = MockStorage();

        blocTest(
          'nothing when no event is added',
          build: () => PostBloc(
              pettygramRepository: mockPettygramRepo, storage: mockStorage),
          expect: () => <PostBloc>[],
        );

        blocTest(
          '[PostLoading, PostLoaded] on success request',
          setUp: () => when(() => mockPettygramRepo.getPosts())
              .thenAnswer((invocation) => Future.value([
                    Post(
                        text: 'text',
                        createdBy: const {"test": 'test'},
                        imageUrl: const ['image-test'],
                        createdAt: 'monday')
                  ])),
          build: () => PostBloc(
              pettygramRepository: mockPettygramRepo, storage: mockStorage),
          act: (bloc) => bloc.add(GetPosts()),
          expect: () => <PostState>[
            PostLoading(),
            PostLoaded(
              posts: [
                Post(
                    text: 'text',
                    createdBy: const {"test": 'test'},
                    imageUrl: const ['image-test'],
                    createdAt: 'monday')
              ],
            )
          ],
        );

        blocTest(
          '[UserPostAdding, UserPostAdded] on success request',
          setUp: () => when(() => mockPettygramRepo.addPost(
                  const PostBody(text: 'test', images: ['test image']),
                  Token(accessToken: mockStorage.getString('accessToken')!)))
              .thenAnswer(
            (invocation) async => await Future.value(
              Post(
                  text: 'test',
                  createdBy: const {"test": 'test'},
                  imageUrl: const ['test image'],
                  createdAt: 'monday'),
            ),
          ),
          build: () => PostBloc(
              pettygramRepository: mockPettygramRepo, storage: mockStorage),
          act: (bloc) => bloc.add(const AddPost(
              userPost: PostBody(text: 'test', images: ['test image']))),
          expect: () => <PostState>[
            UserPostAdding(),
            UserPostAdded(
                userPost: Post(
                    text: 'test',
                    createdBy: const {"test": "test"},
                    imageUrl: const ['test image'],
                    createdAt: 'monday'))
          ],
        );
      },
    );
  });
}
