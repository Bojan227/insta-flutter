import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pettygram_flutter/api/pettygram_repo_impl.dart';
import 'package:pettygram_flutter/blocs/posts/post_bloc.dart';
import 'package:pettygram_flutter/models/post.dart';
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
      },
    );
  });
}
